unit IupOrm.Context.Properties;

interface

uses
  IupOrm.Context.Properties.Interfaces,
  IupOrm.CommonTypes,
  IupOrm.Attributes,
  IupOrm.SqlItems,
  System.Rtti,
  System.Generics.Collections, IupOrm.Context.Table.Interfaces;

type

  // Classe che rappresenta una propriet�
  TioProperty = class (TInterfacedObject, IioContextProperty)
  strict private
    FIsID: Boolean;
    FRttiProperty: TRttiProperty;
    FTypeAlias: String;
    FFieldDefinitionString, FSqlFieldTableName, FSqlFieldName, FSqlFieldAlias: String;
    FQualifiedSqlFieldName: String;
    FFullQualifiedSqlFieldName: String;
    FLoadSql: String;
    FFieldType: String;
    FRelationType: TioRelationType;
    FRelationChildTypeName: String;
    FRelationChildTypeAlias: String;
    FRelationChildPropertyName: String;
    FRelationLoadType: TioLoadType;
    FTable:IioContextTable;
    FReadWrite: TioReadWrite;
    // NB: Gli altri due attributes (ioEmbeddedSkip e ioEmbeddedStreamable) non sono necessari qui
    //      perch� li usa solo l'ObjectsMappers al suo interno, iupORM non li usa
  strict protected
    constructor Create(const ATypeAlias, AFieldDefinitionString, ALoadSql, AFieldType:String;
      const AReadWrite:TioReadWrite; const ARelationType:TioRelationType; const ARelationChildTypeName, ARelationChildTypeAlias,
      ARelationChildPropertyName:String; const ARelationLoadType:TioLoadType); overload;
  public
    constructor Create(const ARttiProperty:TRttiProperty; const ATypeAlias, AFieldDefinitionString, ALoadSql, AFieldType:String;
      const AReadWrite:TioReadWrite; const ARelationType:TioRelationType; const ARelationChildTypeName, ARelationChildTypeAlias,
      ARelationChildPropertyName:String; const ARelationLoadType:TioLoadType); overload;
    function GetLoadSql: String;
    function LoadSqlExist: Boolean;
    function GetName: String; virtual;
    function GetSqlQualifiedFieldName: String;
    function GetSqlFullQualifiedFieldName: String;
    function GetSqlFieldTableName: String;
    function GetSqlFieldName: String;
    function GetSqlFieldAlias: String;
    function GetSqlParamName: String;
    function GetFieldType: String;
    function IsBlob: Boolean;
    function IsStream: Boolean;
    function GetValue(Instance: Pointer): TValue; virtual;
    function GetValueAsObject(Instance: Pointer): TObject; virtual;
    procedure SetValue(Instance: Pointer; AValue:TValue); virtual;
    function GetSqlValue(ADataObject:TObject): String;
    function GetRttiType: TRttiType; virtual;
    function GetTypeName: String;
    function GetTypeAlias: String;
    function IsInterface: Boolean;
    function GetRelationType: TioRelationType;
    function GetRelationChildTypeName: String;
    function GetRelationChildTypeAlias: String;
    function GetRelationChildPropertyName: String;
    function GetRelationLoadType: TioLoadType;
    function GetRelationChildObject(Instance: Pointer): TObject;
    function GetRelationChildObjectID(const Instance: Pointer): Integer;
    procedure SetTable(ATable:IioContextTable);
    procedure SetFieldData;
    procedure SetLoadSqlData;
    function IsSqlRequestCompliant(ASqlRequestType:TioSqlRequestType): Boolean;
    procedure SetIsID(AValue:Boolean);
    function IsID: Boolean;
    function IsWriteEnabled: Boolean;
    function IsReadEnabled: Boolean;
    function IsInstance: Boolean;
  end;

  // Classe che rappresenta un field della classe
  TioField = class(TioProperty)
  strict private
    FRttiProperty: TRttiField;
    FName: String;
  public
    constructor Create(const ARttiField:TRttiField; const ATypeAlias, AFieldDefinitionString, ALoadSql, AFieldType:String;
      const AReadWrite:TioReadWrite; const ARelationType:TioRelationType; const ARelationChildTypeName, ARelationChildTypeAlias,
      ARelationChildPropertyName:String; const ARelationLoadType:TioLoadType); overload;
    class function Remove_F_FromName(AFieldName:String): String;
    function GetName: String; override;
    function GetValue(Instance: Pointer): TValue; override;
    procedure SetValue(Instance: Pointer; AValue:TValue); override;
    function GetRttiType: TRttiType; override;
  end;


  // Classe con l'elenco delle propriet� della classe
  TioPropertiesGetSqlFunction = reference to function(AProperty:IioContextProperty):String;
  TioProperties = class (TioSqlItem, IioContextProperties)
  strict private
    FPropertyItems: TList<IioContextProperty>;
    FIdProperty: IioContextProperty;
    FObjStatusProperty: IioContextProperty;
    FBlobFieldExists: Boolean;
  strict protected
    function InternalGetSql(ASqlRequestType:TioSqlRequestType; AFunc:TioPropertiesGetSqlFunction): String;
    // ObjectStatus property
    function GetObjStatusProperty: IioContextProperty;
    procedure SetObjStatusProperty(AValue: IioContextProperty);
  public
    constructor Create;
    destructor Destroy; override;
    function GetEnumerator
      : TEnumerator<IioContextProperty>;
    function GetSql: String; overload;
    function GetSql(ASqlRequestType:TioSqlRequestType=ioAll): String; overload;
    procedure Add(AProperty:IioContextProperty; AIsId:Boolean=False);
    function GetIdProperty:IioContextProperty;
    function GetPropertyByName(APropertyName:String): IioContextProperty;
    procedure SetTable(ATable:IioContextTable);
    procedure SetFieldData;
    procedure SetLoadSqlData;
    // Blob field present
    function BlobFieldExists: Boolean;
    // ObjectStatus Exist
    function ObjStatusExist: Boolean;
    // ObjectStatus property
    property ObjStatusProperty:IioContextProperty read GetObjStatusProperty write SetObjStatusProperty;
  end;


implementation

uses
  System.TypInfo, IupOrm.Context.Interfaces, IupOrm.Context.Factory,
  IupOrm.DB.Factory, IupOrm.Exceptions, System.SysUtils, IupOrm.SqlTranslator,
  System.StrUtils, System.Classes, IupOrm.Context.Map.Interfaces;

{ TioProperty }

constructor TioProperty.Create(const ARttiProperty: TRttiProperty; const ATypeAlias, AFieldDefinitionString, ALoadSql,
  AFieldType: String; const AReadWrite: TioReadWrite; const ARelationType: TioRelationType; const ARelationChildTypeName,
  ARelationChildTypeAlias, ARelationChildPropertyName: String; const ARelationLoadType: TioLoadType);
begin
  // NB: No inherited here
  Self.Create(ATypeAlias, AFieldDefinitionString, ALoadSql, AFieldType, AReadWrite,
    ARelationType, ARelationChildTypeName, ARelationChildTypeAlias, ARelationChildPropertyName, ARelationLoadType);
  FRttiProperty := ARttiProperty;
end;

constructor TioProperty.Create(const ATypeAlias, AFieldDefinitionString, ALoadSql, AFieldType: String;
  const AReadWrite: TioReadWrite; const ARelationType: TioRelationType; const ARelationChildTypeName, ARelationChildTypeAlias,
  ARelationChildPropertyName: String; const ARelationLoadType: TioLoadType);
begin
  inherited Create;
  FTypeAlias := ATypeAlias;
  FFieldDefinitionString := AFieldDefinitionString;
  FFieldType := AFieldType;
  FReadWrite := AReadWrite;
  FLoadSql := ALoadSql;
  // Relation fields
  FRelationType := ARelationType;
  FRelationChildTypeName := ARelationChildTypeName;
  FRelationChildTypeAlias := ARelationChildTypeAlias;
  FRelationChildPropertyName := ARelationChildPropertyName;
  FRelationLoadType := ARelationLoadType;
end;

function TioProperty.GetFieldType: String;
begin
  // ================================================================================
  // NB: Questa funzione � usata solo da questa classe stessa (Self.IsBlob) e dalla
  //      creazione automatica del DB per determinare il tipo di campo. Siccome
  //      l'unicoDB per il quale � disponibile la creazione automatica del DB � SQLite
  //      non � necessario che questa funzione si adatti ai diversi RDBMS e quindi la lascio
  //      fissa cos�. Questo va bene anche all'interno della funzione Self.IsBlob
  //      perch� questa verifica solo se il tipo comincia per BLOB e uesto va bene per
  //      qualunque DB.
  // ================================================================================
  // If the FField is not empty then return it
  if not FFieldType.IsEmpty then
    Exit(FFieldType);
  // According to the RelationType of the property...
  case Self.GetRelationType of
    // Normal property, no relation, field type is by TypeKind of the property itself
    ioRTNone: begin
      case Self.GetRttiType.TypeKind of
        tkInt64, tkInteger, tkEnumeration: Result := 'INTEGER';
        tkFloat: Result := 'REAL';
        tkString, tkUString, tkWChar, tkLString, tkWString, tkChar: Result := 'TEXT';
        tkClass, tkInterface: Result := 'BLOB';
      end;
    end;
    // If it is an ioRTEmbedded property then the field type is always BLOB
    ioRTEmbeddedHasMany, ioRTEmbeddedHasOne: Result := 'BLOB';
    // If it's a BelongsTo relation property then field type is always INTEGER
    //  because the ID fields always are INTEGERS values
    ioRTBelongsTo: Result := 'INTEGER';
    // Otherwise return NULL field type
    else Result := 'NULL';
  end;
end;

function TioProperty.GetLoadSql: String;
begin
  Result := '(' + Self.FLoadSql + ') AS ' + Self.GetSqlFieldAlias;
end;

function TioProperty.GetSqlFullQualifiedFieldName: String;
begin
  Result := FFullQualifiedSqlFieldName;
end;

function TioProperty.GetName: String;
begin
  Result := FRttiProperty.Name;
end;

function TioProperty.GetRelationChildTypeAlias: String;
begin
  Result := FRelationChildTypeAlias;
end;

function TioProperty.GetRelationChildTypeName: String;
begin
  Result := FRelationChildTypeName;
end;

function TioProperty.GetRelationChildObject(Instance: Pointer): TObject;
var
  AValue: TValue;
begin
  // Init
  Result := nil;
  // Extract the child related object
  AValue := Self.GetValue(Instance);
  case AValue.TypeInfo.Kind of
    tkClass: Result := AValue.AsObject;
    tkInterface: Result := AValue.AsInterface As TObject;
  end;
end;

function TioProperty.GetRelationChildObjectID(const Instance: Pointer): Integer;
var
  ChildMap: IioMap;
  ChildObject: TObject;
begin
  // Init
  Result := IO_INTEGER_NULL_VALUE;
  // Extract the child related object
  ChildObject := Self.GetRelationChildObject(Instance);
  // If the related child object not exists then exit (return 'NULL')
  if not Assigned(ChildObject) then Exit;
  // Else create the ioContext for the object and return the ID
  ChildMap := TioContextFactory.Map(ChildObject.ClassType);
  Result := ChildMap.GetProperties.GetIdProperty.GetValue(ChildObject).AsInteger;
end;

function TioProperty.GetRelationChildPropertyName: String;
begin
  Result := FRelationChildPropertyName;
end;

function TioProperty.GetRelationLoadType: TioLoadType;
begin
  Result := FRelationLoadType;
end;

function TioProperty.GetRelationType: TioRelationType;
begin
  Result := FRelationType;
end;

function TioProperty.GetRttiType: TRttiType;
begin
  Result := FRttiProperty.PropertyType;
end;

function TioProperty.GetTypeAlias: String;
begin
  Result := FTypeAlias;
end;

function TioProperty.GetTypeName: String;
begin
  Result := Self.GetRttiType.Name;
end;

function TioProperty.GetSqlFieldAlias: String;
begin
  Result := FSqlFieldAlias;
end;

function TioProperty.GetSqlFieldName: String;
begin
  Result := FSqlFieldName;
end;

function TioProperty.GetSqlFieldTableName: String;
begin
  Result := FSqlFieldTableName;
end;

function TioProperty.GetSqlQualifiedFieldName: String;
begin
  Result := FQualifiedSqlFieldName;
end;

function TioProperty.GetSqlParamName: String;
begin
  Result := 'P_' + Self.GetSqlFieldAlias;
end;

function TioProperty.GetSqlValue(ADataObject:TObject): String;
begin
  Result := TioDbFactory.SqlDataConverter.TValueToSql(Self.GetValue(ADataObject));
end;

function TioProperty.GetValue(Instance: Pointer): TValue;
begin
  Result := FRttiProperty.GetValue(Instance);
end;

function TioProperty.GetValueAsObject(Instance: Pointer): TObject;
var
  AValue: TValue;
begin
  AValue := Self.GetValue(Instance);
  case AValue.Kind of
    tkClass:
      Result := AValue.AsObject;
    tkInterface:
      Result := AValue.AsInterface as TObject;
  else EIupOrmException.Create(Self.ClassName + ': The value is not a Class or Interface type.');
  end;
end;

function TioProperty.IsBlob: Boolean;
begin
  Result := ((FRelationType = ioRTNone) or (FRelationType = ioRTEmbeddedHasMany) or (FRelationType = ioRTEmbeddedHasOne))
    and Self.GetFieldType.StartsWith('BLOB');
end;

function TioProperty.IsID: Boolean;
begin
  Result := FIsID;
end;

function TioProperty.IsInstance: Boolean;
begin
  Result := Self.GetRttiType.IsInstance;
end;

function TioProperty.IsInterface: Boolean;
begin
  Result := (Self.GetRttiType.TypeKind = tkInterface);
end;

function TioProperty.IsReadEnabled: Boolean;
begin
  Result := (FReadWrite <= iorwReadWrite);
end;

function TioProperty.IsSqlRequestCompliant(
  ASqlRequestType: TioSqlRequestType): Boolean;
begin
  Result := False;
  case ASqlRequestType of
    ioSelect: Result := (FReadWrite <= iorwReadWrite);
    ioInsert: Result := (FReadWrite >= iorwReadWrite);
    ioUpdate: Result := (FReadWrite >= iorwReadWrite);
  else Result := True;
  end;
end;

function TioProperty.IsStream: Boolean;
begin
  Result := (Self.GetRttiType.IsInstance)
        and (Self.GetRttiType.AsInstance.InheritsFrom(TSTream));
end;

function TioProperty.IsWriteEnabled: Boolean;
begin
  Result := (FReadWrite >= iorwReadWrite);
end;

function TioProperty.LoadSqlExist: Boolean;
begin
  Result := Self.FLoadSql <> '';
end;

procedure TioProperty.SetFieldData;
var
  DotPos, AsPos: Smallint;
  AValue: String;
begin
  AValue := FFieldDefinitionString;
  // Translate (if contains tags)
  AValue := TioSqlTranslator.Translate(AValue);
  // Retrieve the markers position
  DotPos := Pos('.', AValue);
  AsPos := Pos(' AS ', AValue, DotPos);
  if AsPos = 0 then AsPos := AValue.Length+1;
  // Retrieve Table reference
  FSqlFieldTableName := LeftStr(AValue, DotPos-1);
  if FSqlFieldTableName = '' then FSqlFieldTableName := FTable.TableName;
  // Retrieve FieldName
  FSqlFieldName := MidStr(AValue, DotPos+1, AsPos-DotPos-1);
  // Retrieve Field Alias
  FSqlFieldAlias := MidStr(AValue, AsPos+4, AValue.Length);
  if FSqlFieldAlias = '' then FSqlFieldAlias := FSqlFieldTableName + '_' + FSqlFieldName;
  // Set QualifiedFieldName
  FQualifiedSqlFieldName := FSqlFieldTableName + '.' + FSqlFieldName;
  // Set FullQualifiedFieldName
  FFullQualifiedSqlFieldName := FQualifiedSqlFieldName + ' AS ' + FSqlFieldAlias;
end;

procedure TioProperty.SetIsID(AValue: Boolean);
begin
  FisID := AValue;
end;

procedure TioProperty.SetLoadSqlData;
begin
  // Set LoadSql statement (if exist)
  if Self.FLoadSql <> ''
    then FLoadSql := TioSqlTranslator.Translate(FLoadSql);
end;

procedure TioProperty.SetTable(ATable: IioContextTable);
begin
  FTable := ATable;
end;

procedure TioProperty.SetValue(Instance: Pointer; AValue: TValue);
begin
  FRttiProperty.SetValue(Instance, AValue);
end;

{ TioProperties }

procedure TioProperties.Add(AProperty: IioContextProperty; AIsId: Boolean);
begin
  FPropertyItems.Add(AProperty);
  if AIsId then FIdProperty := AProperty;
  AProperty.SetIsID(AIsId);
  if AProperty.IsBlob then Self.FBlobFieldExists := True;
end;

function TioProperties.BlobFieldExists: Boolean;
begin
  Result := FBlobFieldExists;
end;

constructor TioProperties.Create;
begin
  FBlobFieldExists := False;
  FObjStatusProperty := nil;
  FPropertyItems := TList<IioContextProperty>.Create;
end;

destructor TioProperties.Destroy;
begin
  FPropertyItems.Free;
  inherited;
end;

function TioProperties.GetEnumerator
  : TEnumerator<IioContextProperty>;
begin
  Result := FPropertyItems.GetEnumerator;
end;

function TioProperties.GetIdProperty: IioContextProperty;
begin
  Result := FIdProperty;
end;

function TioProperties.GetObjStatusProperty: IioContextProperty;
begin
  Result := FObjStatusProperty;
end;

function TioProperties.GetPropertyByName(
  APropertyName: String): IioContextProperty;
var
  CurrProp: IioContextProperty;
begin
  for CurrProp in FPropertyItems do
  begin
    if CurrProp.GetName.ToUpper.Equals(APropertyName.ToUpper) then
    begin
        Result := CurrProp;
        Exit;
    end;
  end;
  raise EIupOrmException.Create(Self.ClassName +  ': Context property "' + APropertyName + '" not found');
end;

function TioProperties.GetSql: String;
begin
  // Use Internal function with an anonomous method
  Result := Self.InternalGetSql(
    ioAll,
    function (AProp:IioCOntextProperty): String
    begin
      Result := AProp.GetSqlFieldName;
    end
  );
end;


function TioProperties.GetSql(ASqlRequestType: TioSqlRequestType): String;
var
  AFunc: TioPropertiesGetSqlFunction;
begin
  // Get the function by ASqlRequestType value
  case ASqlRequestType of
    ioSelect: AFunc := function (AProp:IioCOntextProperty): String
                       begin
                         if AProp.LoadSqlExist
                           then Result := AProp.GetLoadSql
                           else Result := AProp.GetSqlFullQualifiedFieldName;
                       end;
  else AFunc := function (AProp:IioCOntextProperty): String
                begin
                  Result := AProp.GetSqlFieldName;
                end;
  end;
  // Use Internal function with an anonomous method
  Result := Self.InternalGetSql(ASqlRequestType, AFunc);
end;

function TioProperties.InternalGetSql(ASqlRequestType:TioSqlRequestType;
  AFunc: TioPropertiesGetSqlFunction): String;
var
  Prop: IioContextProperty;
begin
  for Prop in FPropertyItems do
  begin
    // If the property is not compliant with the request then skip it
    if not Prop.IsSqlRequestCompliant(ASqlRequestType) then Continue;
    // If current prop is a list of HasMany related objects skip this property
    if Prop.GetRelationType = ioRTHasMany then Continue;
    // Add the current property
    if Result <> '' then Result := Result + ', ';
    Result := Result + AFunc(Prop);
  end;
end;

function TioProperties.ObjStatusExist: Boolean;
begin
  Result := Assigned(FObjStatusProperty);
end;

procedure TioProperties.SetFieldData;
var
  AProperty: IioContextProperty;
begin
  for AProperty in FPropertyItems
    do AProperty.SetFieldData;
end;

procedure TioProperties.SetLoadSqlData;
var
  AProperty: IioContextProperty;
begin
  for AProperty in FPropertyItems
    do AProperty.SetLoadSqlData;
end;

procedure TioProperties.SetObjStatusProperty(AValue: IioContextProperty);
begin
  FObjStatusProperty := AValue;
end;

procedure TioProperties.SetTable(ATable: IioContextTable);
var
  AProperty: IioContextProperty;
begin
  for AProperty in FPropertyItems do
    AProperty.SetTable(ATable);
end;

{ TioField }

constructor TioField.Create(const ARttiField: TRttiField; const ATypeAlias, AFieldDefinitionString, ALoadSql, AFieldType: String;
  const AReadWrite: TioReadWrite; const ARelationType: TioRelationType; const ARelationChildTypeName, ARelationChildTypeAlias,
  ARelationChildPropertyName: String; const ARelationLoadType: TioLoadType);
begin
  // NB: No inherited here
  Self.Create(ATypeAlias, AFieldDefinitionString, ALoadSql, AFieldType, AReadWrite,
    ARelationType, ARelationChildTypeName, ARelationChildTypeAlias, ARelationChildPropertyName, ARelationLoadType);
  FRttiProperty := ARttiField;
  FName := Self.Remove_F_FromName(ARttiField.Name);
end;

function TioField.GetName: String;
begin
  // No inherited
  Result := FName;
end;

function TioField.GetRttiType: TRttiType;
begin
  // No inherited
  Result := FRttiProperty.FieldType;
end;

function TioField.GetValue(Instance: Pointer): TValue;
begin
  // No inherited
  Result := FRttiProperty.GetValue(Instance);
end;

class function TioField.Remove_F_FromName(AFieldName:String): String;
begin
  if Uppercase(AFieldName).StartsWith('F') then
    Result := AFieldName.Substring(1);  // Elimina il primo carattere (di solito la F)
end;

procedure TioField.SetValue(Instance: Pointer; AValue: TValue);
begin
  // No inherited
  FRttiProperty.SetValue(Instance, AValue);
end;

end.
