unit PA.VM.ViewModelBase;

interface

uses
  System.SysUtils, System.Classes, IupOrm.MVVM.ALL.ViewModel, System.Actions, Vcl.ActnList,
  PA.VM.Interfaces;

type
  TpaViewModelBase= class(TioViewModel, IpaViewModel)
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
