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
    class function GetProperty(ARttiProperty:TRttiProperty; ASqlFieldName:String; ALoadSql:String; AFieldType:String; AReadWrite:TioReadWrite; ARelationType:TioRelationType; ARelationChildClassRef:TioClassRef; ARelationChildPropertyName:String; ARelationLoadType:TioLoadType): IioContextProperty;
    class function Properties(Typ: TRttiInstanceType): IioContextProperties;
    class function ClassFromField(Typ: TRttiInstanceType; ASqlFieldName:String=IO_CLASSFROMFIELD_FIELDNAME): IioClassFromField;
    class function Joins: IioJoins;
    class function JoinItem(const AJoinAttribute:ioJoin): IioJoinItem;
    class function GroupBy(ASqlText:String): IioGroupBy;
    class function Table(Typ: TRttiInstanceType): IioContextTable;
    class function Where: TioWhere;
    class function Map(AClassRef: TioClassRef): IioMap;
    class function Context(AClassName: String; AioWhere:TioWhere=nil; ADataObject:TObject=nil): IioContext;
  end;

implementation

uses
  IupOrm.Context, IupOrm.Context.Properties,
  System.SysUtils, IupOrm.Context.Table,
  IupOrm.RttiContext.Factory, IupOrm.Context.Container, IupOrm.Context.Map;

{ TioBuilderProperties }

class function TioContextFactory.ClassFromField(Typ: TRttiInstanceType;
  ASqlFieldName: String): IioClassFromField;
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

class function TioContextFactory.Context(AClassName: String;
  AioWhere: TioWhere; ADataObject: TObject): IioContext;
begin
  // Get the Context from the ContextContainer
  Result := TioContext.Create(AClassName,
                              TioMapContainer.GetMap(AClassName),
                              AioWhere,
                              ADataObject
                              );
end;

class function TioContextFactory.GetProperty(ARttiProperty: TRttiProperty;
  ASqlFieldName, ALoadSql, AFieldType: String; AReadWrite:TioReadWrite; ARelationType: TioRelationType;
  ARelationChildClassRef: TioClassRef; ARelationChildPropertyName: String;
  ARelationLoadType:TioLoadType): IioContextProperty;
begin
  Result :=  TioProperty.Create(ARttiProperty
                               ,ASqlFieldName
                               ,ALoadSql
                               ,AFieldType
                               ,AReadWrite
                               ,ARelationType
                               ,ARelationChildClassRef
                               ,ARelationChildPropertyName
                               ,ARelationLoadType
                               );
end;


class function TioContextFactory.GroupBy(ASqlText:String): IioGroupBy;
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

class function TioContextFactory.Map(AClassRef: TioClassRef): IioMap;
var
  ARttiContext: TRttiContext;
  ARttiType: TRttiInstanceType;
begin
  // Rtti init
  ARttiContext := TioRttiContextFactory.RttiContext;
  ARttiType := ARttiContext.GetType(AClassRef) as TRttiInstanceType;
  // Create the context
  Result := TioMap.Create(AClassRef,
                          ARttiContext,
                          ARttiType,
                          Self.Table(ARttiType),
                          Self.Properties(ARttiType)
                         );
end;

class function TioContextFactory.Properties(
  Typ: TRttiInstanceType): IioContextProperties;
var
  Prop: TRttiProperty;
  Attr: TCustomAttribute;
  PropID: Boolean;
  PropFieldName: String;
  PropFieldType: String;
  PropLoadSql: String;
  PropSkip: Boolean;
  PropReadWrite: TioReadWrite;
  PropRelationType: TioRelationType;
  PropRelationChildClassRef: TioClassRef;
  PropRelationChildPropertyName: String;
  PropRelationChildLoadType: TioLoadType;
begin
  // Create result Properties object
  Result := TioProperties.Create;
  // Loop all properties
  for Prop in Typ.GetProperties do
  begin
    // Skip RefCount property from TInterfacedObject
    if (Prop.Name = 'RefCount')
    or (Prop.Name = 'Disposed')
      then Continue;
    // ObjStatus property
    if Prop.Name = 'ObjStatus' then
    begin
      Result.ObjStatusProperty := Self.GetProperty(Prop, '', '', '', iorwReadOnly, ioRTNone, nil, '', ioImmediateLoad);
      Continue;
    end;
    // Prop Init
    PropId := (Uppercase(Prop.Name) = 'ID');  // Is a OID property if the name of the property itself is 'ID'
    PropFieldName := Prop.Name;
    PropLoadSql := '';
    PropSkip := False;
    PropReadWrite := iorwReadWrite;
    PropRelationType := ioRTNone;
    PropRelationChildLoadType := ioImmediateLoad;
    // Check attributes
    for Attr in Prop.GetAttributes do
    begin
      if Attr is ioOID then PropID := True;
      if Attr is ioField then PropFieldName := ioField(Attr).Value;
      if Attr is ioFieldType then PropFieldType := ioFieldType(Attr).Value;
      if Attr is ioLoadSql then PropLoadSql := ioLoadSql(Attr).Value;
      if Attr is ioSkip then PropSkip := True;
      if Attr is ioReadOnly then PropReadWrite := iorwReadOnly;
      if Attr is ioWriteOnly then PropReadWrite := iorwWriteOnly;
      if Attr is ioBelongsTo then
      begin
        PropRelationType := ioRTBelongsTo;
        PropRelationChildClassRef := ioBelongsTo(Attr).ChildClassRef;
      end;
      if Attr is ioHasMany then
      begin
        PropRelationType := ioRTHasMany;
        PropRelationChildClassRef := ioHasMany(Attr).ChildClassRef;
        PropRelationChildPropertyName := ioHasMany(Attr).ChildPropertyName;
        PropRelationChildLoadType := ioHasMany(Attr).LoadType;
      end;
      if Attr is ioHasOne then
      begin
        PropRelationType := ioRTHasOne;
        PropRelationChildClassRef := ioHasOne(Attr).ChildClassRef;
        PropRelationChildPropertyName := ioHasOne(Attr).ChildPropertyName;
      end;
    end;
    // Create and add property
    if not PropSkip then Result.Add(Self.GetProperty(Prop
                                                    ,PropFieldName
                                                    ,PropLoadSql
                                                    ,PropFieldType
                                                    ,PropReadWrite
                                                    ,PropRelationType
                                                    ,PropRelationChildClassRef
                                                    ,PropRelationChildPropertyName
                                                    ,PropRelationChildLoadType)
                                    ,PropId
                                    );
  end;
end;

class function TioContextFactory.Table(Typ: TRttiInstanceType): IioContextTable;
var
  Attr: TCustomAttribute;
  TableName, ConnectionDefName: String;
  ClassFromField: IioClassFromField;
  AJoins: IioJoins;
  AGroupBy: IioGroupBy;
begin
  // Prop Init
  TableName := Typ.MetaclassType.ClassName.Substring(1);  // Elimina il primo carattere (di solito la T)
  ConnectionDefName := '';
  AJoins := Self.Joins;
  AGroupBy := nil;
  // Check attributes
  for Attr in Typ.GetAttributes do
  begin
    if Attr is ioTable then TableName := ioTable(Attr).Value;
    if Attr is ioConnectionDefName then ConnectionDefName := ioConnectionDefName(Attr).Value;
    if Attr is ioClassFromField then ClassFromField := Self.ClassFromField(Typ);
    if Attr is ioJoin then AJoins.Add(Self.JoinItem(   ioJoin(Attr)   ));
    if (Attr is ioGroupBy) and (not Assigned(AGroupBy)) then AGroupBy := Self.GroupBy(   ioGroupBy(Attr).Value   );
  end;
  // Create result Properties object
  Result := TioContextTable.Create(TableName, ClassFromField, AJoins, AGroupBy, ConnectionDefName);
end;

class function TioContextFactory.Where: TioWhere;
begin
  Result := TioWhere.Create;
end;

end.
