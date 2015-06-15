unit PA.FormMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IupOrm.Attributes, Data.Bind.Components, Data.Bind.ObjectScope,
  IupOrm.LiveBindings.PrototypeBindSource, Vcl.Bind.GenData, Data.Bind.EngExt, Vcl.Bind.DBEngExt, System.Rtti,
  System.Bindings.Outputs, Vcl.Bind.Editors, PA.V.View, PA.V.ViewData, PA.V.Master,
  IupOrm.MVVM.Interfaces;

type
  TMainForm = class(TForm)
    paViewDataMaster1: TpaViewDataMaster;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses
  PA.VM.Interfaces;


{$R *.dfm}

end.
