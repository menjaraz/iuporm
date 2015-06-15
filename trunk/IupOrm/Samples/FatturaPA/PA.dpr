program PA;

uses
  Vcl.Forms,
  PA.FormMain in 'PA.FormMain.pas' {MainForm},
  PA.V.Interfaces in 'PA.V.Interfaces.pas',
  PA.VM.Interfaces in 'PA.VM.Interfaces.pas',
  PA.RegisterClasses in 'PA.RegisterClasses.pas',
  IupOrm.MVVM.ALL.ViewModel in '..\..\Source\IupOrm.MVVM.ALL.ViewModel.pas' {ioViewModel: TDataModule},
  PA.VM.ViewModelBase in 'PA.VM.ViewModelBase.pas' {paViewModelBase: TDataModule},
  PA.VM.ViewModelForMasterView in 'PA.VM.ViewModelForMasterView.pas' {paViewModelForMasterView: TDataModule},
  fatturapa_v11 in 'fatturapa_v11.pas',
  XMLUtilities in 'XMLUtilities.pas',
  PA.V.View in 'PA.V.View.pas' {paView: TFrame},
  PA.V.ViewData in 'PA.V.ViewData.pas' {paViewData: TFrame},
  PA.V.ViewDataIdFiscaleType in 'PA.V.ViewDataIdFiscaleType.pas' {paViewDataIdFiscaleType: TFrame},
  PA.V.ViewDataContattiTrasmittenteType in 'PA.V.ViewDataContattiTrasmittenteType.pas' {paViewDataContattiTrasmittenteType: TFrame},
  PA.V.ViewDataProva in 'PA.V.ViewDataProva.pas' {paViewDataProva: TFrame},
  PA.V.ViewDataAnagraficaType in 'PA.V.ViewDataAnagraficaType.pas' {paViewDataAnagraficaType: TFrame},
  PA.V.ViewDataDatiAnagraficiCedenteType in 'PA.V.ViewDataDatiAnagraficiCedenteType.pas' {paViewDataDataAnagraficiCedenteType: TFrame},
  PA.V.ViewDataCedentePrestatoreType in 'PA.V.ViewDataCedentePrestatoreType.pas' {paViewDataCedentePrestatoreType: TFrame},
  PA.V.ViewDataFatturaElettronicaHeaderType in 'PA.V.ViewDataFatturaElettronicaHeaderType.pas' {paViewDataFatturaElettronicaHeaderType: TFrame},
  PA.V.FatturaElettronicaType in 'PA.V.FatturaElettronicaType.pas' {paViewDataFatturaElettronicaType: TFrame},
  PA.V.Master in 'PA.V.Master.pas' {paViewDataMaster: TFrame},
  PA.VM.ViewModelForDataView in 'PA.VM.ViewModelForDataView.pas' {paViewModelForDataView: TDataModule};

{$R *.res}
{$STRONGLINKTYPES ON}

begin
  ReportMemoryLeaksOnShutdown := True;


  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
