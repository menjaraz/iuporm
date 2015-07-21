unit IupOrm.DB.QueryEngine;

interface

uses
  IupOrm.Context.Interfaces, IupOrm.DB.Interfaces, IupOrm.Where;

type

  TioQueryEngineRef = class of TioQueryEngine;

  // INterfaccia per le classi che devono generare i vari tipi di query
  //  Select/Update/Insert/Delete
  TioQueryEngine = class
  protected
    class procedure SetIntegerToQueryParamNullIfZero(const AParam:TioParam; const AValue:Integer);
    class function ComposeQueryIdentity(AContext:IioContext; APreIdentity:String; AIdentity:String=''): String;
    class procedure FillQueryWhereParams(AContext:IioContext; AQuery:IioQuery);
//    class procedure PersistRelationChildObject(AMasterContext: IioContext;
//      AMasterProperty: IioContextProperty);
  public
    class function GetQuerySelectForObject(AContext:IioContext): IioQuery;
    class function GetQuerySelectForList(AContext:IioContext): IioQuery;
    class function GetQueryInsert(AContext:IioContext): IioQuery;
    class function GetQueryNextID(AContext:IioContext): IioQuery;
    class function GetQueryUpdate(AContext:IioContext): IioQuery;
    class function GetQueryDelete(AContext:IioContext): IioQuery;
    class function GetQueryForExists(AContext:IioContext): IioQuery;
  end;

implementation

uses
  IupOrm.DB.Factory, IupOrm.Context.Properties.Interfaces, IupOrm.CommonTypes,
  IupOrm.Attributes, Data.DB, IupOrm.Interfaces, SysUtils,
  IupOrm.Where.SqlItems.Interfaces, IupOrm.DB.ConnectionContainer;

{ TioQueryEngine }

class function TioQueryEngine.ComposeQueryIdentity(AContext: IioContext; APreIdentity:String; AIdentity:String=''): String;
begin
  Result := AContext.GetClassRef.QualifiedClassName + ':' + APreIdentity + ':' + AIdentity;
end;

class function TioQueryEngine.GetQueryDelete(AContext: IioContext): IioQuery;
var
  AQuery: IioQuery;
begin
  // Get the query object and if does not contain an SQL text (come from QueryContainer)
  //  then call the sql query generator
  AQuery := TioDbFactory.Query(AContext.GetTable.GetConnectionDefName, ComposeQueryIdentity(AContext, 'DEL'));
  Result := AQuery;
  if AQuery.IsSqlEmpty then TioDBFactory.SqlGenerator.GenerateSqlDelete(AQuery, AContext);
  // If a Where exist then the query is an external query else
  //  is an internal query.
  if AContext.WhereExist then
    Self.FillQueryWhereParams(AContext, AQuery)
  else
    AQuery.ParamByProp(AContext.GetProperties.GetIdProperty).Value := AContext.GetProperties.GetIdProperty.GetValue(AContext.DataObject).AsVariant;
end;

class procedure TioQueryEngine.FillQueryWhereParams(AContext:IioContext; AQuery: IioQuery);
var
  ASqlItem: IioSqlItem;
  ASqlItemWhere: IioSqlItemWhere;
begin
  for ASqlItem in AContext.Where.GetWhereItems do
  begin
    if  Supports(ASqlItem, IioSqlItemWhere, ASqlItemWhere)
    and ASqlItemWhere.HasParameter
    then
      AQuery.ParamByName(   ASqlItemWhere.GetSqlParamName(AContext.GetProperties)   ).Value := ASqlItemWhere.GetValue(AContext.GetProperties).AsVariant;
  end;
  if AContext.IsClassFromField then
    AQuery.ParamByName(AContext.ClassFromField.GetSqlParamName).Value := '%'+AContext.ClassFromField.GetClassName+'%';
end;

class function TioQueryEngine.GetQueryForExists(AContext: IioContext): IioQuery;
var
  AQuery: IioQuery;
begin
  // Get the query object and if does not contain an SQL text (come from QueryContainer)
  //  then call the sql query generator
  AQuery := TioDbFactory.Query(AContext.GetTable.GetConnectionDefName, ComposeQueryIdentity(AContext, 'EXIST'));
  Result := AQuery;
  if AQuery.IsSqlEmpty then TioDBFactory.SqlGenerator.GenerateSqlForExists(AQuery, AContext);
  // If a Where exist then the query is an external query else
  //  is an internal query.
  AQuery.ParamByProp(AContext.GetProperties.GetIdProperty).Value := AContext.GetProperties.GetIdProperty.GetValue(AContext.DataObject).AsVariant;
end;

class function TioQueryEngine.GetQueryInsert(AContext:IioContext): IioQuery;
var
  AProp: IioContextProperty;
  AQuery: IioQuery;
 begin
  // Get the query object and if does not contain an SQL text (come from QueryContainer)
  //  then call the sql query generator
  AQuery := TioDbFactory.Query(AContext.GetTable.GetConnectionDefName, ComposeQueryIdentity(AContext, 'INS'));
  Result := AQuery;
  if AQuery.IsSqlEmpty then TioDBFactory.SqlGenerator.GenerateSqlInsert(AQuery, AContext);
  // Iterate for all properties
  for AProp in AContext.GetProperties do
  begin
    // If the current property is ReadOnly then skip it
    if not AProp.IsSqlRequestCompliant(ioInsert) then Continue;
    // If current property is the ID property and its value is null (0)
    //  then skip its value (always NULL)
    if  AProp.IsID and AContext.IDIsNull then
    begin
      AQuery.SetParamValueToNull(AProp, ftLargeInt);
      Continue;
    end;
    // Relation type
    case AProp.GetRelationType of
      // If RelationType = ioRTNone save the current property value normally
      // If RelationType = ioRTEmbedded save the current property value normally (serialization is into the called method
      ioRTNone, ioRTEmbeddedHasMany, ioRTEmbeddedHasOne: AQuery.SetParamValueByContext(AProp, AContext);
      // else if RelationType = ioRTBelongsTo then save the ID
      ioRTBelongsTo: Self.SetIntegerToQueryParamNullIfZero(   AQuery.ParamByProp(AProp), AProp.GetRelationChildObjectID(AContext.DataObject)   );
      // else if RelationType = ioRTHasOne
      ioRTHasOne: {Nothing};
      // else if RelationType = ioRTHasMany
      ioRTHasMany: {Nothing};
    end;
  end;
  // Add the ClassFromField value if enabled
  if AContext.IsClassFromField then
    AQuery.ParamByName(AContext.ClassFromField.GetSqlParamName).Value := AContext.ClassFromField.GetValue;
end;

class function TioQueryEngine.GetQueryNextID(AContext: IioContext): IioQuery;
begin
  // Get the query object and if does not contain an SQL text (come from QueryContainer)
  //  then call the sql query generator
  Result := TioDbFactory.Query(AContext.GetTable.GetConnectionDefName, ComposeQueryIdentity(AContext, 'LID'));
  if Result.IsSqlEmpty then TioDBFactory.SqlGenerator.GenerateSqlNextID(Result, AContext);
  // If the current connection is for Firebird then set the Generator name param
  if TioConnectionManager.GetConnectionType(AContext.GetConnectionDefName) = cdtFirebird then
    Result.ParamByName('KeyGenerator').Value := AContext.GetTable.GetKeyGenerator;
end;

class function TioQueryEngine.GetQuerySelectForList(AContext: IioContext): IioQuery;
var
  AQuery: IioQuery;
begin
  // Get the query object and if does not contain an SQL text (come from QueryContainer)
  //  then call the sql query generator
  AQuery := TioDbFactory.Query(AContext.GetTable.GetConnectionDefName, ComposeQueryIdentity(AContext, 'SELLST'));
  Result := AQuery;
  if AQuery.IsSqlEmpty then TioDBFactory.SqlGenerator.GenerateSqlSelect(AQuery, AContext);
  // If a Where exist then the query is an external query else
  //  is an internal query.
  if AContext.WhereExist then
    Self.FillQueryWhereParams(AContext, AQuery)
  else
    AQuery.ParamByProp(AContext.GetProperties.GetIdProperty).Value := AContext.GetProperties.GetIdProperty.GetValue(AContext.DataObject).AsVariant;
end;

class function TioQueryEngine.GetQuerySelectForObject(AContext: IioContext): IioQuery;
var
  AQuery: IioQuery;
begin
  // Get the query object and if does not contain an SQL text (come from QueryContainer)
  //  then call the sql query generator
  AQuery := TioDbFactory.Query(AContext.GetTable.GetConnectionDefName, ComposeQueryIdentity(AContext, 'SELOBJ'));
  Result := AQuery;
  if AQuery.IsSqlEmpty then TioDBFactory.SqlGenerator.GenerateSqlSelect(AQuery, AContext);
  // If a Where exist then the query is an external query else
  //  is an internal query.
  if AContext.WhereExist then
    Self.FillQueryWhereParams(AContext, AQuery)
  else
    AQuery.ParamByProp(AContext.GetProperties.GetIdProperty).Value := AContext.GetProperties.GetIdProperty.GetValue(AContext.DataObject).AsVariant;
end;

class function TioQueryEngine.GetQueryUpdate(AContext: IioContext): IioQuery;
var
  AProp: IioContextProperty;
  AQuery: IioQuery;
begin
  // Get the query object and if does not contain an SQL text (come from QueryContainer)
  //  then call the sql query generator
  AQuery := TioDbFactory.Query(AContext.GetTable.GetConnectionDefName, ComposeQueryIdentity(AContext, 'UPD'));
  Result := AQuery;
  if AQuery.IsSqlEmpty then TioDBFactory.SqlGenerator.GenerateSqlUpdate(AQuery, AContext);
  // Iterate for all properties
  for AProp in AContext.GetProperties do
  begin
    // If the current property is ReadOnly then skip it
    if not AProp.IsSqlRequestCompliant(ioUpdate) then Continue;
    // Relation type
    case AProp.GetRelationType of
      // If RelationType = ioRTNone save the current property value normally
      // If RelationType = ioRTEmbedded save the current property value normally (serialization is into the called method
      ioRTNone, ioRTEmbeddedHasMany, ioRTEmbeddedHasOne: AQuery.SetParamValueByContext(AProp, AContext);
      // else if RelationType = ioRTBelongsTo then save the ID
      ioRTBelongsTo: Self.SetIntegerToQueryParamNullIfZero(   AQuery.ParamByProp(AProp), AProp.GetRelationChildObjectID(AContext.DataObject)   );
      // else if RelationType = ioRTHasOne
      ioRTHasOne: {Nothing};
      // else if RelationType = ioRTHasMany
      ioRTHasMany: {Nothing};
    end;
  end;
  // Add the ClassFromField value if enabled
  if AContext.IsClassFromField
  then AQuery.ParamByName(AContext.ClassFromField.GetSqlParamName).Value := AContext.ClassFromField.GetValue;
  // Where conditions
  AQuery.ParamByProp(AContext.GetProperties.GetIdProperty).Value := AContext.GetProperties.GetIdProperty.GetValue(AContext.DataObject).AsVariant;
end;

class procedure TioQueryEngine.SetIntegerToQueryParamNullIfZero(const AParam: TioParam; const AValue: Integer);
begin
  if AValue <> 0 then
    AParam.Value := Avalue
  else
    AParam.Clear;
end;

end.
