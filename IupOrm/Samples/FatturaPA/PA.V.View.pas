unit PA.V.View;

interface

uses
  Vcl.Forms, PA.V.Interfaces, IupOrm.LiveBindings.PrototypeBindSource,
  IupOrm.MVVM.Interfaces, PA.VM.Interfaces, Winapi.Windows, Vcl.Controls,
  System.Classes, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TpaView = class(TFrame, IpaView)
    SidePanel: TPanel;
    CheckBox1: TCheckBox;
  private
    { Private declarations }
    function GetHeight: Integer;
    // Set the OnNeddViewModel of the TioPrototypeBindSource of the view
    procedure SetBSOnNeedViewModelEventHandler;
    // Event handler for all TioPrototypeBindSources
    procedure BSOnNeedViewModel(Sender: TioPrototypeBindSource; var AViewModel: IioViewModel);
  protected
    // Get the TioPrototypeBindSource of the view
    function GetBindSource: TioPrototypeBindSource;
    // Get the ViewModel of the view
    function GetViewModel: IpaViewModel;
    // RecalcLayouts return True if the sizes of the view has changed else
    //  it return False;
    function RecalcLayout: Boolean; virtual;
    // Handle property getter
    function GetHandle: HWND;
    // Parent property
    function GetParent: TWinControl;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    // Parent property
    property Parent: TWinControl read GetParent write SetParent;
  end;

implementation

uses
  System.SysUtils;

{$R *.dfm}

{ TpaView }

constructor TpaView.Create(AOwner: TComponent);
begin
  inherited;
  // Set the Viewmodel anonimous method for size recalculation of the view itself.
  SetBSOnNeedViewModelEventHandler;
end;

function TpaView.GetBindSource: TioPrototypeBindSource;
var
  I: Integer;
begin
  Result := nil;
  // Loop for all owned components
  for I := 0 to Self.ComponentCount-1 do
  begin
    // If the current owned component is a TioPrototypeBindSource then get the ViewModel and set
    //  the OnNeedViewModel event handler
    if  Self.Components[I] is TioPrototypeBindSource then
    begin
      Result := Self.Components[I] as TioPrototypeBindSource;
      Break;
    end;
  end;
end;

function TpaView.GetHandle: HWND;
begin
  Result := inherited Handle;
end;

function TpaView.GetHeight: Integer;
begin
  Result := inherited Height;
end;

function TpaView.GetParent: TWinControl;
begin
  Result := inherited Parent;
end;

function TpaView.GetViewModel: IpaViewModel;
begin
  Result := nil;
  if Assigned(Self.GetBindSource.ioViewModel) then
    Result := Self.GetBindSource.ioViewModel as IpaViewModel;
end;

function TpaView.RecalcLayout: Boolean;
begin
  inherited;
  Result := False;
end;

procedure TpaView.SetBSOnNeedViewModelEventHandler;
begin
  if Self.GetBindSource <> nil then
    Self.GetBindSource.ioOnNeedViewModel := BSOnNeedViewModel;
end;

procedure TpaView.BSOnNeedViewModel(Sender: TioPrototypeBindSource; var AViewModel: IioViewModel);
var
  APAViewModel: IpaViewModel;
  APAViewModelForViewContainer: IpaViewModelForViewContainer;
begin
  inherited;
  // If supports IpaViewModel (All Views) then set the TFunctionResizeView anonimous method
  if Supports(AViewModel, IpaViewModel, APAViewModel) then
    APAViewModel.SetFunctionResizeView(
      function: Boolean
      begin
        Result := Self.RecalcLayout;
      end
    );
  // If supports IpaViewContainer then set the OnAfterOpen event handler of the BindSourceAdapter
  if Supports(AViewModel, IpaViewModelForViewContainer, APAViewModelForViewContainer) then
    APAViewModelForViewContainer.SetOnAfterOpenEventHandler;
end;

end.
