unit IupOrm.Context.Factory;

interface

uses
  IupOrm.Context.Properties.Interfaces,
  IupOrm.Context.Interfaces,
  IupOrm.CommonTypes,
  IupOrm.Where, IupOrm.Context.Table.Interfaces, System.Rtti,
  IupOrm.Attributes, System.Generics.Collections,
  IupOrm.Context.Map.Interfaces;

type

  // Properties builder
  TioContextFactory = class
  public
    // I primi due metodi di classe dovranno essere spostati come protetti o privati
    class function GetProperty(const AMapMode:TioMapModeType; const ARttiPropField:TRttiMember; const ATypeAlias, ASqlFieldName, ALoadSql, AFieldType:String;
      const AReadWrite:TioReadWrite; const ARelationType:TioRelationType; const ARelationChildTypeName, ARelationChildTypeAlias,
      ARelationChildPropertyName:String; const ARelationLoadType:TioLoadType): IioContextProperty;
    class function Properties(const Typ: TRttiInstanceType; const AMapMode: TioMapModeType): IioContextProperties;
    class function ClassFromField(Typ: TRttiInstanceType; const ASqlFieldName:String=IO_CLASSFROMFIELD_FIELDNAME): IioClassFromField;
    class function Joins: IioJoins;
    class function JoinItem(const AJoinAttribute:ioJoin): IioJoinItem;
    class function GroupBy(const ASqlText:String): IioGroupBy;
    class function Table(const Typ: TRttiInstanceType): IioContextTable;
    class function Where: TioWhere;
    class function Map(const AClassRef: TioClassRef): IioMap;
    class function Context(const AClassName: String; const AioWhere:TioWhere=nil; const ADataObject:TObject=nil): IioContext;
  end;

implementation

uses
  IupOrm.Context, IupOrm.Context.Properties,
  System.SysUtils, IupOrm.Context.Table,
  IupOrm.RttiContext.Factory, IupOrm.Context.Container, IupOrm.Context.Map,
  System.StrUtils;

{ TioBuilderProperties }

class function TioContextFactory.ClassFromField(Typ: TRttiInstanceType;
  const ASqlFieldName: String): IioClassFromField;
var
  Ancestors, QualifiedClassName, ClassName:String;
begin
  // ClassName
  ClassName := Typ.MetaclassType.ClassName;
  QualifiedClassName := Typ.QualifiedName;
  // Loop for all ancestors
  repeat
    begin
      Ancestors := Ancestors + '<' + Typ.Name + '>';
      Typ := Typ.BaseType;
    end;
  until not Assigned(Typ);
  // Create
  Result := TioClassFromField.Create(ASqlFieldName, ClassName, QualifiedClassName, Ancestors);
end;

class function TioContextFactory.Context(const AClassName: String;
  const AioWhere: TioWhere; const ADataObject: TObject): IioContext;
begin
  // Get the Context from the ContextContainer
  Result := TioContext.Create(AClassName,
                              TioMapContainer.GetMap(AClassName),
                              AioWhere,
                              ADataObject
                              );
end;

class function TioContextFactory.GetProperty(const AMapMode:TioMapModeType; const ARttiPropField: TRttiMember; const ATypeAlias, ASqlFieldName, ALoadSql,
  AFieldType: String; const AReadWrite: TioReadWrite; const ARelationType: TioRelationType; const ARelationChildTypeName,
  ARelationChildTypeAlias, ARelationChildPropertyName: String; const ARelationLoadType: TioLoadType): IioContextProperty;
begin
  case AMapMode of
    // Properties map mode
    ioProperties:
      Result := TioProperty.Create(
         ARttiPropField as TRttiProperty
        ,ATypeAlias
        ,ASqlFieldName
        ,ALoadSql
        ,AFieldType
        ,AReadWrite
        ,ARelationType
        ,ARelationChildTypeName
        ,ARelationChildTypeAlias
        ,ARelationChildPropertyName
        ,ARelationLoadType
      );
    // Fields map mode
    ioFields:
      Result := TioField.Create(
         ARttiPropField as TRttiField
        ,ATypeAlias
        ,ASqlFieldName
        ,ALoadSql
        ,AFieldType
        ,AReadWrite
        ,ARelationType
        ,ARelationChildTypeName
        ,ARelationChildTypeAlias
        ,ARelationChildPropertyName
        ,ARelationLoadType
      );
  end;
end;

class function TioContextFactory.GroupBy(const ASqlText:String): IioGroupBy;
begin
  Result := TioGroupBy.Create(ASqlText);
end;

class function TioContextFactory.JoinItem(const AJoinAttribute:ioJoin): IioJoinItem;
begin
  Result := TioJoinItem.Create(AJoinAttribute.JoinType,
                               AJoinAttribute.JoinClassRef,
                               AJoinAttribute.JoinCondition
                              );
end;

class function TioContextFactory.Joins: IioJoins;
begin
  Result := TioJoins.Create;
end;

class function TioContextFactory.Map(const AClassRef: TioClassRef): IioMap;
var
  ARttiContext: TRttiContext;
  ARttiType: TRttiInstanceType;
  ATable: IioContextTable;
begin
  // Rtti init
  ARttiContext := TioRttiContextFactory.RttiContext;
  ARttiType := ARttiContext.GetType(AClassRef).AsInstance;
  // Get the table
  ATable := Self.Table(ARttiType);
  // Create the context
  Result := TioMap.Create(AClassRef,
                          ARttiContext,
                          ARttiType,
                          ATable,
                          Self.Properties(ARttiType, ATable.GetMapMode)
                         );
end;

class function TioContextFactory.Properties(
  const Typ: TRttiInstanceType; const AMapMode: TioMapModeType): IioContextProperties;
var
  Prop: System.Rtti.TRttiMember;
  PropsFields: TArray<System.Rtti.TRttiMember>;
  Attr: TCustomAttribute;
  PropID: Boolean;
  PropTypeAlias: String;
  PropFieldName: String;
  PropFieldType: String;
  PropLoadSql: String;
  PropSkip: Boolean;
  PropReadWrite: TioReadWrite;
  PropRelationType: TioRelationType;
  PropRelationChildTypeName: String;
  PropRelationChildTypeAlias: String;
  PropRelationChildPropertyName: String;
  PropRelationChildLoadType: TioLoadType;
begin
  // Get members list (Properties or Fields)
  case AMapMode of
    ioProperties:
      PropsFields := TArray<System.Rtti.TRttiMember>(TObject(Typ.AsInstance.GetProperties));
    ioFields:
      PropsFields := TArray<System.Rtti.TRttiMember>(TObject(Typ.AsInstance.GetFields));
  end;
  // Create result Properties object
  Result := TioProperties.Create;
  // Loop all properties
  for Prop in PropsFields do
  begin
    // PropFieldName: if the MapMpde is ioFields then remove the first character ("F" usually)
    PropFieldName := Prop.Name;
    if (AMapMode = ioFields) then
      PropFieldName := TioField.Remove_F_FromName(PropFieldName);  // Elimina il primo carattere (di solito la F)
    // Skip RefCount property from TInterfacedObject
    if (PropFieldName = 'RefCount')
    or (PropFieldName = 'Disposed')
      then Continue;
    // ObjStatus property
    if PropFieldName = 'ObjStatus' then
    begin
      Result.ObjStatusProperty := Self.GetProperty(AMapMode, Prop, '', '', '', '', iorwReadOnly, ioRTNone, '', '', '', ioImmediateLoad);
      Continue;
    end;
    // Prop Init
    PropId := (Uppercase(PropFieldName) = 'ID');  // Is a OID property if the name of the property itself is 'ID'
    PropTypeAlias := '';
    PropFieldType := '';
    PropLoadSql := '';
    PropSkip := False;
    PropReadWrite := iorwReadWrite;
    PropRelationType := ioRTNone;
    PropRelationChildTypeName := '';
    PropRelationChildTypeAlias := '';
    PropRelationChildPropertyName := '';
    PropRelationChildLoadType := ioImmediateLoad;
    // Check attributes
    for Attr in Prop.GetAttributes do
    begin
      if Attr is ioOID then PropID := True;
      if Attr is ioTypeAlias then PropTypeAlias := ioTypeAlias(Attr).Value;
      if Attr is ioField then PropFieldName := ioField(Attr).Value;
      if Attr is ioFieldType then PropFieldType := ioFieldType(Attr).Value;
      if Attr is ioLoadSql then PropLoadSql := ioLoadSql(Attr).Value;
      if Attr is ioSkip then PropSkip := True;
      if Attr is ioReadOnly then PropReadWrite := iorwReadOnly;
      if Attr is ioWriteOnly then PropReadWrite := iorwWriteOnly;
      // Relations
      if Attr is ioEmbeddedHasMany then
      begin
        PropRelationType := ioRTEmbeddedHasMany;
        PropRelationChildTypeName := ioEmbeddedHasMany(Attr).ChildTypeName;
        PropRelationChildTypeAlias := ioEmbeddedHasMany(Attr).ChildTypeAlias;
      end;
      if Attr is ioEmbeddedHasOne then
      begin
        PropRelationType := ioRTEmbeddedHasOne;
        PropRelationChildTypeName := ioEmbeddedHasOne(Attr).ChildTypeName;
        PropRelationChildTypeAlias := ioEmbeddedHasOne(Attr).ChildTypeAlias;
      end;
      if Attr is ioBelongsTo then
      begin
        PropRelationType := ioRTBelongsTo;
        PropRelationChildTypeName := ioBelongsTo(Attr).ChildTypeName;
        PropRelationChildTypeAlias := ioBelongsTo(Attr).ChildTypeAlias;
      end;
      if Attr is ioHasMany then
      begin
        PropRelationType := ioRTHasMany;
        PropRelationChildTypeName := ioHasMany(Attr).ChildTypeName;
        PropRelationChildTypeAlias := ioHasMany(Attr).ChildTypeAlias;
        PropRelationChildPropertyName := ioHasMany(Attr).ChildPropertyName;
        PropRelationChildLoadType := ioHasMany(Attr).LoadType;
      end;
      if Attr is ioHasOne then
      begin
        PropRelationType := ioRTHasOne;
        PropRelationChildTypeName := ioHasOne(Attr).ChildTypeName;
        PropRelationChildTypeAlias := ioHasOne(Attr).ChildTypeAlias;
        PropRelationChildPropertyName := ioHasOne(Attr).ChildPropertyName;
      end;
    end;
    // Create and add property
    if not PropSkip then Result.Add(Self.GetProperty(AMapMode
                                                    ,Prop
                                                    ,PropTypeAlias
                                                    ,PropFieldName
                                                    ,PropLoadSql
                                                    ,PropFieldType
                                                    ,PropReadWrite
                                                    ,PropRelationType
                                                    ,PropRelationChildTypeName
                                                    ,PropRelationChildTypeAlias
                                                    ,PropRelationChildPropertyName
                                                    ,PropRelationChildLoadType)
                                    ,PropId
                                    );
  end;
end;

class function TioContextFactory.Table(const Typ: TRttiInstanceType): IioContextTable;
var
  Attr: TCustomAttribute;
  TableName, ConnectionDefName, AKeyGenerator: String;
  ClassFromField: IioClassFromField;
  AJoins: IioJoins;
  AGroupBy: IioGroupBy;
  AMapMode: TioMapModeType;
begin
  // Prop Init
  TableName := Typ.MetaclassType.ClassName.Substring(1);  // Elimina il primo carattere (di solito la T)
  ConnectionDefName := '';
  AKeyGenerator := '';
  AJoins := Self.Joins;
  AGroupBy := nil;
  AMapMode := ioProperties;
  // Check attributes
  for Attr in Typ.GetAttributes do
  begin
    if (Attr is ioTable) then
    begin
      if not ioTable(Attr).Value.IsEmpty then TableName := ioTable(Attr).Value;
      AMapMode := ioTable(Attr).MapMode;
    end;
    if Attr is ioKeyGenerator then AKeyGenerator := ioKeyGenerator(Attr).Value;
    if Attr is ioConnectionDefName then ConnectionDefName := ioConnectionDefName(Attr).Value;
    if Attr is ioClassFromField then ClassFromField := Self.ClassFromField(Typ);
    if Attr is ioJoin then AJoins.Add(Self.JoinItem(   ioJoin(Attr)   ));
    if (Attr is ioGroupBy) and (not Assigned(AGroupBy)) then AGroupBy := Self.GroupBy(   ioGroupBy(Attr).Value   );
  end;
  // KeyGenerator
  if AKeyGenerator.IsEmpty then AKeyGenerator := TableName;
  // Create result Properties object
  Result := TioContextTable.Create(TableName, AKeyGenerator, ClassFromField, AJoins, AGroupBy, ConnectionDefName, AMapMode);
end;

class function TioContextFactory.Where: TioWhere;
begin
  Result := TioWhere.Create;
end;

end.
