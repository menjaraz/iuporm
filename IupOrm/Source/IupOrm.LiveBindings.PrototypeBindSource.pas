unit IupOrm.LiveBindings.PrototypeBindSource;

interface

uses
  Data.Bind.ObjectScope, IupOrm.LiveBindings.Interfaces, System.Classes,
  IupOrm.LiveBindings.Notification, System.Rtti, IupOrm.MVVM.Interfaces;

type


  TioPrototypeBindSource = class;

  TioMasterBindSource = TioPrototypeBindSource;

  TioNeedViewModelEvent = procedure(Sender: TioPrototypeBindSource; var AViewModel: IioViewModel) of object;

  TioPrototypeBindSource = class (TPrototypeBindSource, IioNotifiableBindSource)
  private
    FioTypeName: String;
    FioTypeAlias: String;
    FioAutoLoadData: Boolean;
    FioAutoPersist: Boolean;
    FioViewDataType: TioViewDataType;
    FioMasterBindSource: TioMasterBindSource;
    FioMasterPropertyName: String;
    FioWhere: TStrings;
    FioAutoRefreshOnNotification: TioAutoRefreshType;
    FioVM_Interface, FioVM_Alias: String;
    FioMasterVM_Interface, FioMasterVM_Alias: String;
    FioVM_UseBSPropsOnCreate: Boolean;
    FioViewModel: IioViewModel;
    FonNotify: TioBSANotificationEvent;
    FOnNeedViewModel: TioNeedViewModelEvent;
    // FioLoaded flag for IupOrm DoCreateAdapter internal use only just before
    //  the real Loaded is call. See the Loaded and the DoCreateAdapter methods.
    FioLoaded: Boolean;
    // =========================================================================
    // Part for the support of the IioNotifiableBindSource interfaces (Added by IupOrm)
    //  because is not implementing IInterface (NB: RefCount DISABLED)
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    // =========================================================================
    function GetIsDetail: Boolean;
    procedure DoNeedViewModel;
    function CheckForViewModel: Boolean;
    procedure DoCreateAdapter(var ADataObject: TBindSourceAdapter); override;
    procedure Loaded; override;
    procedure DoNotify(ANotification:IioBSANotification);
    function GetAutoPersist: Boolean;
    procedure SetAutoPersist(const Value: Boolean);
//    procedure ioSetBindSourceAdapter(AAdapter: TBindSourceAdapter);
    property IsDetail:Boolean read GetIsDetail;
    function GetAutoLoadData: Boolean;
    function GetViewDataType: TioViewDataType;
    procedure SetAutoLoadData(const Value: Boolean);
    procedure SetViewDataType(const Value: TioViewDataType);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Notify(Sender:TObject; ANotification:IioBSANotification);
    procedure BindVMActions(const AView:TComponent);
    procedure BindVMAction(const AType:TRttiType; const AView:TComponent; const AComponentName, AActionName: String);
    // ----------------------------------------------------------------------------------------------------------------------------
    // BindSourceAdapter methods/properties published by TioPrototypeBindSource also
    function Current: TObject;
    procedure Refresh(ReloadData:Boolean); overload;
    procedure Persist(ReloadData:Boolean=False);
    procedure Append; overload;
    procedure Append(AObject:TObject); overload;
    function GetActiveBindSourceAdapter: IioActiveBindSourceAdapter;
    function GetDataObject: TObject;
    procedure SetDataObject(const AObj: TObject; const AOwnsObject:Boolean=True);
    procedure ClearDataObject;
    // ----------------------------------------------------------------------------------------------------------------------------
    property ioViewModel:IioViewModel read FioViewModel write FioViewModel;
  published
    property ioOnNotify:TioBSANotificationEvent read FonNotify write FonNotify;
    property ioOnNeedViewModel:TioNeedViewModelEvent read FOnNeedViewModel write FOnNeedViewModel;

    property ioTypeName:String read FioTypeName write FioTypeName;
    property ioTypeAlias:String read FioTypeAlias write FioTypeAlias;
    property ioAutoLoadData:Boolean read GetAutoLoadData write SetAutoLoadData;
    property ioAutoPersist:Boolean read GetAutoPersist write SetAutoPersist;
    property ioViewDataType:TioViewDataType read GetViewDataType write SetViewDataType;
    property ioWhere:TStrings read FIoWhere write FIoWhere;
    property ioMasterBindSource:TioMasterBindSource read FIoMasterBindSource write FIoMasterBindSource;
    property ioMasterPropertyName:String read FIoMasterPropertyName write FIoMasterPropertyName;
    property ioAutoRefreshOnNotification:TioAutoRefreshType read FioAutoRefreshOnNotification write FioAutoRefreshOnNotification;
    property ioVM_Interface:String read FioVM_Interface write FioVM_Interface;
    property ioVM_Alias:String read FioVM_Alias write FioVM_Alias;
    property ioVM_UseBSPropsOnCreate:Boolean read FioVM_UseBSPropsOnCreate write FioVM_UseBSPropsOnCreate;
    property ioMasterVM_Interface:String read FioMasterVM_Interface write FioMasterVM_Interface;
    property ioMasterVM_Alias:String read FioMasterVM_Alias write FioMasterVM_Alias;
  end;

implementation

uses
  System.SysUtils, IupOrm.Exceptions, IupOrm.RttiContext.Factory,
  IupOrm.Attributes, IupOrm.DependencyInjection, IupOrm,
  IupOrm.Context.Container, IupOrm.LiveBindings.Factory;

{ TioPrototypeBindSource }

procedure TioPrototypeBindSource.Append;
begin
  if not CheckAdapter then Exit;
  GetInternalAdapter.Append;
end;

procedure TioPrototypeBindSource.Append(AObject: TObject);
var
  AnActiveBSA: IioActiveBindSourceAdapter;
begin
  if CheckAdapter and Supports(Self.GetInternalAdapter, IioActiveBindSourceAdapter, AnActiveBSA) then
  begin
    AnActiveBSA.Append(AObject);
    AnActiveBSA.Refresh(False);
  end
  else raise EIupOrmException.Create(Self.ClassName + ': Internal adapter is not an ActiveBindSourceAdapter!');
end;

procedure TioPrototypeBindSource.BindVMAction(const AType: TRttiType; const AView:TComponent; const AComponentName,
  AActionName: String);
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
  AAction := Self.ioViewModel.GetActionByName(AActionName);
  if not Assigned(AAction) then EIupOrmException.Create(Self.ClassName + ': Action not found!');
  // Set the action property of the object
  AValue := TValue.From<TBasicAction>(AAction);
  AProp.SetValue(AObj, AValue);
end;

procedure TioPrototypeBindSource.BindVMActions(const AView: TComponent);
var
  Typ: TRttiType;
  Fld: TRttiField;
  Attr: TCustomAttribute;
begin
  // Retrieve the RttiType of the view
  Typ := TioRttiContextFactory.RttiContext.GetType(AView.ClassType);
  for Fld in Typ.GetFields do
    for Attr in Fld.GetAttributes do
      if Attr is ioAction then
        Self.BindVMAction(Fld.FieldType, AView, Fld.Name, ioAction(Attr).Value);
end;

procedure TioPrototypeBindSource.ClearDataObject;
begin
  Self.GetActiveBindSourceAdapter.ClearDataObject;
end;

constructor TioPrototypeBindSource.Create(AOwner: TComponent);
begin
  inherited;
  FioLoaded := False;
  FioAutoRefreshOnNotification := arEnabledNoReload;
  FioAutoLoadData := True;
  FioAutoPersist := True;
  FioViewDataType := dtList;
  FioWhere := TStringList.Create;
  FioViewModel := nil;
  FioVM_UseBSPropsOnCreate := True;
end;

destructor TioPrototypeBindSource.Destroy;
begin
  FioWhere.Free;
  inherited;
end;

function TioPrototypeBindSource.CheckForViewModel: Boolean;
begin
  // Init
  Result := False;
  // If a ViewModel is already assigned then exit
  if Assigned(ioViewModel) then Exit;
  // ===============================================================================================================================
  // LOCKED VIEW MODEL ALREADY CREATED IN THE DEPENDENCY INJECTION CONTAINER  (an external prepared ViewModel)
  // -------------------------------------------------------------------------------------------------------------------------------
  // If a LockedViewModel is present in the DIContainer (an external prepared ViewModel) and the BindSource is not
  //  a detail (is Master) then Get that ViewModel  , assign it to itself (and to the View later during its creating),
  //  and get the BindSourceAdapter from it.
  if TioViewModelShuttle.Exist and not Self.IsDetail then
    // Get the ViewModel
    ioViewModel := TioViewModelShuttle.Get
  // ===============================================================================================================================
  // ===============================================================================================================================
  // VIEW MODEL FROM THE DEPENDENCY INJECTION CONTAINER
  // -------------------------------------------------------------------------------------------------------------------------------
  // If a VM_Interface is specified then get the proper ViewModel from he Dependency Injection Container
  else if not ioVM_Interface.IsEmpty then
  begin
    // ViewModel with a MasterViewModel
    if FioVM_UseBSPropsOnCreate and not FioMasterVM_Interface.IsEmpty then
      ioViewModel := TioDependencyInjection.Locate(FioVM_Interface).Alias(FioVM_Alias)
        .ConstructorMarker('CreateByMasterViewModelFromDependencyInjection')
        .ConstructorParams([FioMasterVM_Interface, FioMasterVM_Alias, FioMasterPropertyName])
        .Get.ioAsInterface<IioViewModel>
    // ViewModel with a MasterBindSource
    else if FioVM_UseBSPropsOnCreate and Assigned(FioMasterBindSource) then
      ioViewModel := TioDependencyInjection.Locate(FioVM_Interface).Alias(FioVM_Alias)
        .ConstructorMarker('CreateByMasterBindSource')
        .ConstructorParams([FioMasterBindSource, FioMasterPropertyName])
        .Get.ioAsInterface<IioViewModel>
    // ViewModel with TypeName+TypeAlias+Where BindSourceAdapterCreation
    else if FioVM_UseBSPropsOnCreate and not FioTypeName.IsEmpty then
      ioViewModel := TioDependencyInjection.Locate(FioVM_Interface).Alias(FioVM_Alias)
        .ConstructorMarker('CreateByTypeName')
        .ConstructorParams([FioTypeName, FioTypeAlias, FioWhere.Text, TValue.From<TioViewDataType>(FioViewDataType), FioAutoLoadData])
        .Get.ioAsInterface<IioViewModel>
    // Otherwise ViewModel only by ViewModelInterface and ViewModelAlias
    //  NB: Even if the "ioVM_UseBSPropsOnCreate" property is False
    else
      ioViewModel := TioDependencyInjection.Locate(FioVM_Interface).Alias(FioVM_Alias)
        .Get.ioAsInterface<IioViewModel>;
  end;
  // ===============================================================================================================================
  // onNeedViewModel just after it has be assigned (for any changes/additions to the ViewModel itself)
  //  or for retrieve an external created ViewModel
  Self.DoNeedViewModel;
  // If a ViewModel was created/retrieved then return True (False otherwise)
  Result := Assigned(ioViewModel);
end;

procedure TioPrototypeBindSource.DoCreateAdapter(
  var ADataObject: TBindSourceAdapter);
var
  AActiveBSA: IioActiveBindSourceAdapter;
begin
  inherited;
  // Init
  AActiveBSA  := nil;
  // If in DesignTime then Exit
  // FioLoaded flag for IupOrm DoCreateAdapter internal use only just before
  //  the real Loaded is call. See the Loaded and the DoCreateAdapter methods.
  if (csDesigning in ComponentState)
  or (not FioLoaded)
    then Exit;
  // -------------------------------------------------------------------------------------------------------------------------------
  // ViewModel create/retrieve
  //  NB: If a ViewModel was created/retrieved then get the BindSourceAdapter from it
  if Self.CheckForViewModel and Assigned(Self.ioViewModel.ViewData) then
    ADataObject := Self.ioViewModel.ViewData.BindSourceAdapter;
  // -------------------------------------------------------------------------------------------------------------------------------
  // If AdataObject is NOT already assigned (by onCreateAdapter event handler or from a ViewModel) then
  //  retrieve a BindSourceAdapter automagically by iupORM
  if (not Assigned(ADataObject)) and not ioTypeName.IsEmpty then
  begin
    // If this is a detail BindSource then retrieve the adapter from the master BindSource
    //  else get the adapter directly from IupOrm
    if Assigned(Self.ioMasterBindSource) then
      ADataObject := TioLiveBindingsFactory.GetBSAfromMasterBindSource(Self, Self.FioMasterBindSource, Self.ioMasterPropertyName)
    else
      ADataObject := TioLiveBindingsFactory.GetBSAfromDB(Self, FioTypeName, FioTypeAlias, FioWhere.Text, FioViewDataType, FioAutoLoadData);
  end;
  // -------------------------------------------------------------------------------------------------------------------------------
  // If Self is a Notifiable bind source then register a reference to itself
  //  in the ActiveBindSourceAdapter
  if  Assigned(ADataObject)
  and Supports(ADataObject, IioActiveBindSourceAdapter, AActiveBSA)
  and Supports(Self, IioNotifiableBindSource)
  then
  begin
    AActiveBSA.ioAutoPersist := FioAutoPersist;
    AActiveBSA.SetBindSource(Self);
  end;
  // -------------------------------------------------------------------------------------------------------------------------------
end;

procedure TioPrototypeBindSource.DoNeedViewModel;
begin
  if Assigned(FOnNeedViewModel) then
    FOnNeedViewModel(Self, FioViewModel);
end;

procedure TioPrototypeBindSource.DoNotify(ANotification:IioBSANotification);
begin
  // If assigned execute the event handler
  if Assigned(FonNotify)
    then ioOnNotify(Self, ANotification);
  // If enabled perform an AutoRefresh operation
  if Self.ioAutoRefreshOnNotification > arDisabled
    then Self.Refresh(Self.ioAutoRefreshOnNotification = arEnabledReload);
end;

function TioPrototypeBindSource.Current: TObject;
begin
  Result := nil;
  if not CheckAdapter then Exit;
  Result := Self.InternalAdapter.Current
end;

function TioPrototypeBindSource.GetActiveBindSourceAdapter: IioActiveBindSourceAdapter;
begin
  Result := nil;
  Supports(Self.InternalAdapter, IioActiveBindSourceAdapter, Result);
end;

function TioPrototypeBindSource.GetAutoLoadData: Boolean;
begin
  Result := FioAutoLoadData;
end;

function TioPrototypeBindSource.GetAutoPersist: Boolean;
begin
  Result := FioAutoPersist;
end;

function TioPrototypeBindSource.GetDataObject: TObject;
begin
  Result := nil;
  Result := Self.GetActiveBindSourceAdapter.GetDataObject;
end;

function TioPrototypeBindSource.GetIsDetail: Boolean;
begin
  Result := Assigned(FioMasterBindSource);
end;

function TioPrototypeBindSource.GetViewDataType: TioViewDataType;
begin
  Result := FioViewDataType;
end;

//procedure TioPrototypeBindSource.ioSetBindSourceAdapter(
//  AAdapter: TBindSourceAdapter);
//begin
//  Self.ConnectAdapter(AAdapter);
//end;

procedure TioPrototypeBindSource.Loaded;
var
  LAdapter: TBindSourceAdapter;
begin
  // DOCREATEADAPTER CALL MUST BE BEFORE INHERITED !!!!!!
  // ===========================================================================
  // FioLoaded flag for IupOrm DoCreateAdapter internal use only just before
  //  the real Loaded is call. See the Loaded and the DoCreateAdapter methods.
  // ---------------------------------------------------------------------------
  FioLoaded := True;
  if not Assigned(Self.OnCreateAdapter) then
  begin
    Self.DoCreateAdapter(LAdapter);
    if LAdapter <> nil then
      SetRuntimeAdapter(LAdapter);
  end;
  // ===========================================================================
  // INHERITED MUST BE AFTER THE DOCREATEADAPTER CALL !!!!!!
  inherited;
  // ===========================================================================
  // If the ViewModel is assigned (by the DoCreateAdapter method) then it try
  //  to Bind the View (Owner) components to ViewModel's actions
  // ---------------------------------------------------------------------------
  if Assigned(Self.ioViewModel) then
    Self.BindVMActions(Self.Owner);
  // ===========================================================================
end;

procedure TioPrototypeBindSource.Notify(Sender: TObject;
  ANotification: IioBSANotification);
begin
  Self.DoNotify(ANotification);
end;

procedure TioPrototypeBindSource.Persist(ReloadData: Boolean);
var
 AioActiveBindSourceAdapter: IioActiveBindSourceAdapter;
begin
  if not CheckAdapter then Exit;
  // If the InternalAdapter support the IioActiveBindSourceAdapter (is an ActiveBindSourceAdapter)
  //  then call the Adapter Persist method
  AioActiveBindSourceAdapter := Self.GetActiveBindSourceAdapter;
  if Assigned(AioActiveBindSourceAdapter) then
    AioActiveBindSourceAdapter.Persist(ReloadData);
end;

function TioPrototypeBindSource.QueryInterface(const IID: TGUID;
  out Obj): HResult;
begin
  // RefCount disabled
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := E_NOINTERFACE;
end;

procedure TioPrototypeBindSource.Refresh(ReloadData: Boolean);
var
  AnActiveBSA: IioActiveBindSourceAdapter;
begin
  if not CheckAdapter then Exit;
  if Supports(Self.GetInternalAdapter, IioActiveBindSourceAdapter, AnActiveBSA)
    then AnActiveBSA.Refresh(ReloadData)
    else GetInternalAdapter.Refresh;
end;

procedure TioPrototypeBindSource.SetAutoLoadData(const Value: Boolean);
begin
  FioAutoLoadData := Value;
end;

procedure TioPrototypeBindSource.SetAutoPersist(const Value: Boolean);
begin
  FioAutoPersist := Value;
end;

procedure TioPrototypeBindSource.SetDataObject(const AObj: TObject; const AOwnsObject: Boolean);
begin
  Self.GetActiveBindSourceAdapter.SetDataObject(AObj, AOwnsObject);
end;

procedure TioPrototypeBindSource.SetViewDataType(const Value: TioViewDataType);
begin
  FioViewDataType := Value;
end;

function TioPrototypeBindSource._AddRef: Integer;
begin
  // Nothing, the interfaces support is intended only as LazyLoadable support flag
end;

function TioPrototypeBindSource._Release: Integer;
begin
  // Nothing, the interfaces support is intended only as LazyLoadable support flag
end;

end.
