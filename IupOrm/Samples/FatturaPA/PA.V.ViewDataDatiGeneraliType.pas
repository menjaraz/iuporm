unit PA.V.ViewDataDatiGeneraliType;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, PA.V.ViewData, Vcl.ComCtrls, Data.Bind.Components, Data.Bind.ObjectScope,
  IupOrm.LiveBindings.PrototypeBindSource, PA.V.View, PA.V.ViewDataDatiGeneraliDocumentoType;

type
  TpaViewDataDatiGenerali = class(TpaViewData)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    TabSheet8: TTabSheet;
    TabSheet9: TTabSheet;
    TabSheet10: TTabSheet;
    BSDatiGenerali: TioPrototypeBindSource;
    paViewDataDatiGeneraliDocumento1: TpaViewDataDatiGeneraliDocumento;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  paViewDataDatiGenerali: TpaViewDataDatiGenerali;

implementation

{$R *.dfm}

end.
