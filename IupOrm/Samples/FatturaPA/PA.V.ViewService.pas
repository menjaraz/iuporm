unit PA.V.ViewService;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, PA.V.ViewData, Vcl.ExtCtrls, Vcl.StdCtrls, PA.V.View, PA.V.ViewDataFatturaElettronicaType,
  Data.Bind.Components, Data.Bind.ObjectScope, IupOrm.LiveBindings.PrototypeBindSource, IupOrm.Attributes,
  IupOrm.MVVM.Interfaces, PA.V.Interfaces;

type
  TpaViewService = class(TpaView, IpaViewService)
    PanelTools: TPanel;
    [ioAction('acNew')]
    ButtonNew: TButton;
    [ioAction('acLoadFromFile')]
    ButtonLoad: TButton;
    [ioAction('acSaveToFile')]
    ButtonSave: TButton;
    [ioAction('acClose')]
    ButtonClose: TButton;
    BSService: TioPrototypeBindSource;
    ClientArea: TPanel;
    procedure BSServiceioOnNeedViewModel(Sender: TioPrototypeBindSource; var AViewModel: IioViewModel);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses
  PA.VM.Interfaces;

{$R *.dfm}

procedure TpaViewService.BSServiceioOnNeedViewModel(Sender: TioPrototypeBindSource; var AViewModel: IioViewModel);
var
  AViewModelForViewService: IpaViewModelForViewService;
begin
  inherited;
  // Extract the IpaViewModelForViewService
  if not Supports(AViewModel, IpaViewModelForViewService, AViewModelForViewService) then
    raise Exception.Create('"ViewModelForViewService" interface is not implemented by object.');
  AViewModelForViewService.SetClientArea(ClientArea);
end;

end.
