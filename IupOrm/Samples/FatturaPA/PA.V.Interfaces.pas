unit PA.V.Interfaces;

interface

uses
  IupOrm.MVVM.Interfaces, IupOrm.Containers.Interfaces, Vcl.Controls,
  Winapi.Windows;

type

  // Base interface for all the views
  IpaView = interface(IioView)
    ['{EE0D88A6-824D-4B4A-83A3-C2757B50A227}']
    // Parent property
    procedure SetParent(AParent: TWinControl);
    function GetParent: TWinControl;
    property Parent: TWinControl read GetParent write SetParent;
    // Height property
    function GetHeight: Integer;
    property Height: Integer read GetHeight;
    // Handle property
    function GetHandle: HWND;
    property Handle: HWND read GetHandle;
    // LeftSidePanelVisible property
    function GetSelectedVisible: Boolean;
    procedure SetSelectedVisible(const Value: Boolean);
    property SelectedVisible:Boolean read GetSelectedVisible write SetSelectedVisible;
    // Selected property
    function GetSelected: Boolean;
    procedure SetSelected(const Value: Boolean);
    property Selected:Boolean read GetSelected write SetSelected;
  end;

  // Interface for any view containing data
  IpaViewData = interface(IpaView)
    ['{1A0DD72C-D704-4DCF-8227-697AEB669858}']
  end;

  // Interface for the MasterView
  IpaViewService = interface(IpaView)
    ['{DE981CCA-2EBB-4799-8E1A-99053E07404F}']
  end;

  // Interface for any view containing a list of other views
  IpaViewContainer = interface(IpaView)
    ['{A8506604-DEAB-4612-B6D2-611D3DDABA99}']
  end;

implementation

end.
