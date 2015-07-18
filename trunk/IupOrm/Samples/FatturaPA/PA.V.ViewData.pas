unit PA.V.ViewData;

interface

uses
  PA.V.View, PA.V.Interfaces, Vcl.Forms, Vcl.StdCtrls, System.Classes, Vcl.Controls, Vcl.ExtCtrls;

type
  TpaViewData = class(TpaView, IpaViewData)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
