unit IupOrm.DependencyInjection;

interface

uses
  IupOrm.CommonTypes, System.Generics.Collections, IupOrm.MVVM.Interfaces,
  System.SyncObjs, IupOrm.DependencyInjection.Interfaces, System.Rtti,
  IupOrm.LiveBindings.PrototypeBindSource, IupOrm.LiveBindings.Interfaces,
  IupOrm.Resolver.Interfaces, IupOrm.Context.Container,
  IupOrm.DependencyInjection.Singletons;

type

  // ===============================================================================================================================
  // Internal containers types
  // -------------------------------------------------------------------------------------------------------------------------------
  // Dependency Injection Container Interface IMPLEMENTERS (SubContainer)
  TioDIContainerImplementersKey = String;
  TioDIContainerImplementers = class
  strict private
    FClassesList: String;
    FInternalContainer: TObjectDictionary<TioDIContainerImplementersKey, TioDIContainerImplementersItem>;
    procedure BuildClassesList;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Add(const AAlias:TioDIContainerImplementersKey; const AImplementerItem:TioDIContainerImplementersItem);
    function GetItem(const AAlias: TioDIContainerImplementersKey): TioDIContainerImplementersItem;
    function Contains(const AAlias: TioDIContainerImplementersKey): Boolean;
    function ContainsClass(const AClassName:String): Boolean;
    function GetEnumerator: TEnumerator<TioDIContainerImplementersItem>;
  end;
  // Dependency injection container INTERFACES (MasterContainer)
  TioDIContainerKey = String;
  TioDIContainerValue = TioDIContainerImplementers;
  TioDIContainerInstance = TObjectDictionary<TioDIContainerKey, TioDIContainerValue>;
  // ===============================================================================================================================

  // Dependency Injection Container (and relative class reference)
  TioDependencyInjectionContainerRef = class of TioDependencyInjectionContainer;
  TioDependencyInjectionContainer = class abstract
  strict private
    class var FContainer: TioDIContainerInstance;
  public
    class procedure Build;
    class procedure CleanUp;
    class procedure Add(const AKey:TioDIContainerKey; const ASubKey:TioDIContainerImplementersKey; const AValue:TioDIContainerImplementersItem);
    class function Exists(const AKey:TioDIContainerKey; const ASubKey:TioDIContainerImplementersKey): Boolean; overload;
    class function ImplementersExists(const AKey:TioDIContainerKey): Boolean; overload;
    class function Get(const AKey:TioDIContainerKey; const ASubKey:TioDIContainerImplementersKey): TioDIContainerImplementersItem;
    class function GetInterfaceImplementers(const AKey:TioDIContainerKey): TioDIContainerValue;
  end;

  // Base class for Dependency Injection Register and Locator classes
  TioDependencyInjectionBase = class abstract(TInterfacedObject)
  strict protected
    class function Container: TioDependencyInjectionContainerRef;
    class function InterfaceNameToString<T:IInterface>: String;
    class function InterfaceGUIToString<T:IInterface>: String;
  end;

  // Register Class (NoRefCounter)
  TioDependencyInjectionRegister = class(TioDependencyInjectionBase)
  strict private
    FContainerValue: TioDIContainerImplementersItem;
    FInterfaceName: String;
    FAlias: String;
  public
    constructor Create(const AContainerValue:TioDIContainerImplementersItem);
    procedure Execute;
    function Implements(const AInterfaceName:String; const AAlias:String=''): TioDependencyInjectionRegister; overload;
    function Implements<T: IInterface>(const AAlias:String=''): TioDependencyInjectionRegister; overload;
    function Alias(const AAlias:String): TioDependencyInjectionRegister;
    function InjectProperty(const APropertyName:String; const APropertyValue:TValue):TioDependencyInjectionRegister;
    function AsSingleton:TioDependencyInjectionRegister;
    function DefaultConstructorMethod(const AValue:String): TioDependencyInjectionRegister;
    function DefaultConstructorMarker(const AValue:String): TioDependencyInjectionRegister;
    function DefaultConstructorParams(const AParams: array of TValue): TioDependencyInjectionRegister;
  end;

  // Service Locator Class
  TioDependencyInjectionLocator = class(TioDependencyInjectionBase, IioDependencyInjectionLocator)
  strict private
    FInterfaceName: String;
    FAlias: String;
    FConstructorMethod: String;
    FConstructorMarker: String;
    FConstructorParams: array of TValue;
    FViewModel: IioViewModel;
    FViewModelMarker: String;
    FSingletonKey: String;
    function ViewModelExist: Boolean;
    procedure InitializeObjectAfterCreate(const AObj:TObject; const AContainerItem:TioDIContainerImplementersItem);
    procedure CheckConstructorInfo(const AContainerItem: TioDIContainerImplementersItem);
  public
    constructor Create(const AInterfaceName:String; const AAlias:String=''); virtual;
    function Exist: Boolean; virtual;
    function Get: TObject; virtual;
    function GetItem: TioDIContainerImplementersItem;
    function Alias(const AAlias:String): IioDependencyInjectionLocator;
    function ConstructorParams(const AParams: array of TValue): IioDependencyInjectionLocator; virtual;
    function ConstructorMethod(const AConstructorMethod: String): IioDependencyInjectionLocator; virtual;
    function ConstructorMarker(const AConstructorMarker: String): IioDependencyInjectionLocator; virtual;
    function SingletonKey(const ASingletonKey:String): IioDependencyInjectionLocator; virtual;
    function ViewModel(const AViewModel:IioViewModel; const AMarker:String=''): IioDependencyInjectionLocator; overload;

    function ViewModel(const AInterfaceName, AModelClassName:String; const AWhere:String=''; const AAlias:String=''; const AMarker:String=''): IioDependencyInjectionLocator; overload;
    function ViewModel(const AInterfaceName:String; const AMasterBindSource:TioMasterBindSource; const AMasterPropertyName:String=''; const AAlias:String=''; const AMarker:String=''): IioDependencyInjectionLocator; overload;
    function ViewModel(const AInterfaceName:String; ABindSourceAdapter:IioActiveBindSourceAdapter; const AAlias:String=''; const AMarker:String=''): IioDependencyInjectionLocator; overload;
  end;
  // Generic version of the Service Locator Class
  TioDependencyInjectionLocator<TI:IInterface> = class(TioDependencyInjectionLocator, IioDependencyInjectionLocator<TI>)
  public
    function Get: TI; overload;
    function Alias(const AAlias:String): IioDependencyInjectionLocator<TI>;
    function ConstructorParams(const AParams: array of TValue): IioDependencyInjectionLocator<TI>; overload;
    function ConstructorMethod(const AConstructorMethod: String): IioDependencyInjectionLocator<TI>; overload;
    function ConstructorMarker(const AConstructorMarker: String): IioDependencyInjectionLocator<TI>; overload;
    function SingletonKey(const ASingletonKey:String): IioDependencyInjectionLocator<TI>; overload;
    function ViewModel(const AViewModel:IioViewModel; const AMarker:String=''): IioDependencyInjectionLocator<TI>; overload;

    function ViewModel(const AInterfaceName, AModelClassName:String; const AWhere:String=''; const AAlias:String=''; const AMarker:String=''): IioDependencyInjectionLocator<TI>; overload;
    function ViewModel(const AInterfaceName:String; const AMasterBindSource:TioMasterBindSource; const AMasterPropertyName:String=''; const AAlias:String=''; const AMarker:String=''): IioDependencyInjectionLocator<TI>; overload;
    function ViewModel(const AInterfaceName:String; ABindSourceAdapter:IioActiveBindSourceAdapter; const AAlias:String=''; const AMarker:String=''): IioDependencyInjectionLocator<TI>; overload;
  end;

  // Class for ResolverByDependencyInjection
  TioDependencyInjectionResolverBase = class(TioDependencyInjectionBase)
  public
    class function Resolve(const ATypeName:String; const AAlias:String; const AResolverMode:TioResolverMode): IioResolvedTypeList;
  end;

  // Main Dependency Injection Class (and relative class reference)
  TioDependencyInjectionRef = class of TioDependencyInjection;
  TioDependencyInjection = class(TioDependencyInjectionBase)
  public
    class function RegisterClass(const AClassRef:TioClassRef): TioDependencyInjectionRegister; overload;
    class function RegisterClass<T: class>: TioDependencyInjectionRegister; overload;
    class function Locate(const AInterfaceName:String; const AAlias:String=''): IioDependencyInjectionLocator; overload;
    class function Locate<T:IInterface>(const AAlias:String=''): IioDependencyInjectionLocator<T>; overload;

    class function LocateViewModel(const AInterfaceName, AModelClassName:String; const AWhere:String=''; const AAlias:String=''): IioDependencyInjectionLocator; overload;
    class function LocateViewModel(const AInterfaceName:String; const AMasterBindSource:TioMasterBindSource; const AMasterPropertyName:String=''; const AAlias:String=''): IioDependencyInjectionLocator; overload;
    class function LocateViewModel(const AInterfaceName:String; ABindSourceAdapter:IioActiveBindSourceAdapter; const AAlias:String=''): IioDependencyInjectionLocator; overload;
    class function LocateViewModel<T:IInterface>(const AModelClassName:String; const AWhere:String=''; const AAlias:String=''): IioDependencyInjectionLocator<T>; overload;
    class function LocateViewModel<T:IInterface>(const AMasterBindSource:TioMasterBindSource; const AMasterPropertyName:String=''; const AAlias:String=''): IioDependencyInjectionLocator; overload;
    class function LocateViewModel<T:IInterface>(const ABindSourceAdapter:IioActiveBindSourceAdapter; const AAlias:String=''): IioDependencyInjectionLocator; overload;

    class function Singletons: TioSingletonsFacadeRef;
  end;

  // Dependency Injection Factory
  TioDependencyInjectionFactory = class abstract(TioDependencyInjectionBase)
  public
    class function GetRegister(const AContainerValue:TioDIContainerImplementersItem): TioDependencyInjectionRegister;
    class function GetLocator(const AInterfaceName:String; const AAlias:String=''): IioDependencyInjectionLocator; overload;
    class function GetLocator<TI:IInterface>(const AAlias:String=''): IioDependencyInjectionLocator<TI>; overload;
  end;

implementation

uses
  IupOrm, IupOrm.Exceptions, SysUtils, System.TypInfo, IupOrm.ObjectsForge.ObjectMaker,
  IupOrm.Rtti.Utilities, IupOrm.Resolver.Factory, IupOrm.RttiContext.Factory,
  IupOrm.Context.Map.Interfaces,
  IupOrm.DependencyInjection.ViewModelShuttleContainer;

{ TioDependencyInjectionBase }

class function TioDependencyInjectionBase.Container: TioDependencyInjectionContainerRef;
begin
  Result := TioDependencyInjectionContainer;
end;

class function TioDependencyInjectionBase.InterfaceGUIToString<T>: String;
begin
  Result := TioRttiUtilities.GenericInterfaceToGUI<T>;
end;

class function TioDependencyInjectionBase.InterfaceNameToString<T>: String;
begin
  Result := TioRttiUtilities.GenericToString<T>;
end;

{ TioDependencyInjection }

class function TioDependencyInjection.Locate(const AInterfaceName, AAlias: String): IioDependencyInjectionLocator;
begin
  Result := TioDependencyInjectionFactory.GetLocator(AInterfaceName, AAlias);
end;

class function TioDependencyInjection.Locate<T>(const AAlias: String): IioDependencyInjectionLocator<T>;
begin
  Result := TioDependencyInjectionFactory.GetLocator<T>(AAlias);
end;

class function TioDependencyInjection.LocateViewModel(const AInterfaceName, AModelClassName,
  AWhere, AAlias: String): IioDependencyInjectionLocator;
begin
  Result := Self.Locate(AInterfaceName)
                .Alias(AAlias)
                .ConstructorMarker('CreateByClassName')
                .ConstructorParams([AModelClassName, AWhere]);
end;

class function TioDependencyInjection.LocateViewModel(const AInterfaceName:String; const AMasterBindSource: TioMasterBindSource;
  const AMasterPropertyName, AAlias: String): IioDependencyInjectionLocator;
begin
  Result := Self.Locate(AInterfaceName)
                .Alias(AAlias)
                .ConstructorMarker('CreateByMasterBindSource')
                .ConstructorParams([TValue.From(AMasterBindSource), AMasterPropertyName]);
end;

class function TioDependencyInjection.LocateViewModel(const AInterfaceName: String;
  ABindSourceAdapter: IioActiveBindSourceAdapter; const AAlias:String): IioDependencyInjectionLocator;
begin
  Result := Self.Locate(AInterfaceName)
                .Alias(AAlias)
                .ConstructorMarker('CreateByBindSourceAdapter')
                .ConstructorParams([TValue.From(ABindSourceAdapter)]);
end;

class function TioDependencyInjection.LocateViewModel<T>(const AModelClassName, AWhere, AAlias: String): IioDependencyInjectionLocator<T>;
begin
  Result := Self.Locate<T>
                .Alias(AAlias)
                .ConstructorMarker('CreateByClassName')
                .ConstructorParams([AModelClassName, AWhere]);
end;

class function TioDependencyInjection.LocateViewModel<T>(const AMasterBindSource: TioMasterBindSource;
  const AMasterPropertyName, AAlias: String): IioDependencyInjectionLocator;
begin
  Result := Self.Locate<T>
                .Alias(AAlias)
                .ConstructorMarker('CreateByMasterBindSource')
                .ConstructorParams([TValue.From(AMasterBindSource), AMasterPropertyName]);
end;

class function TioDependencyInjection.LocateViewModel<T>(
  const ABindSourceAdapter: IioActiveBindSourceAdapter; const AAlias:String): IioDependencyInjectionLocator;
begin
  Result := Self.Locate<T>
                .Alias(AAlias)
                .ConstructorMarker('CreateByBindSourceAdapter')
                .ConstructorParams([TValue.From(ABindSourceAdapter)]);
end;

class function TioDependencyInjection.RegisterClass(const AClassRef: TioClassRef): TioDependencyInjectionRegister;
var
  ContainerValue: TioDIContainerImplementersItem;
begin
  ContainerValue := TioDIContainerImplementersItem.Create;
  ContainerValue.ClassRef := AClassRef;
  ContainerValue.ClassName := AClassRef.ClassName;
  ContainerValue.RttiType := TioRttiContextFactory.RttiContext.GetType(AClassRef).AsInstance;
  ContainerValue.IsSingleton := False;
  Result := TioDependencyInjectionFactory.GetRegister(ContainerValue);
end;

class function TioDependencyInjection.RegisterClass<T>: TioDependencyInjectionRegister;
var
  ContainerValue: TioDIContainerValue;
begin
  Result := Self.RegisterClass(T);
end;

class function TioDependencyInjection.Singletons: TioSingletonsFacadeRef;
begin
  Result := TioSingletonsFacade;
end;

{ TioDependencyInjectionRegister }

function TioDependencyInjectionRegister.Alias(const AAlias: String): TioDependencyInjectionRegister;
begin
  Self.FAlias := AAlias;
  Result := Self;
end;

function TioDependencyInjectionRegister.AsSingleton: TioDependencyInjectionRegister;
begin
  Self.FContainerValue.IsSingleton := True;
  Result := Self;
end;

constructor TioDependencyInjectionRegister.Create(const AContainerValue:TioDIContainerImplementersItem);
begin
  inherited Create;
  Self.FContainerValue := AContainerValue;
end;

function TioDependencyInjectionRegister.DefaultConstructorMarker(const AValue: String): TioDependencyInjectionRegister;
begin
  Self.FContainerValue.DefaultConstructorMarker := AValue;
  Result := Self;
end;

function TioDependencyInjectionRegister.DefaultConstructorMethod(const AValue: String): TioDependencyInjectionRegister;
begin
  Self.FContainerValue.DefaultConstructorMethod := AValue;
  Result := Self;
end;

function TioDependencyInjectionRegister.DefaultConstructorParams(const AParams: array of TValue): TioDependencyInjectionRegister;
var
  i: Integer;
begin
  // Solo così sembra andare bene
  SetLength(FContainerValue.DefaultConstructorParams, Length(AParams));
  for i := 0 to High(AParams) do FContainerValue.DefaultConstructorParams[i] := AParams[i];
  Result := Self;
end;

procedure TioDependencyInjectionRegister.Execute;
begin
  Self.Container.Add(Self.FInterfaceName, Self.FAlias, Self.FContainerValue);
  Self.Free;
end;

function TioDependencyInjectionRegister.Implements(const AInterfaceName: String; const AAlias: String): TioDependencyInjectionRegister;
begin
  Self.FInterfaceName := AInterfaceName;
  if not AAlias.IsEmpty then
    Self.FAlias := AAlias;
  Result := Self;
end;

function TioDependencyInjectionRegister.Implements<T>(const AAlias:String): TioDependencyInjectionRegister;
begin
  Result := Self.Implements(Self.InterfaceNameToString<T>, AAlias);
end;

function TioDependencyInjectionRegister.InjectProperty(const APropertyName: String;
  const APropertyValue: TValue): TioDependencyInjectionRegister;
var
  I: Integer;
begin
  I := Length(FContainerValue.PropertiesOnCreate);
  SetLength(FContainerValue.PropertiesOnCreate, I+1);
  FContainerValue.PropertiesOnCreate[I].Name  := APropertyName;
  FContainerValue.PropertiesOnCreate[I].Value := APropertyValue;
  Result := Self;
end;

{ TioDependencyInjectionContainer }

class procedure TioDependencyInjectionContainer.Add(const AKey: TioDIContainerKey; const ASubKey:TioDIContainerImplementersKey; const AValue: TioDIContainerImplementersItem);
begin
  // If the Key not exist then create the SubContainer and add it to the MasterContainer
  if not Self.FContainer.ContainsKey(AKey) then
    Self.FContainer.Add(AKey, TioDIContainerValue.Create);
  // Add the Value to the SubKey
  Self.FContainer.Items[AKey].Add(ASubKey, AValue);
end;

class procedure TioDependencyInjectionContainer.Build;
begin
  Self.FContainer := TioDIContainerInstance.Create([doOwnsValues]);
end;

class procedure TioDependencyInjectionContainer.CleanUp;
begin
  Self.FContainer.Free;
end;

class function TioDependencyInjectionContainer.Exists(const AKey: TioDIContainerKey; const ASubKey:TioDIContainerImplementersKey): Boolean;
begin
  Result := Self.FContainer.ContainsKey(AKey) and Self.FContainer.Items[AKey].Contains(ASubKey);
end;

class function TioDependencyInjectionContainer.Get(const AKey: TioDIContainerKey; const ASubKey:TioDIContainerImplementersKey): TioDIContainerImplementersItem;
begin
  if not Self.Exists(AKey, ASubKey) then
    raise EIupOrmException.Create(Self.ClassName + ': implementer for interface "' + AKey + '" alias "' + ASubKey + '" not found.');
  Result := Self.FContainer.Items[AKey].GetItem(ASubKey);
end;

class function TioDependencyInjectionContainer.GetInterfaceImplementers(const AKey: TioDIContainerKey): TioDIContainerValue;
begin
  if not Self.ImplementersExists(AKey) then
    raise EIupOrmException.Create(Self.ClassName + ': implementers for interface "' + AKey + '" not found.');
  Result := Self.FContainer.Items[AKey];
end;

class function TioDependencyInjectionContainer.ImplementersExists(const AKey: TioDIContainerKey): Boolean;
begin
  Result := Self.FContainer.ContainsKey(AKey);
end;

{ TioDependencyInjectionLocator }

function TioDependencyInjectionLocator.Alias(const AAlias: String): IioDependencyInjectionLocator;
begin
  FAlias := AAlias;
  Result := Self;
end;

procedure TioDependencyInjectionLocator.CheckConstructorInfo(const AContainerItem: TioDIContainerImplementersItem);
var
  i: Integer;
begin
  // If a constructor method name or constructor marker is specified in the locator call then use it (method, marker and params)
  //  else use the default values
  if FConstructorMethod.IsEmpty and FConstructorMarker.IsEmpty and (Length(FConstructorParams) = 0) then
  begin
    FConstructorMethod := AContainerItem.DefaultConstructorMethod;
    FConstructorMarker := AContainerItem.DefaultConstructorMarker;
    // Solo così sembra andare bene
    SetLength(FConstructorParams, Length(AContainerItem.DefaultConstructorParams));
    for i := 0 to High(AContainerItem.DefaultConstructorParams) do
      FConstructorParams[i] := AContainerItem.DefaultConstructorParams[i];
  end;
end;

function TioDependencyInjectionLocator.ConstructorMarker(const AConstructorMarker: String): IioDependencyInjectionLocator;
begin
  FConstructorMarker := AConstructorMarker;
  Result := Self;
end;

function TioDependencyInjectionLocator.ConstructorMethod(const AConstructorMethod: String): IioDependencyInjectionLocator;
begin
  FConstructorMethod := AConstructorMethod;
  Result := Self;
end;

function TioDependencyInjectionLocator.ConstructorParams(const AParams: array of TValue): IioDependencyInjectionLocator;
var
  i: Integer;
begin
  // Solo così sembra andare bene
  SetLength(FConstructorParams, Length(AParams));
  for i := 0 to High(AParams) do FConstructorParams[i] := AParams[i];
  Result := Self;
end;

constructor TioDependencyInjectionLocator.Create(const AInterfaceName, AAlias: String);
begin
  inherited Create;
  FInterfaceName := AInterfaceName;
  FAlias := AAlias;
  FViewModel := nil;
  FViewModelMarker := '';
  FSingletonKey := '';
end;

function TioDependencyInjectionLocator.Exist: Boolean;
begin
  Result := Self.Container.Exists(Self.FInterfaceName, Self.FAlias);
end;

function TioDependencyInjectionLocator.Get: TObject;
var
  ContainerItem: TioDIContainerImplementersItem;
begin
  Result := nil;
  // Retrieve the Class Type Reference
  ContainerItem := Self.Container.Get(FInterfaceName, FAlias);
  // if then ViewModel is present then Lock it (MVVM)
  if Self.ViewModelExist then
  begin
    TioViewModelShuttleContainer.Add(FViewModel, FViewModelMarker);
  end;
  try
    // If it is a singleton then get the Instance (if exists)...
    if  ContainerItem.IsSingleton
    and TioSingletonsContainer.TryGet(FSingletonKey, FInterfaceName, FAlias, Result)
    then
      // Nothing
    // ... else create the object (and add it to the ContainerItem.ObjInstance if
    //  it is a new instance of a singleton)
    else
    begin
      // If a constructor method name or constructor marker is specified in the locator call then use it (method, marker and params)
      //  else use the default values
      Self.CheckConstructorInfo(ContainerItem);
      // Object creation
      Result := TioObjectMaker.CreateObjectByClassRefEx(ContainerItem.ClassRef, FConstructorParams, FConstructorMarker, FConstructorMethod);
      // Initialize Object after creation (InjectProperty etc.)
      Self.InitializeObjectAfterCreate(Result, ContainerItem);
      // If it is a new instance of a singleton then add it to the SingletonsContainer
      if ContainerItem.IsSingleton then
        TioSingletonsContainer.Add(FSingletonKey, FInterfaceName, FAlias, Result);
    end;
  finally
    // if the ViewModel is present then UnLock it (MVVM)
    if Self.ViewModelExist then
    begin
      TioViewModelShuttleContainer.TryDelete(FViewModelMarker);
    end;
  end;
end;

function TioDependencyInjectionLocator.GetItem: TioDIContainerImplementersItem;
begin
  Result := Self.Container.Get(Self.FInterfaceName, Self.FAlias);
end;

procedure TioDependencyInjectionLocator.InitializeObjectAfterCreate(const AObj: TObject; const AContainerItem: TioDIContainerImplementersItem);
var
  Typ: TRttiInstanceType;
  Prop: TRttiProperty;
  I: Integer;
begin
  Typ := TioRttiContextFactory.RttiContext.GetType(AObj.ClassType).AsInstance;
  // Loop for all properties to initialize (if exists)
  for I := 0 to Length(AContainerItem.PropertiesOnCreate) -1 do
  begin
    Prop := nil;
    Prop := Typ.GetProperty(AContainerItem.PropertiesOnCreate[I].Name);
    if Assigned(Prop) then
      Prop.SetValue(AObj, AContainerItem.PropertiesOnCreate[I].Value);
  end;
end;

function TioDependencyInjectionLocator.SingletonKey(const ASingletonKey: String): IioDependencyInjectionLocator;
begin
  FSingletonKey := ASingletonKey;
  Result := Self;
end;

function TioDependencyInjectionLocator.ViewModel(const AViewModel: IioViewModel; const AMarker:String): IioDependencyInjectionLocator;
begin
  FViewModelMarker := AMarker;
  FViewModel := AViewModel;
  Result := Self;
end;

function TioDependencyInjectionLocator.ViewModel(const AInterfaceName, AModelClassName, AWhere,
  AAlias, AMarker: String): IioDependencyInjectionLocator;
begin
  Result := Self.ViewModel(
    TioDependencyInjection.LocateViewModel(AInterfaceName, AModelClassName, AWhere, AAlias).Get.ioAsInterface<IioViewModel>,
    AMarker
    );
end;

function TioDependencyInjectionLocator.ViewModel(const AInterfaceName: String; const AMasterBindSource: TioMasterBindSource;
  const AMasterPropertyName, AAlias, AMarker: String): IioDependencyInjectionLocator;
begin
  Result := Self.ViewModel(
    TioDependencyInjection.LocateViewModel(AInterfaceName, AMasterBindSource, AMasterPropertyName, AAlias).Get.ioAsInterface<IioViewModel>,
    AMarker
    );
end;

function TioDependencyInjectionLocator.ViewModel(const AInterfaceName: String;
  ABindSourceAdapter: IioActiveBindSourceAdapter; const AAlias, AMarker: String): IioDependencyInjectionLocator;
begin
  Result := Self.ViewModel(
    TioDependencyInjection.LocateViewModel(AInterfaceName, ABindSourceAdapter, AAlias).Get.ioAsInterface<IioViewModel>,
    AMarker
    );
end;

function TioDependencyInjectionLocator.ViewModelExist: Boolean;
begin
  Result := Assigned(Self.FViewModel);
end;

{ TioDependencyInjectionFactory }

class function TioDependencyInjectionFactory.GetLocator(const AInterfaceName, AAlias: String): IioDependencyInjectionLocator;
begin
  Result := TioDependencyInjectionLocator.Create(AInterfaceName, AAlias);
end;

class function TioDependencyInjectionFactory.GetLocator<TI>(const AAlias:String): IioDependencyInjectionLocator<TI>;
begin
  Result := TioDependencyInjectionLocator<TI>.Create(Self.InterfaceNameToString<TI>, AAlias);
end;

class function TioDependencyInjectionFactory.GetRegister(const AContainerValue:TioDIContainerImplementersItem): TioDependencyInjectionRegister;
begin
  Result := TioDependencyInjectionRegister.Create(AContainerValue);
end;

{ TioDependencyInjectionLocator<T> }

function TioDependencyInjectionLocator<TI>.Alias(const AAlias: String): IioDependencyInjectionLocator<TI>;
begin
  Result := Self;
  TioDependencyInjectionLocator(Self).Alias(AAlias);
end;

function TioDependencyInjectionLocator<TI>.ConstructorMarker(const AConstructorMarker: String): IioDependencyInjectionLocator<TI>;
begin
  Result := Self;
  TioDependencyInjectionLocator(Self).ConstructorMarker(AConstructorMarker);
end;

function TioDependencyInjectionLocator<TI>.ConstructorMethod(const AConstructorMethod: String): IioDependencyInjectionLocator<TI>;
begin
  Result := Self;
  TioDependencyInjectionLocator(Self).ConstructorMethod(AConstructorMethod);
end;

function TioDependencyInjectionLocator<TI>.ConstructorParams(const AParams: array of TValue): IioDependencyInjectionLocator<TI>;
begin
  Result := Self;
  TioDependencyInjectionLocator(Self).ConstructorParams(AParams);
end;

function TioDependencyInjectionLocator<TI>.Get: TI;
begin
  Result := inherited Get.ioAsInterface<TI>;
end;

function TioDependencyInjectionLocator<TI>.SingletonKey(const ASingletonKey: String): IioDependencyInjectionLocator<TI>;
begin
  Result := Self;
  TioDependencyInjectionLocator(Self).SingletonKey(ASingletonKey);
end;

function TioDependencyInjectionLocator<TI>.ViewModel(const AInterfaceName, AModelClassName, AWhere,
  AAlias, AMarker: String): IioDependencyInjectionLocator<TI>;
begin
  Result := Self;
  TioDependencyInjectionLocator(Self).ViewModel(AInterfaceName, AModelClassName, AWhere, AAlias, AMarker);
end;

function TioDependencyInjectionLocator<TI>.ViewModel(const AInterfaceName: String;
  const AMasterBindSource: TioMasterBindSource; const AMasterPropertyName, AAlias, AMarker: String): IioDependencyInjectionLocator<TI>;
begin
  Result := Self;
  TioDependencyInjectionLocator(Self).ViewModel(AInterfaceName, AMasterBindSource, AMasterPropertyName, AAlias, AMarker);
end;

function TioDependencyInjectionLocator<TI>.ViewModel(const AInterfaceName: String;
  ABindSourceAdapter: IioActiveBindSourceAdapter; const AAlias, AMarker: String): IioDependencyInjectionLocator<TI>;
begin
  Result := Self;
  TioDependencyInjectionLocator(Self).ViewModel(AInterfaceName, ABindSourceAdapter, AAlias, AMarker);
end;

function TioDependencyInjectionLocator<TI>.ViewModel(const AViewModel: IioViewModel; const AMarker:String): IioDependencyInjectionLocator<TI>;
begin
  Result := Self;
  TioDependencyInjectionLocator(Self).ViewModel(AViewModel, AMarker);
end;


{ TioDependencyInjectionResolverBase }

class function TioDependencyInjectionResolverBase.Resolve(const ATypeName:String; const AAlias: String; const AResolverMode:TioResolverMode): IioResolvedTypeList;
var
  AImplementer: TioDIContainerImplementersItem;
  AImplementerCollection: TioDIContainerImplementers;
  AMap: IioMap;
begin
  // Create the ResolvedTypeList
  Result := TioResolverFactory.GetResolvedTypeList;
  // If ATypeName is not an interface (is a class) then
  //  return it and exit;
  if not TioRttiUtilities.IsAnInterfaceTypeName(ATypeName) then
  begin
    Result.Add(ATypeName);
    Exit;
  end;
  // If ResolverMode = rmAll and Alias is NOT specified
  if (AResolverMode = rmAll) and AAlias.IsEmpty then
  begin
    // Get the collection of the classes implementing the interface
    AImplementerCollection := Self.Container.GetInterfaceImplementers(ATypeName);
    // Loop for all the implementers
    for AImplementer in AImplementerCollection do
    begin
      // Get the map for the current implementer
      AMap := TioMapContainer.GetMap(AImplementer.ClassName);
      // NB: Solo le classi (implementers) che non derivino da classi anch'esse contenute nell'elenco degli implementers (per evitare duplicati)
      if (not AMap.HasMappedAncestor)
      or (not AImplementerCollection.ContainsClass(   AMap.AncestorMap.GetClassRef.ClassName   ))
      then
        Result.Add(AImplementer.ClassName);
    end;
  end
  // If Alias IS specified
  else
    Result.Add(   Self.Container.Get(ATypeName, AAlias).ClassName   );
end;

{ TioDIContainerImplementers }

procedure TioDIContainerImplementers.Add(const AAlias: String; const AImplementerItem: TioDIContainerImplementersItem);
begin
  FInternalContainer.AddOrSetValue(AAlias, AImplementerItem);
  Self.BuildClassesList;
end;

procedure TioDIContainerImplementers.BuildClassesList;
var
  AImplementersItem: TioDIContainerImplementersItem;
begin
  FClassesList := '';
  for AImplementersItem in FInternalContainer.Values do
    FClassesList := FClassesList + '<' + AImplementersItem.ClassName + '>';
end;

function TioDIContainerImplementers.Contains(const AAlias: TioDIContainerImplementersKey): Boolean;
begin
  Result := FInternalContainer.ContainsKey(AAlias);
end;

function TioDIContainerImplementers.ContainsClass(const AClassName: String): Boolean;
begin
  Result := FClassesList.Contains('<'+AClassName+'>');
end;

constructor TioDIContainerImplementers.Create;
begin
  inherited;
  FInternalContainer := TObjectDictionary<string, TioDIContainerImplementersItem>.Create([doOwnsValues]);
end;

destructor TioDIContainerImplementers.Destroy;
begin
  FInternalContainer.Free;
  inherited;
end;

function TioDIContainerImplementers.GetEnumerator: TEnumerator<TioDIContainerImplementersItem>;
begin
  Result := FInternalContainer.Values.GetEnumerator;
end;

function TioDIContainerImplementers.GetItem(const AAlias: TioDIContainerImplementersKey): TioDIContainerImplementersItem;
begin
  Result := FInternalContainer.Items[AAlias];
end;

initialization
// NB: Spostato sulla initialize della unit IupOrm
//  TioDependencyInjectionContainer.Build;
//  TioViewModelShuttle.Build;

finalization
  TioDependencyInjectionContainer.CleanUp;

end.
