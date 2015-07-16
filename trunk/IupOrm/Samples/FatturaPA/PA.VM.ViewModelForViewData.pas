unit PA.VM.ViewModelForViewData;

interface

uses
  System.SysUtils, System.Classes, PA.VM.ViewModelBase, System.Actions, Vcl.ActnList,
  PA.VM.Interfaces;

type
  TpaViewModelForViewdata = class(TpaViewModelBase, IpaViewModelForViewData)
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
