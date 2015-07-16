unit PA.VM.Interfaces;

interface

uses
  IupOrm.MVVM.Interfaces, IupOrm.LiveBindings.Interfaces,
  IupOrm.Containers.Interfaces, PA.V.Interfaces, Vcl.Controls;

type

  TFunctionResizeView = reference to function: Boolean;

  IpaViewModel = interface(IioViewModel)
    ['{39ACB31A-B790-4D22-8384-CA23DE4EDABB}']
    // Views resize methods
    procedure SetFunctionResizeView(AFunctionResizeView: TFunctionResizeView);
    procedure ChildViewResized;
    procedure ViewResized;
    // ContainedIndex property
    function GetContainedIndex: Integer;
    procedure SetContainedIndex(const Value: Integer);
    property ContainedIndex: Integer read GetContainedIndex write SetContainedIndex;
  end;

  IpaViewModelForViewData = interface(IpaViewModel)
    ['{13474D3C-1155-46ED-A658-FDC3C959CBC7}']
  end;

  IpaViewModelForViewContainer = interface(IpaViewModel)
    ['{02B550D0-C281-4627-BF28-28C8F0D911C7}']
    function ChildViews: IioList<IpaView>;
    procedure Delete(const Index: Integer);
    procedure SetOnAfterOpenEventHandler;
    // Property ChildView_Interface
    procedure SetChildView_Interface(AValue: String);
    function GetChildView_Interface: String;
    property ChildView_Interface:String read GetChildView_Interface write SetChildView_Interface;
    // Property ChildView_Alias
    procedure SetChildView_Alias(AValue: String);
    function GetChildView_Alias: String;
    property ChildView_Alias:String read GetChildView_Alias write SetChildView_Alias;
    // Property ChildVM_Interface
    procedure SetChildVM_Interface(AValue: String);
    function GetChildVM_Interface: String;
    property ChildVM_Interface:String read GetChildVM_Interface write SetChildVM_Interface;
    // Property ChildVM_Alias
    procedure SetChildVM_Alias(AValue: String);
    function GetChildVM_Alias: String;
    property ChildVM_Alias:String read GetChildVM_Alias write SetChildVM_Alias;
  end;

  IpaViewModelForViewService = interface(IpaViewModel)
    ['{82B47B52-B35E-4C3A-A066-5817CDFF7A71}']
    procedure SetClientArea(AClientArea:TWinControl);
  end;

implementation

end.
