unit PA.V.ViewDataFatturaElettronicaType;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, PA.V.ViewData, Vcl.ComCtrls, PA.V.View, PA.V.ViewDataFatturaElettronicaHeaderType,
  Data.Bind.Components, Data.Bind.ObjectScope, IupOrm.LiveBindings.PrototypeBindSource, Vcl.Bind.GenData, Vcl.StdCtrls, System.Rtti,
  System.Bindings.Outputs, Vcl.Bind.Editors, Data.Bind.EngExt, Vcl.Bind.DBEngExt, PA.V.ViewContainer, PA.V.ViewContainerTab,
  PA.V.ViewContainerTabFatturaElettronicaBody;

type
  TpaViewDataFatturaElettronicaType = class(TpaViewData)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    paViewDataFatturaElettronicaHeaderType1: TpaViewDataFatturaElettronicaHeaderType;
    BSFatturaElettronica: TioPrototypeBindSource;
    paViewContainerTabFatturaElettronicaBody1: TpaViewContainerTabFatturaElettronicaBody;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  paViewDataFatturaElettronicaType: TpaViewDataFatturaElettronicaType;

implementation

{$R *.dfm}

end.
