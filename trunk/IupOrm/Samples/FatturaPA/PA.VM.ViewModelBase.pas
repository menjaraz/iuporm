unit PA.VM.ViewModelBase;

interface

uses
  System.SysUtils, System.Classes, IupOrm.MVVM.ALL.ViewModel, System.Actions, Vcl.ActnList,
  PA.VM.Interfaces;

type
  TpaViewModelBase= class(TioViewModel, IpaViewModel)
  private
    { Private declarations }
    FFunctionResizeView: TFunctionResizeView;
  public
    { Public declarations }
    // Methods
    procedure SetFunctionResizeView(AFunctionResizeView: TFunctionResizeView);
    procedure ChildViewResized;
    procedure ViewResized;
  end;


implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TpaViewModelBase.ChildViewResized;
begin
  // ---------------------------------------------------------------------------------------
  // This method is called when at least one child view has changed its size,
  //  the call is made using the ViewModel associated with ChildView that changed the size.
  // ---------------------------------------------------------------------------------------
  // Call the FFunctionResizeView anonimous method to update the view dimensions if needed.
  // If the dimensions of the linked view changes then notify to the parent/master ViewModel
  //  calling its ChildViewResized.
  if Assigned(FFunctionResizeView) and FFunctionResizeView then
    Self.ViewResized;
end;

procedure TpaViewModelBase.SetFunctionResizeView(AFunctionResizeView: TFunctionResizeView);
begin
  FFunctionResizeView := AFunctionResizeView;
end;

procedure TpaViewModelBase.ViewResized;
var
  AMasterViewModel: IpaViewModel;
begin
  // ---------------------------------------------------------------------------------------
  // This method is called when the linked view has changed its dimensions.
  // ---------------------------------------------------------------------------------------
  // If the dimensions of the linked view changes then notify to the parent/master ViewModel
  //  calling its ChildViewResized.
  AMasterViewModel := Self.GetMasterViewModel as IpaViewModel;
  if Assigned(AMasterViewModel) then
    AMasterViewModel.ChildViewResized;
end;

end.
