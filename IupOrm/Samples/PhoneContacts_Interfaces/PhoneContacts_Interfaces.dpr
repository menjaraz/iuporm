program PhoneContacts_Interfaces;

uses
  System.StartUpCopy,
  FMX.MobilePreview,
  FMX.Forms,
  TabbedFormwithNavigation in 'TabbedFormwithNavigation.pas' {TabbedwithNavigationForm},
  Model in 'Model.pas',
  System.IOUtils,
  IupOrm,
  SampleData in 'SampleData.pas',
  Interfaces in 'Interfaces.pas',
  RegisterClassesUnit in 'RegisterClassesUnit.pas',
  AnotherModel in 'AnotherModel.pas';

{$R *.res}
{$STRONGLINKTYPES ON}

begin
  ReportMemoryLeaksOnShutdown := True;


  // ============ IupOrm initialization ====================
  // Set connection for SQLite (under the Documents folder better for mobile use)
//  TIupOrm.ConnectionManager.NewSQLiteConnectionDef(TPath.Combine(TPath.GetDocumentsPath, 'ContactsIntf.db')).Apply;
  // Set connection for Firebird SQL
  TIupOrm.ConnectionManager.NewFirebirdConnectionDef('localhost', TPath.GetFullPath('..\..\..\SamplesData\ContactsIntf.FDB'), 'SYSDBA', 'masterkey', '').Apply;
  // AutoCreation and AutoUpdate of the database
  TIupOrm.AutoCreateDatabase(False);
  // Check for sample data creation
  TSampleData.CheckForSampleDataCreation;
  // ============ IupOrm initialization ====================


  Application.Initialize;
  Application.CreateForm(TTabbedwithNavigationForm, TabbedwithNavigationForm);
  Application.Run;
end.
