unit PA.V.ViewData;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, PA.V.View, PA.V.Interfaces;

type
  TpaViewData = class(TpaView, IpaViewData)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  paViewData: TpaViewData;

implementation

{$R *.dfm}

end.
