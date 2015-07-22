program Pizza_ioActiveBindSourceAdapter;

uses
  System.StartUpCopy,
  FMX.MobilePreview,
  FMX.Forms,
  Main in 'Main.pas' {MainForml},
  Model in 'Model.pas',
  IOUtils,
  IupOrm;

{$R *.res}
{$STRONGLINKTYPES ON}

begin
  ReportMemoryLeaksOnShutdown := True;

  // ============ IupOrm initialization ====================
  // Set connection for SQLite (under the Documents folder better for mobile use)
  TIupOrm.ConnectionManager.NewSQLiteConnectionDef(TPath.Combine(TPath.GetDocumentsPath, 'Pizza.db')).Apply;
  // Set connection for Firebird SQL
//  TIupOrm.ConnectionManager.NewFirebirdConnectionDef('localhost', TPath.GetFullPath('..\..\..\SamplesData\Pizza.FDB'), 'SYSDBA', 'masterkey', '').Apply;
  // AutoCreation and AutoUpdate of the database
  TIupOrm.AutoCreateDatabase(False);
  // ============ IupOrm initialization ====================

  Application.Initialize;
  Application.CreateForm(TMainForml, MainForml);
  Application.Run;
end.
