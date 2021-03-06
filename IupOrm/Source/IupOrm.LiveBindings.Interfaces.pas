unit IupOrm.LiveBindings.Interfaces;

interface

uses
  System.Generics.Collections, Data.Bind.ObjectScope,
  IupOrm.Context.Properties.Interfaces, IupOrm.CommonTypes, System.Classes;

type

  // Forward declaration
  IioContainedBindSourceAdapter = interface;

  // Bind source adapters notification type
  TioBSANotificationType = (ntAfterPost, ntAfterDelete);

  // BindSource AutoRefresh type after notification
  TioAutoRefreshType = (arDisabled, arEnabledNoReload, arEnabledReload);

  // Bind source adapters notification interface
  IioBSANotification = interface
    ['{CE7FCAD1-5D60-4C5C-9BE6-7D6E36571AE3}']
    function Sender: TObject;
    function Subject: TObject;
    function NotificationType: TioBSANotificationType;
  end;

  // Interface (without RefCount) for ioBindSources detection
  //  (useful for detect IupOrm bind sources to pass itself
  //  to the ActiveBindSourceAdapter for notify changes)
  IioNotifiableBindSource = interface
    ['{2DFC1B43-4AE2-4402-89B3-7A134938EFE6}']
    procedure Notify(Sender:TObject; ANotification:IioBSANotification);
  end;

  // The common ancestor for all PrototypeBindSource components
  TioBaseBindSource = TBaseObjectBindSource;

  IioActiveBindSourceAdapter = interface
    ['{F407B515-AE0B-48FD-B8C3-0D0C81774A58}']
    procedure Edit(AForce: Boolean = False);
    procedure Post;
    procedure Persist(ReloadData:Boolean=False);
    procedure Notify(Sender:TObject; ANotification:IioBSANotification);
    procedure Refresh(ReloadData:Boolean);
    procedure SetBindSource(ANotifiableBindSource:IioNotifiableBindSource);
    procedure Append(AObject:TObject);
    procedure Insert(AObject:TObject);
    function UseObjStatus: Boolean;
    function GetDetailBindSourceAdapter(AOwner:TComponent; AMasterPropertyName:String): TBindSourceAdapter;
    function GetNaturalObjectBindSourceAdapter(AOwner:TComponent): TBindSourceAdapter;
    function GetDataObject: TObject;
    procedure SetDataObject(const AObj:TObject; const AOwnsObject:Boolean=True);
    procedure ClearDataObject;
    function GetCurrentOID: Integer;
    function IsDetail: Boolean;
    // Current property
    function GetCurrent: TObject;
    property Current: TObject read GetCurrent;
    // AutoPersist property
    procedure SetioAutoPersist(const Value: Boolean);
    function GetioAutoPersist: Boolean;
    property ioAutoPersist:Boolean read GetioAutoPersist write SetioAutoPersist;
  end;

  // Bind source adapter container
  IioDetailBindSourceAdaptersContainer = interface
    ['{B374E226-D7A9-4A44-9BB6-DF85AC283598}']
    procedure Free;
    procedure SetMasterObject(AMasterObj: TObject);
    function GetBindSourceAdapter(AOwner:TComponent; AMasterClassName:String; AMasterPropertyName:String): TBindSourceAdapter;
    procedure Notify(Sender:TObject; ANotification:IioBSANotification);
    procedure RemoveBindSourceAdapter(ABindSourceAdapter: IioContainedBindSourceAdapter);
    function GetMasterBindSourceAdapter: IioActiveBindSourceAdapter;
  end;

  IioContainedBindSourceAdapter = interface
    ['{66AF6AD7-9093-4526-A18C-54447FB220A3}']
    procedure Free;
    procedure SetMasterAdapterContainer(AMasterAdapterContainer:IioDetailBindSourceAdaptersContainer);
    procedure SetMasterProperty(AMasterProperty: IioContextProperty);
    procedure ExtractDetailObject(AMasterObj: TObject); overload;
    function GetDetailBindSourceAdapter(AOwner:TComponent; AMasterPropertyName:String): TBindSourceAdapter;
    procedure Notify(Sender:TObject; ANotification:IioBSANotification);
  end;

  IioNaturalBindSourceAdapterSource = interface
    ['{892D8DAE-96F3-48FC-925C-F3F5CD5C0F68}']
    procedure Notify(Sender:TObject; ANotification:IioBSANotification);
    procedure Refresh(ReloadData:Boolean); overload;
    function GetCurrent: TObject;
    function UseObjStatus: Boolean;
    function GetNaturalObjectBindSourceAdapter(AOwner:TComponent): TBindSourceAdapter;
  end;

  // BindSourceAdapter List
  TioDetailAdapters = TList<IioContainedBindSourceAdapter>;

implementation

end.
