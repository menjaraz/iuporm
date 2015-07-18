unit PA.V.ViewDataCedentePrestatoreType;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, PA.V.ViewData, PA.V.View, PA.V.ViewDataDatiAnagraficiCedenteType, Data.Bind.Components,
  Data.Bind.ObjectScope, IupOrm.LiveBindings.PrototypeBindSource, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Bind.GenData, System.Rtti,
  System.Bindings.Outputs, Vcl.Bind.Editors, Data.Bind.EngExt, Vcl.Bind.DBEngExt;

type
  TpaViewDataCedentePrestatoreType = class(TpaViewData)
    paViewDataDataAnagraficiCedenteType1: TpaViewDataDataAnagraficiCedenteType;
    BSCedentePrestatoreType: TioPrototypeBindSource;
    Label1: TLabel;
    eRiferimentoAmministrazione: TEdit;
    BindingsList1: TBindingsList;
    LinkControlToField1: TLinkControlToField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  paViewDataCedentePrestatoreType: TpaViewDataCedentePrestatoreType;

implementation

{$R *.dfm}

end.
