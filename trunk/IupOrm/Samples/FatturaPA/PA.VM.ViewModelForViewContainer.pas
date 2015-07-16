unit PA.VM.ViewModelForViewContainer;

interface

uses
  System.SysUtils, System.Classes, PA.VM.ViewModelBase, System.Actions, Vcl.ActnList,
  PA.U.DuckTyped.Interfaces, PA.V.Interfaces, IupOrm.Containers.Interfaces,
  PA.VM.Interfaces, Data.Bind.ObjectScope;

type
  TpaViewModelForViewContainer = class(TpaViewModelBase, IpaViewModelForViewContainer)
    acAdd: TAction;
    procedure acAddExecute(Sender: TObject);
  private
    { Private declarations }
    FChildView_Interface, FChildView_Alias: String;
    FChildVM_Interface, FChildVM_Alias: String;
    FChildViews: IioList<IpaView>;
    function Current: IInterface;
    function _CurrentDuck: IDuckTypedXMLList;
    function _Add: IInterface;
    function _GetItem(const Index: Integer): IInterface;
    procedure _Delete(const Index: Integer);
    function _GetCount: Integer;
    property _Count: Integer read _GetCount;
    procedure CheckChildViewsContainer;
    procedure ClearAllChildViews;
    procedure CreateAllChildViews;
    procedure CreateChildView(const ADataObject:IInterface; const AContainedIndex:Integer);
    // OnAfterOpen event handler for the BindSourceAdapter
    procedure OnAfterOpenEventHandler(Adapter: TBindSourceAdapter);
    // Property ChildView_Interface
    procedure SetChildView_Interface(AValue: String);
    function GetChildView_Interface: String;
    // Property ChildView_Alias
    procedure SetChildView_Alias(AValue: String);
    function GetChildView_Alias: String;
    // Property ChildVM_Interface
    procedure SetChildVM_Interface(AValue: String);
    function GetChildVM_Interface: String;
    // Property ChildVM_Alias
    procedure SetChildVM_Alias(AValue: String);
    function GetChildVM_Alias: String;
  public
    { Public declarations }
    function ChildViews: IioList<IpaView>;
    procedure Delete(const Index: Integer);
    procedure SetOnAfterOpenEventHandler;
    // Property ChildView_Interface
    property ChildView_Interface:String read GetChildView_Interface write SetChildView_Interface;
    // Property ChildView_Alias
    property ChildView_Alias:String read GetChildView_Alias write SetChildView_Alias;
    // Property ChildVM_Interface
    property ChildVM_Interface:String read GetChildVM_Interface write SetChildVM_Interface;
    // Property ChildVM_Alias
    property ChildVM_Alias:String read GetChildVM_Alias write SetChildVM_Alias;
  end;

implementation

uses
  IupOrm, System.Rtti, IupOrm.MVVM.Interfaces;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TpaViewModelForContainerListView }

procedure TpaViewModelForViewContainer.acAddExecute(Sender: TObject);
var
  ADataObj: IInterface;
begin
  inherited;
  // Create the new data object
  ADataObj := Self._Add;
  // Create a new View+VieModel for the new data object
  Self.CreateChildView(ADataObj, Self._Count-1);
  // Recalc the View layout because changes occours
  Self.ChildViewResized;
end;

function TpaViewModelForViewContainer._Add: IInterface;
begin
  Result := Self._CurrentDuck.Add;
end;

procedure TpaViewModelForViewContainer.CheckChildViewsContainer;
begin
  if not Assigned(FChildViews) then
    FChildViews := TIupOrm.DependencyInjection.Locate<IioList<IpaView>>.Get;
end;

function TpaViewModelForViewContainer.ChildViews: IioList<IpaView>;
begin
  Result := FChildViews;
end;

procedure TpaViewModelForViewContainer.ClearAllChildViews;
begin
  // First check the ChildViews container, if it isn't assigned then create it
  Self.CheckChildViewsContainer;
  FChildViews.Clear;
end;

procedure TpaViewModelForViewContainer.CreateAllChildViews;
var
  I: Integer;
  ACurrent: IInterface;
begin
  // Clear all previous views
  Self.ClearAllChildViews;
  // Loop for child objects
  for I := 0 to Self._Count -1 do
  begin
    // Get the current child object as IInterface
    ACurrent := Self._GetItem(I);
    // Create the View+ViewModel
    Self.CreateChildView(ACurrent, I);
  end;
end;

procedure TpaViewModelForViewContainer.CreateChildView(const ADataObject:IInterface; const AContainedIndex:Integer);
var
  AViewObj: TObject;
  AView: IpaView;
  AViewModel: IpaViewModel;
begin
  // First check the ChildViews container, if it isn't assigned then create it
  Self.CheckChildViewsContainer;
  // New level for singleton lifetime manager
  TIupOrm.DependencyInjection.Singletons.NextLevel;
  try
    // Get the child ViewModel and set the ContainedIndex
    AViewModel := TIupOrm.DependencyInjection
                         .Locate(FChildVM_Interface, FChildVM_Alias)
                         .ConstructorMarker('CreateByDataInterface')
                         .ConstructorParams([TValue.From<IInterface>(ADataObject), TValue.From<TioViewDataType>(dtSingle)])
                         .Get
                         .ioAsInterface<IpaViewModel>;
    AViewModel.ContainedIndex := AContainedIndex;
    // Get the child View
    AView := TIupOrm.DependencyInjection
                    .Locate(FChildView_Interface, FChildView_Alias)
                    .ViewModel(AViewModel, 'BSFatturaElettronicaBody')
                    .ConstructorParams([nil])  // Owner
                    .Get
                    .ioAsInterface<IpaView>;
    // Add the new View+ViewModel to the ChildViews list
    FChildViews.Add(AView);
  finally
    // Release the new level for singleton lifetime manager
    TIupOrm.DependencyInjection.Singletons.ReleaseLevel;
  end;
end;

function TpaViewModelForViewContainer.Current: IInterface;
begin
  if not Supports(Self.ViewData.DataObj, IInterface, Result) then
    raise Exception.Create(Self.ClassName + ': IInterface not implemented.');
end;

procedure TpaViewModelForViewContainer.Delete(const Index: Integer);
begin
  // Delete the data object
  Self._Delete(Index);
  // Recreate the View+ViewModel list
  Self.CreateAllChildViews;
  // Recalc the View layout because changes occours
  Self.ChildViewResized;
end;

function TpaViewModelForViewContainer.GetChildView_Alias: String;
begin
  Result := FChildView_Alias;
end;

function TpaViewModelForViewContainer.GetChildView_Interface: String;
begin
  Result := FChildView_Interface;
end;

function TpaViewModelForViewContainer.GetChildVM_Alias: String;
begin
  Result := FChildVM_Alias;
end;

function TpaViewModelForViewContainer.GetChildVM_Interface: String;
begin
  Result := FChildVM_Interface;
end;

procedure TpaViewModelForViewContainer.OnAfterOpenEventHandler(Adapter: TBindSourceAdapter);
begin
  inherited;
  // Create the View+ViewModel list
  Self.CreateAllChildViews;
  // Recalc the View layout because changes occours
  Self.ChildViewResized;
end;

procedure TpaViewModelForViewContainer.SetChildView_Alias(AValue: String);
begin
  FChildView_Alias := AValue;
end;

procedure TpaViewModelForViewContainer.SetChildView_Interface(AValue: String);
begin
  FChildView_Interface := AValue;
end;

procedure TpaViewModelForViewContainer.SetChildVM_Alias(AValue: String);
begin
  FChildVM_Alias := AValue;
end;

procedure TpaViewModelForViewContainer.SetChildVM_Interface(AValue: String);
begin
  FChildVM_Interface := AValue;
end;

procedure TpaViewModelForViewContainer.SetOnAfterOpenEventHandler;
begin
  Self.ViewData.BindSourceAdapter.AfterOpen := OnAfterOpenEventHandler
end;

function TpaViewModelForViewContainer._CurrentDuck: IDuckTypedXMLList;
var
  ACurrent: IInterface;
begin
  // Get current
  ACurrent := Self.Current;
  // Get DuckTyped wrapped current
  Result := TIupOrm.DependencyInjection.Locate<IDuckTypedXMLList>.ConstructorParams([TValue.From<IInterface>(ACurrent)]).Get;
end;

procedure TpaViewModelForViewContainer._Delete(const Index: Integer);
begin
  Self._CurrentDuck.Delete(Index);
end;

function TpaViewModelForViewContainer._GetCount: Integer;
begin
  Result := Self._CurrentDuck.Count;
end;

function TpaViewModelForViewContainer._GetItem(const Index: Integer): IInterface;
begin
  Result := Self._CurrentDuck.Get_Item(Index);
end;

end.


