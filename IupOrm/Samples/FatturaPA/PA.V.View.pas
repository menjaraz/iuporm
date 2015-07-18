unit PA.V.View;

interface

uses
  Vcl.Forms, PA.V.Interfaces, IupOrm.LiveBindings.PrototypeBindSource,
  IupOrm.MVVM.Interfaces, PA.VM.Interfaces, Winapi.Windows, Vcl.Controls,
  System.Classes, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TpaView = class(TFrame, IpaView)
    LeftSidePanel: TPanel;
    CheckBoxViewSelection: TCheckBox;
    WorkSpace: TScrollBox;
    procedure LeftSidePanelResize(Sender: TObject);
  private
    { Private declarations }
    function GetHeight: Integer;
    // Set the OnNeddViewModel of the TioPrototypeBindSource of the view
    procedure SetBSOnNeedViewModelEventHandler;
    // Event handler for all TioPrototypeBindSources
    procedure BSOnNeedViewModel(Sender: TioPrototypeBindSource; var AViewModel: IioViewModel);
    // LeftSidePanelVisible property
    function GetSelectedVisible: Boolean;
    procedure SetSelectedVisible(const Value: Boolean);
    // Selected property
    function GetSelected: Boolean;
    procedure SetSelected(const Value: Boolean);
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
    // LeftSidePanelVisible property
    property SelectedVisible:Boolean read GetSelectedVisible write SetSelectedVisible;
    // Selected property
    property Selected:Boolean read GetSelected write SetSelected;
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
  // LeftSidePanel not visible by default
  SelectedVisible := False;
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

function TpaView.GetSelectedVisible: Boolean;
begin
  Result := LeftSidePanel.Visible;
end;

function TpaView.GetParent: TWinControl;
begin
  Result := inherited Parent;
end;

function TpaView.GetSelected: Boolean;
begin
  Result := CheckBoxViewSelection.Checked;
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

procedure TpaView.SetSelectedVisible(const Value: Boolean);
begin
  LeftSidePanel.Visible := Value;
end;

procedure TpaView.SetSelected(const Value: Boolean);
begin
  CheckBoxViewSelection.Checked := Value;
end;

procedure TpaView.LeftSidePanelResize(Sender: TObject);
begin
  CheckBoxViewSelection.Top := ((Sender as TPanel).Height - CheckBoxViewSelection.Height) div 2;
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
