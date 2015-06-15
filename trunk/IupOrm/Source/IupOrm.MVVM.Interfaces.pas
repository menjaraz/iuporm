unit IupOrm.MVVM.Interfaces;

interface

uses
  IupOrm.LiveBindings.Interfaces, Data.Bind.ObjectScope, System.Classes;

type

  TioViewDataType = (dtSingle, dtList);

  IioView = interface
    ['{AE9431A3-4D53-4ACF-98A1-7870DB6F7B0F}']
    function FindComponent(const AName: string): TComponent;
  end;

  IioViewData = interface
    ['{A8E74DA6-81BF-446C-A524-7E98F0D09CEF}']
    function DataObj: TObject;
    procedure SetDataObj(AObj:TObject); overload;
    procedure SetDataObj(AIntf:IInterface); overload;
    function BindSourceAdapter: TBindSourceAdapter;
    function ActiveBindSourceAdapter: IioActiveBindSourceAdapter;
  end;

  IioViewModel = interface
    ['{B8A32927-A4DA-4B8D-8545-AB68DEDF17BC}']
    function ViewData: IioViewData;
    function GetActionByName(AActionName:String): TBasicAction;
//    procedure BindActions(const AView:IioView);
    // TypeName
    procedure SetTypeName(const Value: String);
    function GetTypeName: String;
    property ioTypeName:String read GetTypeName write SetTypeName;
    // TypeAlias
    procedure SetTypeAlias(const Value: String);
    function GetTypeAlias: String;
    property ioTypeAlias:String read GetTypeAlias write SetTypeAlias;
    // Where
    procedure SetWhere(const Value: String);
    function GetWhere: String;
    property ioWhere:String read GetWhere write SetWhere;
    // MasterBindSource
    procedure SetMasterBindSource(const Value: TObject);
    function GetMasterBindSource: TObject;
    property ioMasterBindSource:TObject read GetMasterBindSource write SetMasterBindSource;
    // MasterPropertyName
    procedure SetMasterPropertyName(const Value: String);
    function GetMasterPropertyName: String;
    property ioMasterPropertyName:String read GetMasterPropertyName write SetMasterPropertyName;
    // AutoLoadData
    procedure SetAutoLoadData(const Value: Boolean);
    function GetAutoLoadData: Boolean;
    property ioAutoLoadData:Boolean read GetAutoLoadData write SetAutoLoadData;
    // ViewDataType
    procedure SetViewDataType(const Value: TioViewDataType);
    function GetViewDataType: TioViewDataType;
    property ioViewDataType:TioViewDataType read GetViewDataType write SetViewDataType;
 end;

implementation

end.
