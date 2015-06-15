unit PA.VM.ViewModelForDataView;

interface

uses
  System.SysUtils, System.Classes, PA.VM.ViewModelBase, System.Actions, Vcl.ActnList,
  PA.VM.Interfaces;

type
  TpaViewModelForDataView = class(TpaViewModelBase, IpaViewModelForDataView)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  paViewModelForDataView: TpaViewModelForDataView;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
