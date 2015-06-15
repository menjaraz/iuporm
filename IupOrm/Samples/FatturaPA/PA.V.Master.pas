unit PA.V.Master;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, PA.V.ViewData, Vcl.ExtCtrls, Vcl.StdCtrls, PA.V.View, PA.V.FatturaElettronicaType,
  Data.Bind.Components, Data.Bind.ObjectScope, IupOrm.LiveBindings.PrototypeBindSource, IupOrm.Attributes,
  IupOrm.MVVM.Interfaces;

type
  TpaViewDataMaster = class(TpaViewData)
    Panel1: TPanel;
    [ioAction('acNew')]
    ButtonNew: TButton;
    [ioAction('acLoadFromFile')]
    ButtonLoad: TButton;
    [ioAction('acSaveToFile')]
    ButtonSave: TButton;
    paViewDataFatturaElettronicaType1: TpaViewDataFatturaElettronicaType;
    BSMaster: TioPrototypeBindSource;
    procedure BSMasterioOnNeedViewModel(Sender: TioPrototypeBindSource; var AViewModel: IioViewModel);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  paViewDataMaster: TpaViewDataMaster;

implementation

uses
  PA.VM.Interfaces;

{$R *.dfm}

procedure TpaViewDataMaster.BSMasterioOnNeedViewModel(Sender: TioPrototypeBindSource; var AViewModel: IioViewModel);
var
  ATargetViewModel: IpaViewModelForMasterView;
begin
  inherited;
  if not Supports(AViewModel, IpaViewModelForMasterView, ATargetViewModel) then
    raise Exception.Create('"IpaViewModelForMasterView" interface is not implemented by object.');
  ATargetViewModel.SetTargetBindSourceAdapter(paViewDataFatturaElettronicaType1.BSFatturaElettronica.ioViewModel.ViewData.ActiveBindSourceAdapter);
end;

end.
