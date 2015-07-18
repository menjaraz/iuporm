unit PA.V.ViewDataDatiGeneraliDocumentoType;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, PA.V.ViewData, Vcl.StdCtrls, Vcl.ComCtrls, Data.Bind.Components, Data.Bind.ObjectScope,
  IupOrm.LiveBindings.PrototypeBindSource, Vcl.Bind.GenData, Data.Bind.GenData, System.Rtti, System.Bindings.Outputs,
  Vcl.Bind.Editors, Data.Bind.EngExt, Vcl.Bind.DBEngExt, Vcl.ExtCtrls;

type
  TpaViewDataDatiGeneraliDocumento = class(TpaViewData)
    BSDatiGeneraliDocumento: TioPrototypeBindSource;
    BindingsList1: TBindingsList;
    LinkFillControlToField1: TLinkFillControlToField;
    LinkFillControlToField2: TLinkFillControlToField;
    Label1: TLabel;
    eTipoDocumento: TEdit;
    Label5: TLabel;
    eDivisa: TEdit;
    Label6: TLabel;
    eData: TEdit;
    Label7: TLabel;
    eNumero: TEdit;
    Button1: TButton;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField3: TLinkControlToField;
    LinkControlToField4: TLinkControlToField;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  paViewDataDatiGeneraliDocumento: TpaViewDataDatiGeneraliDocumento;

implementation

{$R *.dfm}

procedure TpaViewDataDatiGeneraliDocumento.Button1Click(Sender: TObject);
begin
  inherited;
  BSDatiGeneraliDocumento.Post;
end;

end.
