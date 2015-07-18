unit PA.V.ViewDataFatturaElettronicaHeaderType;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, PA.V.ViewData, Vcl.ComCtrls, PA.V.View, PA.V.ViewDataCedentePrestatoreType,
  Data.Bind.Components, Data.Bind.ObjectScope, IupOrm.LiveBindings.PrototypeBindSource, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TpaViewDataFatturaElettronicaHeaderType = class(TpaViewData)
    BSFatturaElettronicaHeaderType: TioPrototypeBindSource;
    PageControl1: TPageControl;
    TabSheet2: TTabSheet;
    TabSheet1: TTabSheet;
    paViewDataCedentePrestatoreType1: TpaViewDataCedentePrestatoreType;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  paViewDataFatturaElettronicaHeaderType: TpaViewDataFatturaElettronicaHeaderType;

implementation

{$R *.dfm}

end.
