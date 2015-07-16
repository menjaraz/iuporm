program PA;

uses
  Vcl.Forms,
  PA.FormMain in 'PA.FormMain.pas' {MainForm},
  PA.V.Interfaces in 'PA.V.Interfaces.pas',
  PA.VM.Interfaces in 'PA.VM.Interfaces.pas',
  PA.RegisterClasses in 'PA.RegisterClasses.pas',
  IupOrm.MVVM.ALL.ViewModel in '..\..\Source\IupOrm.MVVM.ALL.ViewModel.pas' {ioViewModel: TDataModule},
  PA.VM.ViewModelBase in 'PA.VM.ViewModelBase.pas' {paViewModelBase: TDataModule},
  PA.VM.ViewModelForViewService in 'PA.VM.ViewModelForViewService.pas' {paViewModelForViewService: TDataModule},
  fatturapa_v11 in 'fatturapa_v11.pas',
  XMLUtilities in 'XMLUtilities.pas',
  PA.V.View in 'PA.V.View.pas' {paView: TFrame},
  PA.V.ViewData in 'PA.V.ViewData.pas' {paViewData: TFrame},
  PA.V.ViewDataIdFiscaleType in 'PA.V.ViewDataIdFiscaleType.pas' {paViewDataIdFiscaleType: TFrame},
  PA.V.ViewDataContattiTrasmittenteType in 'PA.V.ViewDataContattiTrasmittenteType.pas' {paViewDataContattiTrasmittenteType: TFrame},
  PA.V.ViewDataAnagraficaType in 'PA.V.ViewDataAnagraficaType.pas' {paViewDataAnagraficaType: TFrame},
  PA.V.ViewDataDatiAnagraficiCedenteType in 'PA.V.ViewDataDatiAnagraficiCedenteType.pas' {paViewDataDataAnagraficiCedenteType: TFrame},
  PA.V.ViewDataCedentePrestatoreType in 'PA.V.ViewDataCedentePrestatoreType.pas' {paViewDataCedentePrestatoreType: TFrame},
  PA.V.ViewDataFatturaElettronicaHeaderType in 'PA.V.ViewDataFatturaElettronicaHeaderType.pas' {paViewDataFatturaElettronicaHeaderType: TFrame},
  PA.V.ViewDataFatturaElettronicaType in 'PA.V.ViewDataFatturaElettronicaType.pas' {paViewDataFatturaElettronicaType: TFrame},
  PA.V.ViewService in 'PA.V.ViewService.pas' {paViewService: TFrame},
  PA.VM.ViewModelForViewData in 'PA.VM.ViewModelForViewData.pas' {paViewModelForViewdata: TDataModule},
  PA.U.DuckTyped.XMLList in 'PA.U.DuckTyped.XMLList.pas',
  PA.U.DuckTyped.Interfaces in 'PA.U.DuckTyped.Interfaces.pas',
  PA.VM.ViewModelForViewContainer in 'PA.VM.ViewModelForViewContainer.pas' {paViewModelForViewContainer: TDataModule},
  PA.V.ViewContainer in 'PA.V.ViewContainer.pas' {paViewContainer: TFrame},
  PA.V.ViewContainerTab in 'PA.V.ViewContainerTab.pas' {paViewContainerTab: TFrame},
  PA.V.ViewContainerTabFatturaElettronicaBody in 'PA.V.ViewContainerTabFatturaElettronicaBody.pas' {paViewContainerTabFatturaElettronicaBody: TFrame},
  PA.V.ViewDataFatturaElettronicaBody in 'PA.V.ViewDataFatturaElettronicaBody.pas' {paViewDataFatturaElettronicaBody: TFrame},
  Frame in '..\TestParent\Frame.pas' {Frame1: TFrame},
  PA.V.ViewDataDatiGeneraliType in 'PA.V.ViewDataDatiGeneraliType.pas' {paViewDataDatiGenerali: TFrame},
  PA.V.ViewDataDatiGeneraliDocumentoType in 'PA.V.ViewDataDatiGeneraliDocumentoType.pas' {paViewDataDatiGeneraliDocumento: TFrame};

{$R *.res}
{$STRONGLINKTYPES ON}

begin
  ReportMemoryLeaksOnShutdown := True;


  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
