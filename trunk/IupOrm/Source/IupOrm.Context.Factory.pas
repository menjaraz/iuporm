unit IupOrm.Context.Factory;

interface

uses
  IupOrm.Context.Properties.Interfaces,
  IupOrm.Context.Interfaces,
  IupOrm.CommonTypes,
  IupOrm.Where, IupOrm.Context.Table.Interfaces, System.Rtti,
  IupOrm.Attributes, System.Generics.Collections;

type

  // Properties builder
  TioContextFactory = class
  public
    // I primi due metodi di classe dovranno essere spostati come protetti o privati
    class function GetProperty(ARttiProperty:TRttiProperty; ASqlFieldName:String; AFieldType:String; ARelationType:TioRelationType; ARelationChildClassRef:TioClassRef; ARelationChildPropertyName:String): IioContextProperty;
    class function Properties(Typ: TRttiInstanceType): IioContextProperties;
    class function ClassFromField(Typ: TRttiInstanceType; ASqlFieldName:String=IO_CLASSFROMFIELD_FIELDNAME): IioClassFromField;
    class function Table(Typ: TRttiInstanceType): IioContextTable;
    class function Where: TioWhere;
    class function Context(AioClassRef:TioClassRef; AioWhere:TioWhere=nil; ADataObject:TObject=nil): IioContext; overload;
  end;

implementation

uses
  IupOrm.Context, IupOrm.Context.Properties,
  System.SysUtils, IupOrm.Context.Table,
  IupOrm.RttiContext.Factory, IupOrm.Context.Container;

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

class function TioContextFactory.Context(AioClassRef: TioClassRef;
  AioWhere: TioWhere; ADataObject: TObject): IioContext;
var
  ARttiContext: TRttiContext;
  ARttiType: TRttiInstanceType;
begin
  // Get the Context from the ContextContainer if exist
  //  and if not exist then create it
  Result := TioContextContainer.GetContext(AioClassRef.ClassName);
  if Assigned(Result) then Exit;
  // Rtti init
  ARttiContext := TioRttiContextFactory.RttiContext;
  ARttiType := ARttiContext.GetType(AioClassRef) as TRttiInstanceType;
  // Create the context
  Result := TioContext.Create(AioClassRef,
                              ARttiContext,
                              ARttiType,
                              Table(ARttiType),
                              Properties(ARttiType),
                              AioWhere,
                              ADataObject
                             );
end;

class function TioContextFactory.GetProperty(ARttiProperty: TRttiProperty;
  ASqlFieldName, AFieldType: String; ARelationType: TioRelationType;
  ARelationChildClassRef: TioClassRef; ARelationChildPropertyName: String): IioContextProperty;
begin
  Result :=  TioProperty.Create(ARttiProperty
                               ,ASqlFieldName
                               ,AFieldType
                               ,ARelationType
                               ,ARelationChildClassRef
                               ,ARelationChildPropertyName
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
  PropSkip: Boolean;
  PropRelationType: TioRelationType;
  PropRelationChildClassRef: TioClassRef;
  PropRelationChildPropertyName: String;
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
      Result.ObjStatusProperty := Self.GetProperty(Prop, '', '', ioRTNone, nil, '');
      Continue;
    end;
    // Prop Init
    PropId := (Prop.Name = 'ID');  // Is a OID property if the name of the property itself is 'ID'
    PropFieldName := Prop.Name;
    PropSkip := False;
    PropRelationType := ioRTNone;
    // Check attributes
    for Attr in Prop.GetAttributes do
    begin
      if Attr is ioOID then PropID := True;
      if Attr is ioField then PropFieldName := ioField(Attr).Value;
      if Attr is ioFieldType then PropFieldType := ioFieldType(Attr).Value;
      if Attr is ioSkip then PropSkip := True;
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
                                                    ,PropFieldType
                                                    ,PropRelationType
                                                    ,PropRelationChildClassRef
                                                    ,PropRelationChildPropertyName
                                                    )
                                    ,PropId
                                    );
  end;
end;

class function TioContextFactory.Table(Typ: TRttiInstanceType): IioContextTable;
var
  Attr: TCustomAttribute;
  TableName: String;
  ClassFromField: IioClassFromField;
begin
  // Prop Init
//  TableName := Typ.ClassName.Substring(1);  // Elimina il primo carattere (di solito la T)
  TableName := Typ.MetaclassType.ClassName.Substring(1);  // Elimina il primo carattere (di solito la T)
  // Check attributes
  for Attr in Typ.GetAttributes do
  begin
    if Attr is ioTable then TableName := ioTable(Attr).Value;
    if Attr is ioClassFromField then ClassFromField := Self.ClassFromField(Typ);
  end;
  // Create result Properties object
  Result := TioContextTable.Create(TableName, ClassFromField);
end;

class function TioContextFactory.Where: TioWhere;
begin
  Result := TioWhere.Create;
end;

end.