unit PA.V.Interfaces;

interface

uses
  IupOrm.MVVM.Interfaces, IupOrm.Containers.Interfaces;

type

  // Base interface for all the views
  IpaView = interface(IioView)
    ['{EE0D88A6-824D-4B4A-83A3-C2757B50A227}']
    // Methods
//    procedure RecalcLayout;
    // Height
//    function GetHeight: Integer;
//    property Height: Integer read GetHeight;
    // MasterView
//    function GetMasterView: IpaView;
//    property MasterView: IpaView read GetMasterView;
    // ChildViews
//    function GetChildViews: IioList<IpaView>;
//    property ChildViews: IioList<IpaView> read GetChildViews;
  end;

  // Interface for the MasterView
  IpaViewMaster = interface(IpaView)
    ['{DE981CCA-2EBB-4799-8E1A-99053E07404F}']
  end;

  // Interface for any view containing data
  IpaViewData = interface(IpaView)
    ['{1A0DD72C-D704-4DCF-8227-697AEB669858}']
  end;

  // Interface for any view containing other views
  IpaViewContainerSimple = interface(IpaView)
    ['{A8506604-DEAB-4612-B6D2-611D3DDABA99}']
  end;

  // Interface for any view containing a list of other views
  IpaViewContainerList = interface(IpaView)
    ['{A8506604-DEAB-4612-B6D2-611D3DDABA99}']
  end;

implementation

end.
