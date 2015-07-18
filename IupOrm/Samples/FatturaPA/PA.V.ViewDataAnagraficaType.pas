unit PA.V.ViewDataAnagraficaType;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, PA.V.ViewData, Vcl.StdCtrls, Vcl.Bind.GenData, System.Rtti, System.Bindings.Outputs,
  Vcl.Bind.Editors, Data.Bind.EngExt, Vcl.Bind.DBEngExt, Data.Bind.Components, Data.Bind.ObjectScope,
  IupOrm.LiveBindings.PrototypeBindSource, Vcl.ExtCtrls;

type
  TpaViewDataAnagraficaType = class(TpaViewData)
    BSAnagraficaType: TioPrototypeBindSource;
    BindingsList1: TBindingsList;
    Label2: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    eDenominazione: TEdit;
    eNome: TEdit;
    eTitolo: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    eCognome: TEdit;
    eCodEORI: TEdit;
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
