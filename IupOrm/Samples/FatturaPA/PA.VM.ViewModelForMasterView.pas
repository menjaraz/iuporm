unit PA.VM.ViewModelForMasterView;

interface

uses
  System.SysUtils, System.Classes, System.Actions, Vcl.ActnList,
  PA.VM.ViewModelBase, PA.VM.Interfaces, Vcl.Dialogs,
  fatturapa_v11, IupOrm.LiveBindings.Interfaces, Vcl.ExtCtrls;

type
  TpaViewModelForMasterView = class(TpaViewModelBase, IpaViewModelForMasterView)
    acNew: TAction;
    acLoadFromFile: TAction;
    acSaveToFile: TAction;
    OD1: TOpenDialog;
    SD1: TSaveDialog;
    procedure acNewExecute(Sender: TObject);
    procedure acLoadFromFileExecute(Sender: TObject);
    procedure acSaveToFileExecute(Sender: TObject);
    procedure acSaveToFileUpdate(Sender: TObject);
  private
    { Private declarations }
    FTargetBindSourceAdapter: IioActiveBindSourceAdapter;
    function CanSave: Boolean;
    procedure SetFatturaToTarget(AFattura:IXMLFatturaElettronicaType);
    function GetFatturaFromTarget: IXMLFatturaElettronicaType;
  public
    { Public declarations }
    procedure SetTargetBindSourceAdapter(const ATargetBindSourceAdapter:IioActiveBindSourceAdapter);
  end;


implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TpaViewModelForMasterView.acLoadFromFileExecute(Sender: TObject);
var
  AFattura: IXMLFatturaElettronicaType;
begin
  inherited;
  if OD1.Execute then
  begin
    AFattura := LoadFatturaElettronica(OD1.FileName);
    SetFatturaToTarget(AFattura);
  end;
end;

procedure TpaViewModelForMasterView.acNewExecute(Sender: TObject);
var
  AFattura: IXMLFatturaElettronicaType;
begin
  inherited;
  AFattura := NewFatturaElettronica;
  SetFatturaToTarget(AFattura);
end;

procedure TpaViewModelForMasterView.acSaveToFileExecute(Sender: TObject);
//var
//  SL: TStrings;
begin
  inherited;

  if SD1.Execute then
  begin
    Self.GetFatturaFromTarget.OwnerDocument.SaveToFile(SD1.FileName);
//    SL := TStringList.Create;
//    SL.Add(AFattura.XML);
//    SL.SaveToFile(SD1.FileName);
//    SL.Free;
  end;
end;

procedure TpaViewModelForMasterView.acSaveToFileUpdate(Sender: TObject);
begin
  inherited;
  (Sender as TAction).Enabled := CanSave;
end;

function TpaViewModelForMasterView.CanSave: Boolean;
begin
  Result := Assigned(FTargetBindSourceAdapter) and Assigned(FTargetBindSourceAdapter.Current);
end;

function TpaViewModelForMasterView.GetFatturaFromTarget: IXMLFatturaElettronicaType;
var
  ACurrent: TObject;
  AFattura: IXMLFatturaElettronicaType;
begin
  FTargetBindSourceAdapter.Edit;
  FTargetBindSourceAdapter.Post;

  ACurrent := FTargetBindSourceAdapter.Current;
  if not Assigned(ACurrent) then
    raise Exception.Create('Fattura PA non presente.');

  if not Supports(ACurrent, IXMLFatturaElettronicaType, AFattura) then
    raise Exception.Create('The current object is not implementing "IXMLFatturaElettronicaType" interface.');

  Result := AFattura;
end;

procedure TpaViewModelForMasterView.SetFatturaToTarget(AFattura: IXMLFatturaElettronicaType);
begin
  // Set the adapter DataObject
  FTargetBindSourceAdapter.SetDataObject(AFattura as TObject);
end;

procedure TpaViewModelForMasterView.SetTargetBindSourceAdapter(const ATargetBindSourceAdapter: IioActiveBindSourceAdapter);
begin
  FTargetBindSourceAdapter := ATargetBindSourceAdapter;
end;

end.
