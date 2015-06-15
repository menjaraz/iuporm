unit PA.V.ViewDataIdFiscaleType;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, PA.V.ViewData, Vcl.Bind.GenData, Data.Bind.Components, Data.Bind.ObjectScope,
  IupOrm.LiveBindings.PrototypeBindSource, Vcl.StdCtrls, Vcl.ComCtrls, System.Rtti, System.Bindings.Outputs, Vcl.Bind.Editors,
  Data.Bind.EngExt, Vcl.Bind.DBEngExt;

type
  TpaViewDataIdFiscaleType = class(TpaViewData)
    BSIdFiscaleType: TioPrototypeBindSource;
    Label1: TLabel;
    Label2: TLabel;
    eIdCodice: TEdit;
    eIdPaese: TComboBox;
    BindingsList1: TBindingsList;
    LinkFillControlToField1: TLinkFillControlToField;
    LinkControlToField1: TLinkControlToField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  paViewDataIdFiscaleType: TpaViewDataIdFiscaleType;

implementation

{$R *.dfm}

end.
