unit PA.V.ViewDataDatiAnagraficiCedenteType;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, PA.V.ViewData, Data.Bind.Components, Data.Bind.ObjectScope,
  IupOrm.LiveBindings.PrototypeBindSource, Vcl.Bind.GenData, Data.Bind.GenData, PA.V.ViewDataAnagraficaType, PA.V.View,
  PA.V.ViewDataIdFiscaleType, Vcl.StdCtrls, System.Rtti, System.Bindings.Outputs, Vcl.Bind.Editors, Data.Bind.EngExt,
  Vcl.Bind.DBEngExt, Vcl.ExtCtrls;

type
  TpaViewDataDataAnagraficiCedenteType = class(TpaViewData)
    BSDatiAnagraficiCedenteType: TioPrototypeBindSource;
    paViewDataIdFiscaleType1: TpaViewDataIdFiscaleType;
    paViewDataAnagraficaType1: TpaViewDataAnagraficaType;
    BindingsList1: TBindingsList;
    Label2: TLabel;
    eCodiceFiscale: TEdit;
    Label6: TLabel;
    eRegimeFiscale: TEdit;
    Label1: TLabel;
    eAlboProfessionale: TEdit;
    Label5: TLabel;
    eProvinciaAlbo: TEdit;
    Label3: TLabel;
    eNumIscrizAlbo: TEdit;
    Label4: TLabel;
    eDataIscrizAlbo: TEdit;
    LinkControlToField7: TLinkControlToField;
    LinkControlToField8: TLinkControlToField;
    LinkControlToField9: TLinkControlToField;
    LinkControlToField10: TLinkControlToField;
    LinkControlToField11: TLinkControlToField;
    LinkControlToField12: TLinkControlToField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  paViewDataDataAnagraficiCedenteType: TpaViewDataDataAnagraficiCedenteType;

implementation

{$R *.dfm}

end.
