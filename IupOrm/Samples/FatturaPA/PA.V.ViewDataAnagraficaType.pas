unit PA.V.ViewDataAnagraficaType;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, PA.V.ViewData, Vcl.StdCtrls, Vcl.Bind.GenData, System.Rtti, System.Bindings.Outputs,
  Vcl.Bind.Editors, Data.Bind.EngExt, Vcl.Bind.DBEngExt, Data.Bind.Components, Data.Bind.ObjectScope,
  IupOrm.LiveBindings.PrototypeBindSource;

type
  TpaViewDataAnagraficaType = class(TpaViewData)
    Label2: TLabel;
    eDenominazione: TEdit;
    Label3: TLabel;
    eNome: TEdit;
    Label4: TLabel;
    eCognome: TEdit;
    Label1: TLabel;
    eTitolo: TEdit;
    Label5: TLabel;
    eCodEORI: TEdit;
    BSAnagraficaType: TioPrototypeBindSource;
    BindingsList1: TBindingsList;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField3: TLinkControlToField;
    LinkControlToField4: TLinkControlToField;
    LinkControlToField5: TLinkControlToField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  paViewDataAnagraficaType: TpaViewDataAnagraficaType;

implementation

{$R *.dfm}

end.
