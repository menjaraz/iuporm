unit PA.V.ViewContainerTabFatturaElettronicaBody;

interface

uses
  PA.V.ViewContainerTab, IupOrm.LiveBindings.PrototypeBindSource, Data.Bind.Components, Data.Bind.ObjectScope, Vcl.StdCtrls,
  Vcl.Controls, Vcl.ExtCtrls, System.Classes, Vcl.ComCtrls;


type
  TpaViewContainerTabFatturaElettronicaBody = class(TpaViewContainerTab)
    BSFatturaElettronicaBodyList: TioPrototypeBindSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
