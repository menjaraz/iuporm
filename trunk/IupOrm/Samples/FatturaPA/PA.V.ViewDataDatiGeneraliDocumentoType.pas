unit PA.V.ViewDataDatiGeneraliDocumentoType;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, PA.V.ViewData, Vcl.StdCtrls, Vcl.ComCtrls, Data.Bind.Components, Data.Bind.ObjectScope,
  IupOrm.LiveBindings.PrototypeBindSource, Vcl.Bind.GenData, Data.Bind.GenData, System.Rtti, System.Bindings.Outputs,
  Vcl.Bind.Editors, Data.Bind.EngExt, Vcl.Bind.DBEngExt;

type
  TpaViewDataDatiGeneraliDocumento = class(TpaViewData)
    Label1: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    eNumero: TEdit;
    BSDatiGeneraliDocumento: TioPrototypeBindSource;
    BindingsList1: TBindingsList;
    LinkFillControlToField1: TLinkFillControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkFillControlToField2: TLinkFillControlToField;
    eTipoDocumento: TEdit;
    eDivisa: TEdit;
    eData: TEdit;
    LinkControlToField3: TLinkControlToField;
    LinkControlToField4: TLinkControlToField;
    LinkControlToField5: TLinkControlToField;
    Button1: TButton;
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
