unit IupOrm.MVVM.ViewModel.ViewData;

interface

uses
  IupOrm.MVVM.Interfaces, IupOrm.LiveBindings.Interfaces,
  Data.Bind.ObjectScope, IupOrm.LiveBindings.PrototypeBindSource;

type

  TioViewData = class(TInterfacedObject, IioViewData)
  private
    FBindSourceAdapter: IioActiveBindSourceAdapter;
  protected
  public
    constructor Create; overload;
    constructor Create(const ADataObj:TObject; const AViewDataType:TioViewDataType); overload;
    constructor Create(const ADataIntf:IInterface; const AViewDataType:TioViewDataType); overload;
    constructor Create(const ATypeName, ATypeAlias, AWhere: String; const AViewDataType:TioViewDataType; const AAutoLoadData:Boolean=True); overload;
    constructor Create(const ABindSourceAdapter:IioActiveBindSourceAdapter); overload;
    constructor Create(const AMasterBindSource:TioMasterBindSource; const AMasterPropertyName:String=''); overload;
    constructor Create(const AMasterBindSourceAdapter:IioActiveBindSourceAdapter; const AMasterPropertyName:String); overload;
    procedure SetDataObj(AObj:TObject); overload;
    procedure SetDataObj(AIntf:IInterface); overload;
    function DataObj: TObject;
    function BindSourceAdapter: TBindSourceAdapter;
    function ActiveBindSourceAdapter: IioActiveBindSourceAdapter;
  end;

implementation

uses
  IupOrm.LiveBindings.ActiveListBindSourceAdapter, System.Generics.Collections,
  IupOrm.Context.Container,
  IupOrm.LiveBindings.ActiveInterfaceListBindSourceAdapter,
  IupOrm.LiveBindings.ActiveObjectBindSourceAdapter,
  IupOrm.LiveBindings.ActiveInterfaceObjectBindSourceAdapter, IupOrm,
  System.SysUtils, IupOrm.LiveBindings.Factory;

{ TViewData }

function TioViewData.ActiveBindSourceAdapter: IioActiveBindSourceAdapter;
begin
  Result := FBindSourceAdapter;
end;

function TioViewData.BindSourceAdapter: TBindSourceAdapter;
begin
  Result := FBindSourceAdapter as TBindSourceAdapter;
end;

constructor TioViewData.Create(const ADataIntf: IInterface; const AViewDataType:TioViewDataType);
begin
  Create(ADataIntf as TObject, AViewDataType);
{
  // Create the BindSourceAdapter
  Self.Create(
    (ADataIntf as TObject).ClassName,  // TypeName
    '',  // TypeAlias
    '',  // Where
    AViewDataType,  // ViewDataType
    False  // AutoLoadData
  );
  // Set the DataObject
  FBindSourceAdapter.SetDataObject(ADataIntf as TObject, False);  // OwnsObject = False for externally received objects
}
end;

constructor TioViewData.Create(const ADataObj: TObject; const AViewDataType:TioViewDataType);
begin
  // Create the BindSourceAdapter
  Self.Create(
    ADataObj.ClassName,  // TypeName
    '',  // TypeAlias
    '',  // Where
    AViewDataType,  // ViewDataType
    False  // AutoLoadData
  );
  // Set the DataObject
  FBindSourceAdapter.SetDataObject(ADataObj, False);  // OwnsObject = False for externally received objects
end;

constructor TioViewData.Create(const ABindSourceAdapter: IioActiveBindSourceAdapter);
begin
  inherited Create;
  FBindSourceAdapter := ABindSourceAdapter;
end;

function TioViewData.DataObj: TObject;
begin
  Result := FBindSourceAdapter.GetDataObject;
end;

procedure TioViewData.SetDataObj(AObj: TObject);
begin
  FBindSourceAdapter.SetDataObject(Aobj);
end;

procedure TioViewData.SetDataObj(AIntf: IInterface);
begin
  FBindSourceAdapter.SetDataObject(AIntf as TObject);
end;

constructor TioViewData.Create(const ATypeName, ATypeAlias, AWhere: String; const AViewDataType:TioViewDataType; const AAutoLoadData:Boolean=True);
var
  LocalBSA: TBindSourceAdapter;
begin
  inherited Create;
  // Get the BindSourceAdapter
  case AViewDataType of
    // Single type BSA
    dtSingle:
      LocalBSA := TIupOrm.Load(ATypeName, ATypeAlias)._Where(AWhere).ToActiveObjectBindSourceAdapter(nil, AAutoLoadData);
    // List type BSA
    dtList:
      LocalBSA := TIupOrm.Load(ATypeName, ATypeAlias)._Where(AWhere).ToActiveListBindSourceAdapter(nil, AAutoLoadData);
  end;
  // Assign the BSA
  Supports(LocalBSA, IioActiveBindSourceAdapter, FBindSourceAdapter);
end;

constructor TioViewData.Create(const AMasterBindSource: TioMasterBindSource; const AMasterPropertyName: String);
var
  LocalBSA: TBindSourceAdapter;
begin
  inherited Create;
  // Get the BindSourceAdapter
  LocalBSA := TioLiveBindingsFactory.GetBSAfromMasterBindSource(nil, AMasterBindSource, AMasterPropertyName);
  // Assign the BSA
  Supports(LocalBSA, IioActiveBindSourceAdapter, FBindSourceAdapter);
end;

constructor TioViewData.Create;
begin
  FBindSourceAdapter := nil;
end;

constructor TioViewData.Create(const AMasterBindSourceAdapter: IioActiveBindSourceAdapter; const AMasterPropertyName: String);
var
  LocalBSA: TBindSourceAdapter;
begin
  inherited Create;
  // Get the BindSourceAdapter from the MasterBindSourceAdapter
  LocalBSA := TioLiveBindingsFactory.GetBSAfromMasterBindSourceAdapter(nil, AMasterBindSourceAdapter, AMasterPropertyName);  // NB; Owner := nil
  // Assign the BSA
  Supports(LocalBSA, IioActiveBindSourceAdapter, FBindSourceAdapter);
end;

end.
