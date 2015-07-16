unit PA.VM.ViewModelBase;

interface

uses
  System.SysUtils, System.Classes, IupOrm.MVVM.ALL.ViewModel, System.Actions, Vcl.ActnList,
  PA.VM.Interfaces;

type
  TpaViewModelBase= class(TioViewModel, IpaViewModel)
    acDelete: TAction;
    procedure acDeleteExecute(Sender: TObject);
  private
    { Private declarations }
    FContainedIndex: Integer;
    FFunctionResizeView: TFunctionResizeView;
    function GetContainedIndex: Integer;
    procedure SetContainedIndex(const Value: Integer);
  public
    { Public declarations }
    constructor Create; overload;
    // Methods
    procedure SetFunctionResizeView(AFunctionResizeView: TFunctionResizeView);
    procedure ChildViewResized;
    procedure ViewResized;
    // Properties
    property ContainedIndex: Integer read GetContainedIndex write SetContainedIndex;
  end;


implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TpaViewModelBase.acDeleteExecute(Sender: TObject);
var
  MasterContainerViewModel: IpaViewModelForViewContainer;
begin
  inherited;
  if not Supports(Self.GetMasterViewModel, IpaViewModelForViewContainer, MasterContainerViewModel) then
    Exit;
  MasterContainerViewModel.Delete(FContainedIndex);
end;

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

constructor TpaViewModelBase.Create;
begin
  inherited;
  FContainedIndex := -1;
end;

function TpaViewModelBase.GetContainedIndex: Integer;
begin
  Result := FContainedIndex;
end;

procedure TpaViewModelBase.SetContainedIndex(const Value: Integer);
begin
  FContainedIndex := Value;
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
