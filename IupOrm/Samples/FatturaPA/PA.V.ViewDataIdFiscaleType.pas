unit PA.V.ViewDataIdFiscaleType;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, PA.V.ViewData, Vcl.Bind.GenData, Data.Bind.Components, Data.Bind.ObjectScope,
  IupOrm.LiveBindings.PrototypeBindSource, Vcl.StdCtrls, Vcl.ComCtrls, System.Rtti, System.Bindings.Outputs, Vcl.Bind.Editors,
  Data.Bind.EngExt, Vcl.Bind.DBEngExt, Vcl.ExtCtrls;

type
  TpaViewDataIdFiscaleType = class(TpaViewData)
    BSIdFiscaleType: TioPrototypeBindSource;
    Label1: TLabel;
    eIdPaese: TEdit;
    Label2: TLabel;
    eIdCodice: TEdit;
    BindingsList1: TBindingsList;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
