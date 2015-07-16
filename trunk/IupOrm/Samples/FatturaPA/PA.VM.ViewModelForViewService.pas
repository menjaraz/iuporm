unit PA.VM.ViewModelForViewService;

interface

uses
  System.SysUtils, System.Classes, System.Actions, Vcl.ActnList,
  PA.VM.ViewModelBase, PA.VM.Interfaces, Vcl.Dialogs,
  fatturapa_v11, IupOrm.LiveBindings.Interfaces, Vcl.ExtCtrls, Vcl.Controls,
  PA.V.Interfaces;

type
  TpaViewModelForViewService = class(TpaViewModelBase, IpaViewModelForViewService)
    acNew: TAction;
    acLoadFromFile: TAction;
    acSaveToFile: TAction;
    OD1: TOpenDialog;
    SD1: TSaveDialog;
    acClose: TAction;
    procedure acNewExecute(Sender: TObject);
    procedure acLoadFromFileExecute(Sender: TObject);
    procedure acSaveToFileExecute(Sender: TObject);
    procedure acSaveToFileUpdate(Sender: TObject);
    procedure acCloseExecute(Sender: TObject);
    procedure acCloseUpdate(Sender: TObject);
  private
    { Private declarations }
    FClientArea: TWinControl;
    FFattura: IXMLFatturaElettronicaType;
    FTargetView: IpaView;
    FTargetViewModel: IpaViewModel;
    FTargetBindSourceAdapter: IioActiveBindSourceAdapter;
  protected
    function CanSave: Boolean; virtual;
    procedure NewTargetViewViewModel; virtual;
    procedure Clear; virtual;
  public
    { Public declarations }
    procedure SetClientArea(AClientArea:TWinControl);
  end;


implementation

uses
  IupOrm, System.Rtti, IupOrm.MVVM.Interfaces;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TpaViewModelForViewService.acCloseExecute(Sender: TObject);
begin
  inherited;
  Self.Clear;
end;

procedure TpaViewModelForViewService.acCloseUpdate(Sender: TObject);
begin
  inherited;
  (Sender as TAction).Enabled := CanSave;
end;

procedure TpaViewModelForViewService.acLoadFromFileExecute(Sender: TObject);
begin
  inherited;
  if OD1.Execute then
  begin
    // Load the document
    FFattura := LoadFatturaElettronica(OD1.FileName);
    // Create the View+ViewModel
    Self.NewTargetViewViewModel;
  end;
end;

procedure TpaViewModelForViewService.acNewExecute(Sender: TObject);
begin
  inherited;
  // Create a new documetn
  FFattura := NewFatturaElettronica;
  // Create the View+ViewModel
  Self.NewTargetViewViewModel;
end;

procedure TpaViewModelForViewService.acSaveToFileExecute(Sender: TObject);
begin
  inherited;
  if SD1.Execute then
  begin
    // Force a post
    FTargetBindSourceAdapter.Edit;
    FTargetBindSourceAdapter.Post;
    // Save the document
    Self.FFattura.OwnerDocument.SaveToFile(SD1.FileName);
  end;
end;

procedure TpaViewModelForViewService.acSaveToFileUpdate(Sender: TObject);
begin
  inherited;
  (Sender as TAction).Enabled := CanSave;
end;

function TpaViewModelForViewService.CanSave: Boolean;
begin
  Result := Assigned(FTargetBindSourceAdapter) and Assigned(FTargetBindSourceAdapter.Current);
end;

procedure TpaViewModelForViewService.Clear;
begin
  (FTargetView as TObject).Free;

  FTargetView := nil;
  FTargetViewModel := nil;
  FTargetBindSourceAdapter := nil;
  FFattura := nil;
  // Reset singletons references on iupORM
//  TIupOrm.DependencyInjection.Singletons.ResetAll;
end;

procedure TpaViewModelForViewService.NewTargetViewViewModel;
begin
  // New level for singleton lifetime manager
  TIupOrm.DependencyInjection.Singletons.NextLevel;
  try
    // Create the root ViewModel
    FTargetViewModel := TIupOrm.DependencyInjection
      .Locate<IpaViewModelForViewData>('0:FatturaElettronica')
      .ConstructorMarker('CreateByTypeName')
      .ConstructorParams(['IXMLFatturaElettronicaType', '', '', TValue.From<TioViewDataType>(dtSingle), False])
      .Get;
    // Create the root View and set her parent
    FTargetView := TIupOrm.DependencyInjection
      .Locate<IpaViewData>('0:FatturaElettronica')
      .ViewModel(FTargetViewModel, 'BSFatturaElettronica')
      .ConstructorParams([nil])  // Owner
      .Get;
    FTargetView.Parent := Self.FClientArea;
    // Set the TargetBindSourceAdapter
    FTargetBindSourceAdapter := FTargetViewModel.ViewData.ActiveBindSourceAdapter;
    // Set the adapter DataObject
    FTargetBindSourceAdapter.SetDataObject(FFattura as TObject);
  finally
    // Release the new level for singleton lifetime manager
    TIupOrm.DependencyInjection.Singletons.ReleaseLevel;
  end;
end;

procedure TpaViewModelForViewService.SetClientArea(AClientArea: TWinControl);
begin
  FClientArea := AClientArea;
end;

end.
