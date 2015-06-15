unit PA.VM.Interfaces;

interface

uses
  IupOrm.MVVM.Interfaces, IupOrm.LiveBindings.Interfaces;

type

  IpaViewModel = interface(IioViewModel)
    ['{39ACB31A-B790-4D22-8384-CA23DE4EDABB}']
  end;

  IpaViewModelForMasterView = interface(IpaViewModel)
    ['{82B47B52-B35E-4C3A-A066-5817CDFF7A71}']
    procedure SetTargetBindSourceAdapter(const ATargetBindSourceAdapter:IioActiveBindSourceAdapter);
  end;

  IpaViewModelForDataView = interface(IpaViewModel)
    ['{13474D3C-1155-46ED-A658-FDC3C959CBC7}']
  end;

  IpaViewModelForContainerSimpleView = interface(IpaViewModel)
    ['{06680C63-B123-4640-9936-2346EDD7C74E}']
  end;

  IpaViewModelForContainerListView = interface(IpaViewModel)
    ['{02B550D0-C281-4627-BF28-28C8F0D911C7}']
  end;

implementation

end.
