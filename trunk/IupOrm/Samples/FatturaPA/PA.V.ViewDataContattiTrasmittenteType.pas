unit PA.V.ViewDataContattiTrasmittenteType;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, PA.V.ViewData, Vcl.StdCtrls, Vcl.Bind.GenData, System.Rtti, System.Bindings.Outputs,
  Vcl.Bind.Editors, Data.Bind.EngExt, Vcl.Bind.DBEngExt, Data.Bind.Components, Data.Bind.ObjectScope,
  IupOrm.LiveBindings.PrototypeBindSource;

type
  TpaViewDataContattiTrasmittenteType = class(TpaViewData)
    Label2: TLabel;
    eTelefono: TEdit;
    Label1: TLabel;
    eEmail: TEdit;
    BSContattiTrasmittenteType: TioPrototypeBindSource;
    BindingsList1: TBindingsList;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  paViewDataContattiTrasmittenteType: TpaViewDataContattiTrasmittenteType;

implementation

{$R *.dfm}

end.
