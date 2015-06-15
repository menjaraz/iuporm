unit PA.V.ViewDataProva;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, PA.V.ViewData, PA.V.View, PA.V.ViewDataContattiTrasmittenteType, PA.V.ViewDataIdFiscaleType;

type
  TpaViewDataProva = class(TpaViewData)
    paViewDataContattiTrasmittenteType1: TpaViewDataContattiTrasmittenteType;
    paViewDataContattiTrasmittenteType2: TpaViewDataContattiTrasmittenteType;
    paViewDataIdFiscaleType1: TpaViewDataIdFiscaleType;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  paViewDataProva: TpaViewDataProva;

implementation

{$R *.dfm}

end.
