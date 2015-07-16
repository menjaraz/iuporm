unit PA.V.ViewDataFatturaElettronicaBody;

interface

uses
  PA.V.ViewData, System.Classes, Vcl.Controls, Vcl.StdCtrls, Vcl.ComCtrls, Data.Bind.Components, Data.Bind.ObjectScope,
  IupOrm.LiveBindings.PrototypeBindSource, Vcl.Forms, PA.V.View, PA.V.ViewDataDatiGeneraliType;

type
  TpaViewDataFatturaElettronicaBody = class(TpaViewData)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    BSFatturaElettronicaBody: TioPrototypeBindSource;
    paViewDataDatiGenerali1: TpaViewDataDatiGenerali;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TpaViewDataFatturaElettronicaBody.Button1Click(Sender: TObject);
begin
  inherited;
  BSFatturaElettronicaBody.Post;
end;

end.
