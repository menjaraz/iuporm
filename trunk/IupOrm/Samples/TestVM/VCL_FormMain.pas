unit VCL_FormMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.Bind.Components, Data.Bind.ObjectScope,
  IupOrm.LiveBindings.PrototypeBindSource, IupOrm.Attributes;

type
  TMainForm = class(TForm)
    [ioAction('acHello')]
    ButtonHello: TButton;
    [ioAction('acOnOff')]
    ButtonOnOff: TButton;
    ioPrototypeBindSource1: TioPrototypeBindSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses VCL_RegisterClasses;

{$R *.dfm}

initialization

  TClassRegister.RegisterClasses;

end.
