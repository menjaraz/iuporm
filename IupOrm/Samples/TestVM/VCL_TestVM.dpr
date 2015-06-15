program VCL_TestVM;

uses
  Vcl.Forms,
  VCL_FormMain in 'VCL_FormMain.pas' {MainForm},
  IupOrm.MVVM.ALL.ViewModel in '..\..\Source\IupOrm.MVVM.ALL.ViewModel.pas' {ioViewModel: TDataModule},
  VCL_ViewModelU in 'VCL_ViewModelU.pas' {VCL_ViewModel: TDataModule},
  VCL_InterfacesU in 'VCL_InterfacesU.pas',
  VCL_RegisterClasses in 'VCL_RegisterClasses.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
