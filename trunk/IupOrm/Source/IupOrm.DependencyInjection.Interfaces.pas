unit IupOrm.DependencyInjection.Interfaces;

interface

uses
  System.Rtti, IupOrm.MVVM.Interfaces, IupOrm.LiveBindings.PrototypeBindSource,
  IupOrm.LiveBindings.Interfaces,
  IupOrm.CommonTypes, System.Generics.Collections;

type

  // Default initial property value for an implementers Item
  TioDIPropertyOnCreate = record
    Name: String;
    Value: TValue;
  end;
  // Dependency Injection Container Implementers Item (SubContainer value)
  TioDIContainerImplementersItem = class
  strict private
    // for singleton lifetime manager
    ObjInstance: TObject;
    IntfInstance: IInterface;
  public
    ClassRef: TioClassref;
    ClassName: String;
    RttiType: TRttiInstanceType;
    PropertiesOnCreate: TArray<TioDIPropertyOnCreate>;
    DefaultConstructorMethod: String;
    DefaultConstructorMarker: String;
    DefaultConstructorParams: array of TValue;
    // for singleton lifetime manager
    IsSingleton: Boolean;
    constructor Create;
    function ObjInstanceExists: Boolean;
    function GetObjInstance: TObject;
    procedure SetObjInstance(AObj:TObject);
  end;

  IioDependencyInjectionLocator = interface
    ['{51289FD7-AA55-43D9-BF5B-EDA5BF27D301}']
    function Exist: Boolean;
    function Get: TObject;
    function GetItem: TioDIContainerImplementersItem;
    function Alias(const AAlias:String): IioDependencyInjectionLocator;
    function ConstructorParams(const AParams: array of TValue): IioDependencyInjectionLocator;
    function ConstructorMethod(const AConstructorMethod: String): IioDependencyInjectionLocator;
    function ConstructorMarker(const AConstructorMarker: String): IioDependencyInjectionLocator;
    function ViewModel(const AViewModel:IioViewModel): IioDependencyInjectionLocator; overload;

    function ViewModel(const AInterfaceNameOrAlias, AModelClassName:String; const AWhere:String=''; const AAlias:String=''): IioDependencyInjectionLocator; overload;
    function ViewModel(const AInterfaceNameOrAlias:String; const AMasterBindSource:TioMasterBindSource; const AMasterPropertyName:String=''; const AAlias:String=''): IioDependencyInjectionLocator; overload;
    function ViewModel(const AInterfaceNameOrAlias:String; ABindSourceAdapter:IioActiveBindSourceAdapter; const AAlias:String=''): IioDependencyInjectionLocator; overload;
//    function ViewModel<T:IioViewModel>(const AModelClassName:String; const AWhere:String=''; const AAlias:String=''): IioDependencyInjectionLocator; overload;
//    function ViewModel<T:IioViewModel>(const AMasterBindSource:TioMasterBindSource; const AMasterPropertyName:String=''; const AAlias:String=''): IioDependencyInjectionLocator; overload;
//    function ViewModel<T:IioViewModel>(const ABindSourceAdapter:IioActiveBindSourceAdapter; const AAlias:String=''): IioDependencyInjectionLocator; overload;
  end;

  IioDependencyInjectionLocator<TI: IInterface> = interface(IioDependencyInjectionLocator)
    ['{EA9F3CAD-B9A2-4607-8D80-881EF4C36EDE}']
    function Get: TI; overload;
    function Alias(const AAlias:String): IioDependencyInjectionLocator<TI>;
    function ConstructorParams(const AParams: array of TValue): IioDependencyInjectionLocator<TI>;
    function ConstructorMethod(const AConstructorMethod: String): IioDependencyInjectionLocator<TI>;
    function ConstructorMarker(const AConstructorMarker: String): IioDependencyInjectionLocator<TI>;
    function ViewModel(const AViewModel:IioViewModel): IioDependencyInjectionLocator<TI>; overload;

    function ViewModel(const AInterfaceNameOrAlias, AModelClassName:String; const AWhere:String=''; const AAlias:String=''): IioDependencyInjectionLocator<TI>; overload;
    function ViewModel(const AInterfaceNameOrAlias:String; const AMasterBindSource:TioMasterBindSource; const AMasterPropertyName:String=''; const AAlias:String=''): IioDependencyInjectionLocator<TI>; overload;
    function ViewModel(const AInterfaceNameOrAlias:String; ABindSourceAdapter:IioActiveBindSourceAdapter; const AAlias:String=''): IioDependencyInjectionLocator<TI>; overload;
//    function ViewModel<T:IioViewModel>(const AModelClassName:String; const AWhere:String=''; const AAlias:String=''): IioDependencyInjectionLocator<TI>; overload;
//    function ViewModel<T:IioViewModel>(const AMasterBindSource:TioMasterBindSource; const AMasterPropertyName:String=''; const AAlias:String=''): IioDependencyInjectionLocator<TI>; overload;
//    function ViewModel<T:IioViewModel>(const ABindSourceAdapter:IioActiveBindSourceAdapter; const AAlias:String=''): IioDependencyInjectionLocator<TI>; overload;
  end;

implementation

uses
  System.SysUtils;

{ TioDIContainerImplementersItem }

constructor TioDIContainerImplementersItem.Create;
begin
  inherited;
  ObjInstance := nil;
  IntfInstance := nil;
end;

function TioDIContainerImplementersItem.GetObjInstance: TObject;
begin
  Result := Self.ObjInstance;
end;


function TioDIContainerImplementersItem.ObjInstanceExists: Boolean;
begin
  Result := Assigned(Self.ObjInstance);
end;

procedure TioDIContainerImplementersItem.SetObjInstance(AObj: TObject);
var
  AInterfacedObject: IInterface;
begin
  // Set the ObjInstance reference for the singleton object
  Self.ObjInstance := AObj;
  // If it is an interfaced object then set a reference (IInterface) to prevent someone else destroy it by RefCount
  if Supports(AObj, IInterface, AInterfacedObject) then
    Self.IntfInstance := AInterfacedObject
  else
    Self.IntfInstance := nil;
end;

end.
