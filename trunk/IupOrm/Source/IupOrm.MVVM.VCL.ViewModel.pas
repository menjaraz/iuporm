unit IupOrm.MVVM.VCL.ViewModel;

interface

uses
  IupOrm.MVVM.ViewModelBase, System.Classes, System.Actions, Vcl.ActnList;

type
  TioViewModel = class(TioViewModelBase)
    Commands: TActionList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}


end.
