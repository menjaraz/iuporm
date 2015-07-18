unit PA.V.ViewContainer;

interface

uses
  PA.V.ViewData, PA.V.Interfaces, Vcl.ExtCtrls, Vcl.StdCtrls, System.Classes, Vcl.Controls,
  IupOrm.Attributes, Vcl.Forms, Vcl.Buttons;

type
  TpaViewContainer = class(TpaViewData, IpaViewContainer)
    Panel1: TPanel;
    [ioAction('acAdd')]
    ButtonAdd: TSpeedButton;
    [ioAction('acDelete')]
    ButtonDelete: TSpeedButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
