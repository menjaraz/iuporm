unit IupOrm.LiveBindings.ActiveInterfaceObjectBindSourceAdapter;

interface

uses
  IupOrm.LiveBindings.InterfaceObjectBindSourceAdapter,
  IupOrm.LiveBindings.Interfaces, IupOrm.LiveBindings.Notification,
  IupOrm.CommonTypes, System.Classes, IupOrm.Context.Properties.Interfaces,
  Data.Bind.ObjectScope;

type

  TioActiveInterfaceObjectBindSourceAdapter = class(TInterfaceObjectBindSourceAdapter, IioContainedBindSourceAdapter, IioActiveBindSourceAdapter, IioNaturalBindSourceAdapterSource)
  strict private
    FWhereStr: String;
    FTypeName, FTypeAlias: String;
    FLocalOwnsObject: Boolean;
    FAutoLoadData: Boolean;
    FAutoPersist: Boolean;
    FReloadDataOnRefresh: Boolean;
    FMasterPropertyName: String;
    FMasterAdaptersContainer: IioDetailBindSourceAdaptersContainer;
    FDetailAdaptersContainer: IioDetailBindSourceAdaptersContainer;
    FBindSource: IioNotifiableBindSource;
    FonNotify: TioBSANotificationEvent;
//    FNaturalBSA_MasterBindSourceAdapter: IioActiveBindSourceAdapter;
    FInsertObj_Enabled: Boolean;
    FInsertObj_NewObj: TObject;
  private
    // =========================================================================
    // Part for the support of the IioNotifiableBindSource interfaces (Added by IupOrm)
    //  because is not implementing IInterface (NB: RefCount DISABLED)
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    // =========================================================================
    procedure DoBeforeOpen; override;
    procedure DoBeforeRefresh; override;
    procedure DoBeforeDelete; override;
    procedure DoAfterDelete; override;
    procedure DoAfterPost; override;
    procedure DoAfterScroll; override;
    procedure DoAfterInsert; override;
    procedure SetObjStatus(AObjStatus: TIupOrmObjectStatus);
    function UseObjStatus: Boolean;
    procedure DoNotify(ANotification:IioBSANotification);
    function GetioAutoPersist: Boolean;
    procedure SetioAutoPersist(const Value: Boolean); protected
  public
    constructor Create(const ATypeName, ATypeAlias, AWhereStr:String; const AOwner: TComponent; const AObject: TObject; const AutoLoadData: Boolean); overload;
    destructor Destroy; override;
    procedure SetMasterAdapterContainer(AMasterAdapterContainer:IioDetailBindSourceAdaptersContainer);
    procedure SetMasterProperty(AMasterProperty: IioContextProperty);
    procedure SetBindSource(ANotifiableBindSource:IioNotifiableBindSource);
    procedure ExtractDetailObject(AMasterObj: TObject);
    procedure Persist(ReloadData:Boolean=False);
    function GetDetailBindSourceAdapter(AOwner:TComponent; AMasterPropertyName:String): TBindSourceAdapter;
    function GetNaturalObjectBindSourceAdapter(AOwner:TComponent): TBindSourceAdapter;
    procedure Append(AObject:TObject); overload;
    procedure Insert(AObject:TObject); overload;
    procedure Notify(Sender:TObject; ANotification:IioBSANotification); virtual;
    procedure Refresh(ReloadData:Boolean); overload;
//    FNaturalBSA_MasterBindSourceAdapter: IioActiveBindSourceAdapter;  *** NB: Code presente (commented) in the unit body ***
    function GetDataObject: TObject;
    procedure SetDataObject(const AObj: TObject; const AOwnsObject:Boolean=True);
    procedure ClearDataObject;
    function GetCurrentOID: Integer;
    function IsDetail: Boolean;

    property ioAutoPersist:Boolean read GetioAutoPersist write SetioAutoPersist;
    property ioOnNotify:TioBSANotificationEvent read FonNotify write FonNotify;
  end;


implementation

uses
  IupOrm, System.SysUtils, IupOrm.LiveBindings.Factory, IupOrm.Context.Factory,
  System.Rtti, IupOrm.Context.Map.Interfaces;

{ TioActiveInterfaceObjectBindSourceAdapter }

procedure TioActiveInterfaceObjectBindSourceAdapter.Append(AObject: TObject);
begin
  // Set sone InsertObj subsystem variables
  // Then call the standard code
  FInsertObj_NewObj := AObject;
  FInsertObj_Enabled := True;
  Self.Append;
end;

procedure TioActiveInterfaceObjectBindSourceAdapter.ClearDataObject;
begin
  Self.SetDataObject(nil, False);
end;

constructor TioActiveInterfaceObjectBindSourceAdapter.Create(const ATypeName, ATypeAlias, AWhereStr: String;
  const AOwner: TComponent; const AObject: TObject; const AutoLoadData: Boolean);
begin
  FAutoPersist := True;
  FAutoLoadData := AutoLoadData;
  FReloadDataOnRefresh := True;
  inherited Create(AOwner, AObject, ATypeAlias, ATypeName);
  FLocalOwnsObject := False;  // Always false because it's a BSA for an interface (AutoRefCount)
  FWhereStr := AWhereStr;
  // Set Master & Details adapters reference
  FMasterAdaptersContainer := nil;
  FDetailAdaptersContainer := TioLiveBindingsFactory.DetailAdaptersContainer(Self);
  // Init InsertObj subsystem values
  FInsertObj_Enabled := False;
  FInsertObj_NewObj := nil;
end;

destructor TioActiveInterfaceObjectBindSourceAdapter.Destroy;
begin
  // Detach itself from MasterAdapterContainer (if it's contained)
  if Assigned(FMasterAdaptersContainer) then
    FMasterAdaptersContainer.RemoveBindSourceAdapter(Self);
  // Free the DetailAdaptersContainer
  FDetailAdaptersContainer.Free;
  inherited;
end;

procedure TioActiveInterfaceObjectBindSourceAdapter.DoAfterDelete;
begin
  inherited;
  // Send a notification to other ActiveBindSourceAdapters & BindSource
  Notify(
         Self,
         TioLiveBindingsFactory.Notification(Self, Self.Current, ntAfterDelete)
        );
end;

procedure TioActiveInterfaceObjectBindSourceAdapter.DoAfterInsert;
var
  ObjToFree: TObject;
begin
  // If enabled subsitute the new object with the FInsertObj_NewObj (Append(AObject:TObject))
  //  then destroy the "old" new object
  if FInsertObj_Enabled then
  begin
    try
      ObjToFree := Self.DataObject as TObject;
      ObjToFree.Free;
      Self.SetDataObject(FInsertObj_NewObj, FLocalOwnsObject);
    finally
      // Reset InsertObj subsystem
      FInsertObj_Enabled := False;
      FInsertObj_NewObj := nil;
    end;
  end;
  // Execute AfterInsert event handler
  inherited;
end;

procedure TioActiveInterfaceObjectBindSourceAdapter.DoAfterPost;
begin
  inherited;
  Self.SetObjStatus(osDirty);
  // If AutoPersist is enabled then persist
  if Self.FAutoPersist then TIupOrm.Persist(Self.Current);
  // Send a notification to other ActiveBindSourceAdapters & BindSource
  Notify(
         Self,
         TioLiveBindingsFactory.Notification(Self, Self.Current, ntAfterPost)
        );
end;

procedure TioActiveInterfaceObjectBindSourceAdapter.DoAfterScroll;
begin
  inherited;
  Self.FDetailAdaptersContainer.SetMasterObject(Self.Current);
end;

procedure TioActiveInterfaceObjectBindSourceAdapter.DoBeforeDelete;
begin
  inherited;
  // If ObjectStatus exists in the class then set it as osDirty
  if Self.UseObjStatus then
  begin
    Self.SetObjStatus(osDeleted);
    Abort;
  end;
  // If AutoPersist is enabled then persist
  if Self.FAutoPersist then TIupOrm.Delete(Self.Current);
end;

procedure TioActiveInterfaceObjectBindSourceAdapter.DoBeforeOpen;
begin
  inherited;
  // Load the object and assign it to the Adapter
  if FAutoLoadData
    then Self.SetDataObject(   TIupOrm.Load(FTypeName, FTypeAlias)._Where(FWhereStr).ToObject   , FLocalOwnsObject);
end;

procedure TioActiveInterfaceObjectBindSourceAdapter.DoBeforeRefresh;
var
  PrevDataObject: TObject;
begin
  inherited;
  if FReloadDataOnRefresh then
  begin
    // Deactivate the adapter
    Self.Active := False;
    // Get actual DataObject
    PrevDataObject := Self.DataObject as TObject;
    // If ActualDataObject is assigned and OwnsObject = True then destroy the object
    if Assigned(PrevDataObject) and Self.FLocalOwnsObject then PrevDataObject.Free;
    // Activate the Adapter (after the adapter fire the onBeforeOpen event that Load
    //  the NewObject
    Self.Active := True;
  end;
end;

procedure TioActiveInterfaceObjectBindSourceAdapter.DoNotify(ANotification: IioBSANotification);
begin
  if Assigned(FonNotify)
    then ioOnNotify(Self, ANotification);
end;

procedure TioActiveInterfaceObjectBindSourceAdapter.ExtractDetailObject(AMasterObj: TObject);
var
  ADetailObj: TObject;
  AValue: TValue;
  AMap: IioMap;
  AMasterProperty: IioContextProperty;
begin
  ADetailObj := nil;
  // Check parameter, if the MasterObject is not assigned
  //  then close the BSA
  if not Assigned(AMasterObj) then
  begin
    Self.SetDataObject(nil, False);  // 2° parameter false ABSOLUTELY!!!!!!!
    Exit;
  end;
  // Extract master property value
  AMap := TioContextFactory.Map(AMasterObj.ClassType);
  AMasterProperty := AMap.GetProperties.GetPropertyByName(FMasterPropertyName);
  AValue := AMasterProperty.GetValue(AMasterObj);
  // Retrieve the object from the TValue
  if not AValue.IsEmpty then
    if AMasterProperty.IsInterface then
      ADetailObj := TObject(AValue.AsInterface)
    else
      ADetailObj := AValue.AsObject;
  // Set it to the Adapter itself
  Self.SetDataObject(ADetailObj, False);  // 2° parameter false ABSOLUTELY!!!!!!!
end;

function TioActiveInterfaceObjectBindSourceAdapter.GetCurrentOID: Integer;
var
  AMap: IioMap;
begin
  // Create context for current child object
  AMap := TioContextFactory.Map(Self.Current.ClassType);
  Result := AMap.GetProperties.GetIdProperty.GetValue(Self.Current).AsInteger;
end;

function TioActiveInterfaceObjectBindSourceAdapter.GetDataObject: TObject;
begin
  Result := Self.DataObject as TObject;
end;

function TioActiveInterfaceObjectBindSourceAdapter.GetDetailBindSourceAdapter(AOwner: TComponent;
  AMasterPropertyName: String): TBindSourceAdapter;
begin
  // Return the requested DetailBindSourceAdapter and set the current master object
  Result := FDetailAdaptersContainer.GetBindSourceAdapter(AOwner, BaseObjectRttiType.Name, AMasterPropertyName);
  FDetailAdaptersContainer.SetMasterObject(Self.Current);
end;

function TioActiveInterfaceObjectBindSourceAdapter.GetioAutoPersist: Boolean;
begin
  Result := FAutoPersist;
end;

function TioActiveInterfaceObjectBindSourceAdapter.GetNaturalObjectBindSourceAdapter(AOwner: TComponent): TBindSourceAdapter;
begin
  Result := TioLiveBindingsFactory.NaturalObjectBindSourceAdapter(AOwner, Self);
end;

procedure TioActiveInterfaceObjectBindSourceAdapter.Insert(AObject: TObject);
begin
  // Set sone InsertObj subsystem variables
  // Then call the standard code
  FInsertObj_NewObj := AObject;
  FInsertObj_Enabled := True;
  Self.Insert;
end;

function TioActiveInterfaceObjectBindSourceAdapter.IsDetail: Boolean;
begin
  Result := not FMasterPropertyName.IsEmpty;
end;

//procedure TioActiveInterfaceObjectBindSourceAdapter.NaturalBSA_SetMasterBindSourceAdapter(
//  AActiveBindSourceAdapter: IioActiveBindSourceAdapter);
//begin
//  Self.FNaturalBSA_MasterBindSourceAdapter := AActiveBindSourceAdapter;
//end;

procedure TioActiveInterfaceObjectBindSourceAdapter.Notify(Sender: TObject; ANotification: IioBSANotification);
begin
  // Fire the event handler
  if Sender <> Self
    then Self.DoNotify(ANotification);
  // Replicate notification to the BindSource
  if Assigned(FBindSource) and (Sender <> TObject(FBindSource))
    then FBindSource.Notify(Self, ANotification);
  // Replicate notification to the DetailAdaptersContainer
  if Sender <> TObject(FDetailAdaptersContainer)
    then FDetailAdaptersContainer.Notify(Self, ANotification);
  // Replicate notification to the MasterAdaptersContainer
  if Assigned(FMasterAdaptersContainer) and (Sender <> TObject(FMasterAdaptersContainer))
    then FMasterAdaptersContainer.Notify(Self, ANotification);
end;

procedure TioActiveInterfaceObjectBindSourceAdapter.Persist(ReloadData: Boolean);
begin
  // Persist
  TIupOrm.Persist(Self.DataObject);
  // Reload
  if ReloadData then Self.DoBeforeOpen;
end;

function TioActiveInterfaceObjectBindSourceAdapter.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  // RefCount disabled
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := E_NOINTERFACE;
end;

procedure TioActiveInterfaceObjectBindSourceAdapter.Refresh(ReloadData: Boolean);
var
  PrecReloadData: Boolean;
begin
  PrecReloadData := FReloadDataOnRefresh;
  Self.FReloadDataOnRefresh := ReloadData;
  inherited Refresh;
  Self.FReloadDataOnRefresh := PrecReloadData;
end;

procedure TioActiveInterfaceObjectBindSourceAdapter.SetBindSource(ANotifiableBindSource: IioNotifiableBindSource);
begin
  FBindSource := ANotifiableBindSource;
end;

procedure TioActiveInterfaceObjectBindSourceAdapter.SetDataObject(const AObj: TObject; const AOwnsObject:Boolean);
begin
  // Disable the adapter
  Self.First;  // Bug
  Self.Active := False;
  // AObj is assigned then set it as DataObject
  //  else set DataObject to nil and set MasterObject to nil
  //  to disable all Details adapters also
  if Assigned(AObj) then
  begin
    inherited SetDataObject(AObj, AOwnsObject);
    Self.FAutoLoadData := False;  // If the DataObject is externally provided then Set FAutoLoadData to false to prevent double values
    Self.Active := True;
  end
  else
  begin
    inherited SetDataObject(nil, AOwnsObject);
    Self.FDetailAdaptersContainer.SetMasterObject(nil);
  end;
end;

procedure TioActiveInterfaceObjectBindSourceAdapter.SetioAutoPersist(const Value: Boolean);
begin
  FAutoPersist := Value;
end;

procedure TioActiveInterfaceObjectBindSourceAdapter.SetMasterAdapterContainer(
  AMasterAdapterContainer: IioDetailBindSourceAdaptersContainer);
begin
  FMasterAdaptersContainer := AMasterAdapterContainer;
end;

procedure TioActiveInterfaceObjectBindSourceAdapter.SetMasterProperty(AMasterProperty: IioContextProperty);
begin
  FMasterPropertyName := AMasterProperty.GetName;
end;

procedure TioActiveInterfaceObjectBindSourceAdapter.SetObjStatus(AObjStatus: TIupOrmObjectStatus);
begin
  TioContextFactory.Context(Self.Current.ClassName, nil, Self.Current).ObjectStatus := AObjStatus;
end;

function TioActiveInterfaceObjectBindSourceAdapter.UseObjStatus: Boolean;
begin
  Result := TioContextFactory.Context(Self.Current.ClassName, nil, Self.Current).ObjStatusExist;
end;

function TioActiveInterfaceObjectBindSourceAdapter._AddRef: Integer;
begin
  // Nothing, the interfaces support is intended only as LazyLoadable support flag
end;

function TioActiveInterfaceObjectBindSourceAdapter._Release: Integer;
begin
  // Nothing, the interfaces support is intended only as LazyLoadable support flag
end;

end.
