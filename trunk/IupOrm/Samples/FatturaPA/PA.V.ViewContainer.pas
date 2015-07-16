unit PA.V.ViewContainer;

interface

uses
  PA.V.ViewData, PA.V.Interfaces, Vcl.ExtCtrls, Vcl.StdCtrls, System.Classes, Vcl.Controls,
  IupOrm.Attributes;

type
  TpaViewContainer = class(TpaViewData, IpaViewContainer)
    Panel1: TPanel;
    [ioAction('acAdd')]
    ButtonAdd: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
