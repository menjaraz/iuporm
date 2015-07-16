unit PA.V.ViewContainerTab;

interface

uses
  PA.V.ViewContainer, Vcl.ComCtrls, Vcl.StdCtrls, System.Classes, Vcl.Controls, Vcl.ExtCtrls;


type
  TpaViewContainerTab = class(TpaViewContainer)
    ChildsArea: TPageControl;
  private
    { Private declarations }
  protected
    // RecalcLayouts return True if the sizes of the view has changed else
    //  it return False;
    function RecalcLayout: Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses
  PA.VM.Interfaces, PA.V.Interfaces, PA.V.ViewDataFatturaElettronicaBody, System.SysUtils,
  Unit1;

{$R *.dfm}

{ TpaViewContainerTab }
function TpaViewContainerTab.RecalcLayout: Boolean;
var
  AView: IpaView;
  AViewModel: IpaViewModelForViewContainer;
  ATab: TTabSheet;
begin
  inherited;
  // Get the ViewModel
  AViewModel := Self.GetViewModel as IpaViewModelForViewContainer;
  // Reset ChildViews parent
  for AView in AViewModel.ChildViews do
    AView.Parent := nil;
  // Frees all TabSheets
  while ChildsArea.PageCount > 0 do
    ChildsArea.Pages[ChildsArea.PageCount-1].Free;
  // Loop for all child views
  for AView in AViewModel.ChildViews do begin
    // Create the TabSheet
    ATab := TTabSheet.Create(ChildsArea);
    ATab.PageControl := ChildsArea;
    ATab.Caption := (ATab.TabIndex + 1).ToString;
    // Set the TabSheet as Parent of the current ChildView
    AView.Parent := ATab;
  end;
end;

end.
