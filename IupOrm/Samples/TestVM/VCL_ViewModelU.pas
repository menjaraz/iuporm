unit VCL_ViewModelU;

interface

uses
  System.SysUtils, System.Classes, IupOrm.MVVM.ALL.ViewModel, System.Actions, Vcl.ActnList,
  VCL_InterfacesU, Vcl.ExtCtrls;

type
  TVCL_ViewModel = class(TioViewModel, IVCL_ViewModel)
    acHello: TAction;
    acOnOff: TAction;
    procedure acHelloExecute(Sender: TObject);
    procedure acOnOffExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  VCL_ViewModel: TVCL_ViewModel;

implementation

uses
  Vcl.Dialogs;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TVCL_ViewModel.acHelloExecute(Sender: TObject);
begin
  inherited;
  ShowMessage('Hello!');
end;

procedure TVCL_ViewModel.acOnOffExecute(Sender: TObject);
begin
  inherited;
  acHello.Enabled := not acHello.Enabled;
end;

end.
