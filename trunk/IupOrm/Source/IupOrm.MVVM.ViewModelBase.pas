unit IupOrm.MVVM.ViewModelBase;

interface

uses
  System.Classes, IupOrm.MVVM.Interfaces,
  IupOrm.LiveBindings.PrototypeBindSource, IupOrm.LiveBindings.Interfaces, System.Rtti, IupOrm.Attributes,
  IupOrm.CommonTypes;

type
  TioViewModelBase = class(TDataModule, IioViewModel)
  private
    { Private declarations }
    FViewData: IioViewData;
    FioTypeName, FioTypeAlias: String;
    FioMasterViewModelTypeName, FioMasterViewModelTypeAlias: String;
    FioMasterViewModel: IioViewModel;
    FIoMasterBindSource: TioMasterBindSource;
    FioMasterBindSourceAdapter: IioActiveBindSourceAdapter;
    FIoMasterPropertyName: String;
    FIoWhere: String;
    FioAutoLoadData: Boolean;
    FioViewDataType: TioViewDataType;
    function GetAutoLoadData: Boolean;
    function GetMasterBindSource: TObject;
    function GetMasterPropertyName: String;
    function GetTypeAlias: String;
    function GetTypeName: String;
    function GetViewDataType: TioViewDataType;
    function GetWhere: String;
    procedure SetAutoLoadData(const Value: Boolean);
    procedure SetMasterBindSource(const Value: TObject);
    procedure SetMasterPropertyName(const Value: String);
    procedure SetTypeAlias(const Value: String);
    procedure SetTypeName(const Value: String);
    procedure SetViewDataType(const Value: TioViewDataType);
    procedure SetWhere(const Value: String);
  protected
// ---------------- Start: section added for IInterface support ---------------
{$IFNDEF AUTOREFCOUNT}
    [Volatile] FRefCount: Integer;
{$ENDIF}
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
// ---------------- End: section added for IInterface support ---------------
    procedure ioLoadViewData;
  public
    { Public declarations }

    // Constructors
    constructor Create; overload;  // Non togliere assolutamente altrimenti non vengono più bindate le Actions
    [ioMarker('CreateByDataObject')]
    constructor Create(const ADataObj:TObject; const AViewDataType:TioViewDataType); overload;
    [ioMarker('CreateByDataInterface')]
    constructor Create(const ADataIntf:IInterface; const AViewDataType:TioViewDataType); overload;
    [ioMarker('CreateByClassRef')]
    constructor Create(const AClassRef:TioClassRef; const AioWhere:String; const AViewDataType:TioViewDataType; const AAutoLoadData:Boolean=True); overload;
    [ioMarker('CreateByTypeName')]
    constructor Create(const ATypeName, ATypeAlias:String; const AioWhere:String; const AViewDataType:TioViewDataType; const AAutoLoadData:Boolean=True); overload;
    [ioMarker('CreateByBindSourceAdapter')]
    constructor Create(const ABindSourceAdapter:IioActiveBindSourceAdapter); overload;
    [ioMarker('CreateByMasterBindSource')]
    constructor Create(const AMasterBindSource:TioMasterBindSource; const AMasterPropertyName:String=''); overload;
    [ioMarker('CreateByMasterBindSourceAdapter')]
    constructor Create(const AMasterBindSourceAdapter:IioActiveBindSourceAdapter; const AMasterPropertyName:String=''); overload;
    [ioMarker('CreateByMasterViewModel')]
    constructor Create(const AMasterViewModel:IioViewModel; const AMasterPropertyName:String=''); overload;
    [ioMarker('CreateByMasterViewModelFromDependencyInjection')]
    constructor Create(const AMasterViewModelTypeName, AMasterViewModelTypeAlias:String; const AMasterViewModelMasterPropertyName:String=''); overload;
    // End constructors

    function ViewData: IioViewData;
    function GetActionByName(AActionName: String): TBasicAction;
    procedure BindActions(const AView:IioView);
    procedure BindAction(const AType:TRttiType; const AView:IioView; const AComponentName, AActionName: String);
// ---------------- Start: section added for IInterface support ---------------
{$IFNDEF AUTOREFCOUNT}
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    class function NewInstance: TObject; override;
    property RefCount: Integer read FRefCount;
{$ENDIF}
// ---------------- End: section added for IInterface support ---------------
  published
    property ioTypeName:String read GetTypeName write SetTypeName;
    property ioTypeAlias:String read GetTypeAlias write SetTypeAlias;
    property ioWhere:String read GetWhere write SetWhere;
    property ioMasterBindSource:TObject read GetMasterBindSource write SetMasterBindSource;
    property ioMasterPropertyName:String read GetMasterPropertyName write SetMasterPropertyName;
    property ioAutoLoadData:Boolean read GetAutoLoadData write SetAutoLoadData;
    property ioViewDataType:TioViewDataType read GetViewDataType write SetViewDataType;
  end;
// ---------------- Start: section added for IInterface support ---------------
  {$IFNDEF SYSTEM_HPP_DEFINES_OBJECTS}
//  {$NODEFINE TInterfacedObject}         { defined in systobj.h }
  {$ENDIF}
// ---------------- End: section added for IInterface support ---------------


implementation

uses System.SysUtils, IupOrm.Exceptions, IupOrm.RttiContext.Factory,
  IupOrm.MVVM.Factory, Data.Bind.ObjectScope,
  IupOrm.LiveBindings.Factory, IupOrm, FMX.Dialogs;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TioViewModel }





// ---------------- Start: section added for IInterface support ---------------
{$IFNDEF AUTOREFCOUNT}
procedure TioViewModelBase.AfterConstruction;
begin
// Release the constructor's implicit refcount
  AtomicDecrement(FRefCount);
end;

procedure TioViewModelBase.BeforeDestruction;
begin
  if RefCount <> 0 then
    Error(reInvalidPtr);
end;

class function TioViewModelBase.NewInstance: TObject;
begin
  Result := inherited NewInstance;
  TioViewModelBase(Result).FRefCount := 1;
end;
{$ENDIF}
// ---------------- End: section added for IInterface support ---------------









function TioViewModelBase.GetActionByName(AActionName: String): TBasicAction;
var
  AObj: TObject;
begin
  // Init
  Result := nil;
  AObj := nil;
  if AActionName.Trim = '' then raise EIupOrmException.Create(ClassName + ': invalid action name!');
  // Find the action
  AObj := FindComponent(AActionName);
  // If found then return the action itself
  if Assigned(AObj) and (AObj is TBasicAction) then
    Exit(AObj as TBasicAction);
  // Else raise an exception
  raise EIupOrmException.Create(ClassName + ': action "' + AActionName + '" not found!');
end;

function TioViewModelBase.GetAutoLoadData: Boolean;
begin
  Result := FioAutoLoadData;
end;

function TioViewModelBase.GetMasterBindSource: TObject;
begin
  Result := FIoMasterBindSource;
end;

function TioViewModelBase.GetMasterPropertyName: String;
begin
  Result := FIoMasterPropertyName;
end;

function TioViewModelBase.GetTypeAlias: String;
begin
  Result := FioTypeAlias;
end;

function TioViewModelBase.GetTypeName: String;
begin
  Result := FioTypeName;
end;

function TioViewModelBase.GetViewDataType: TioViewDataType;
begin
  Result := FioViewDataType;
end;

function TioViewModelBase.GetWhere: String;
begin
  Result := FIoWhere;
end;

procedure TioViewModelBase.BindAction(const AType:TRttiType; const AView:IioView; const AComponentName, AActionName: String);
var
  AObj: TObject;
  AProp: TRttiProperty;
  AAction: TBasicAction;
  AValue: TValue;
begin
  // Get RttiProperty
  AProp := AType.GetProperty('Action');
  if not Assigned(AProp) then EIupOrmException.Create(Self.ClassName + ': RttiProperty not found!');
  // Get the object
  AObj := AView.FindComponent(AComponentName);
  if not Assigned(AObj) then EIupOrmException.Create(Self.ClassName + ': View component not found!');
  // Get action
  AAction := Self.GetActionByName(AActionName);
  if not Assigned(AAction) then EIupOrmException.Create(Self.ClassName + ': Action not found!');
  // Set the action property of the object
  AValue := TValue.From<TBasicAction>(AAction);
  AProp.SetValue(AObj, AValue);
end;

procedure TioViewModelBase.BindActions(const AView: IioView);
var
  Typ: TRttiType;
  Fld: TRttiField;
  Attr: TCustomAttribute;
begin
  // Retrieve the RttiType of the view
  Typ := TioRttiContextFactory.RttiContext.GetType((AView as TObject).ClassType);
  for Fld in Typ.GetFields do
    for Attr in Fld.GetAttributes do
      if Attr is ioAction then
        Self.BindAction(Fld.FieldType, AView, Fld.Name, ioAction(Attr).Value);
end;

constructor TioViewModelBase.Create(const ADataObj: TObject; const AViewDataType:TioViewDataType);
begin
  inherited Create(nil);
  FViewData := TioMVVMFactory.ViewData(ADataObj, AViewDataType);
end;

constructor TioViewModelBase.Create(const ABindSourceAdapter: IioActiveBindSourceAdapter);
begin
  inherited Create(nil);
  FViewData := TioMVVMFactory.ViewData(ABindSourceAdapter);
end;









function TioViewModelBase.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := E_NOINTERFACE;
end;

procedure TioViewModelBase.SetAutoLoadData(const Value: Boolean);
begin
  FioAutoLoadData := Value;
end;

procedure TioViewModelBase.SetMasterBindSource(const Value: TObject);
begin
  FIoMasterBindSource := Value as TioMasterBindSource;
end;

procedure TioViewModelBase.SetMasterPropertyName(const Value: String);
begin
  FIoMasterPropertyName := Value;
end;

procedure TioViewModelBase.SetTypeAlias(const Value: String);
begin
  FioTypeAlias := Value;
end;

procedure TioViewModelBase.SetTypeName(const Value: String);
begin
  FioTypeName := Value;
end;

procedure TioViewModelBase.SetViewDataType(const Value: TioViewDataType);
begin
  FioViewDataType := Value;
end;

procedure TioViewModelBase.SetWhere(const Value: String);
begin
  FIoWhere := Value;
end;

function TioViewModelBase.ViewData: IioViewData;
begin
  if not Assigned(FViewData) then
  begin
    Self.ioLoadViewData;
  end;
  Result := FViewData;
end;

function TioViewModelBase._AddRef: Integer;
begin
{$IFNDEF AUTOREFCOUNT}
  Result := AtomicIncrement(FRefCount);
{$ELSE}
  Result := __ObjAddRef;
{$ENDIF}
end;

function TioViewModelBase._Release: Integer;
begin
{$IFNDEF AUTOREFCOUNT}
  Result := AtomicDecrement(FRefCount);
  if Result = 0 then
    Destroy;
{$ELSE}
  Result := __ObjRelease;
{$ENDIF}
end;

constructor TioViewModelBase.Create(const ATypeName, ATypeAlias, AioWhere: String; const AViewDataType:TioViewDataType; const AAutoLoadData:Boolean);
begin
  inherited Create(nil);
  FioTypeName := ATypeName;
  FioTypeAlias := ATypeAlias;
  FIoWhere := FIoWhere;
  FioViewDataType := AViewDataType;
  FioAutoLoadData := AAutoLoadData;
end;

constructor TioViewModelBase.Create(const AClassRef: TioClassRef; const AioWhere: String; const AViewDataType:TioViewDataType; const AAutoLoadData:Boolean);
begin
  inherited Create(nil);
  FioTypeName     := AClassRef.ClassName;
  FioTypeAlias    := '';
  FioWhere        := AioWhere;
  FioViewDataType := AViewDataType;
  FioAutoLoadData := AAutoLoadData;
end;

constructor TioViewModelBase.Create(const AMasterBindSource: TioMasterBindSource; const AMasterPropertyName: String);
begin
  inherited Create(nil);
  FIoMasterBindSource := AMasterBindSource;
  FIoMasterPropertyName := AMasterPropertyName;
end;

constructor TioViewModelBase.Create(const ADataIntf: IInterface; const AViewDataType: TioViewDataType);
begin
  inherited Create(nil);
  FViewData := TioMVVMFactory.ViewData(ADataIntf, AViewDataType);
end;

procedure TioViewModelBase.ioLoadViewData;
var
  AObj: TObject;
  ABindSourceAdapter: TBindSourceAdapter;
  AActiveBindSourceAdapter: IioActiveBindSourceAdapter;
begin
  // Checks
  if Assigned(FViewData) then
    raise EIupOrmException.Create(Self.ClassName + ': "ViewData" is already assigned!');
  // If there is a MasterViewModel...
  if Assigned(FioMasterViewModel) then
    FViewData := TioMVVMFactory.ViewData(FioMasterViewModel, FIoMasterPropertyName)
  // If  FioMasterViewModelTypeName is specified (retrieve the MasterVM by Dependency Injection)
  else if not FioMasterViewModelTypeName.IsEmpty then
  begin
    AObj := TIupOrm.DependencyInjection.Locate(FioMasterViewModelTypeName, FioMasterViewModelTypeAlias).Get;
    if not Supports(AObj, IioViewModel, FioMasterViewModel) then
      raise EIupOrmException.Create(Self.ClassName + ': The "IioViewModel" interface is not implemented by object.');
    FViewData := TioMVVMFactory.ViewData(FioMasterViewModel, FIoMasterPropertyName)
  end
  // If there is a MasterBindSource then create the ViewData by MasterBindSource
  //  else create it by TypeName, TypeAlias.........
  else if Assigned(FIoMasterBindSource) then
    FViewData := TioMVVMFactory.ViewData(FIoMasterBindSource, FIoMasterPropertyName)
  // If there is a MasterBindSourceAdapter...
  else if Assigned(FioMasterBindSourceAdapter) then
    FViewData := TioMVVMFactory.ViewData(FioMasterBindSourceAdapter, FIoMasterPropertyName)
  // If there is a TypeName
  else if not FioTypeName.IsEmpty then
    FViewData := TioMVVMFactory.ViewData(FioTypeName, FioTypeAlias, FIoWhere, FioViewDataType, FioAutoLoadData);
end;



constructor TioViewModelBase.Create(const AMasterBindSourceAdapter: IioActiveBindSourceAdapter; const AMasterPropertyName: String);
begin
  inherited Create(nil);
  FioMasterBindSourceAdapter := AMasterBindSourceAdapter;
  FIoMasterPropertyName := AMasterPropertyName;
end;

constructor TioViewModelBase.Create(const AMasterViewModel: IioViewModel; const AMasterPropertyName: String);
begin
  inherited Create(nil);
  FioMasterViewModel := AMasterViewModel;
  FIoMasterPropertyName := AMasterPropertyName;
end;

constructor TioViewModelBase.Create(const AMasterViewModelTypeName, AMasterViewModelTypeAlias,
  AMasterViewModelMasterPropertyName: String);
var
  AObj: TObject;
  AMasterViewModel: IioViewModel;
begin
  inherited Create(nil);
  FioMasterViewModelTypeName := AMasterViewModelTypeName;
  FioMasterViewModelTypeAlias := AMasterViewModelTypeAlias;
  FIoMasterPropertyName := AMasterViewModelMasterPropertyName;
end;

constructor TioViewModelBase.Create;
begin
  inherited Create(nil);
  // Init
  FViewData := nil;
end;

end.
