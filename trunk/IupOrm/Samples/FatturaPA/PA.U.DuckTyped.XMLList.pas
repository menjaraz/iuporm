unit PA.U.DuckTyped.XMLList;

interface

uses
  PA.U.DuckTyped.Interfaces, System.Rtti;

type

  TDuckTypedXMLList = class(TInterfacedObject, IDuckTypedXMLList)
  private
    FObj: TObject;
    FAddMethod: TRttiMethod;
    FGet_ItemMethod: TRttiMethod;
    FDeleteMethod: TRttiMethod;
    FCountProperty: TRttiProperty;
    function GetCount: Integer;
  public
    constructor Create(AIntf: IInterface);
    function Add: IInterface;
    function Get_Item(Index: Integer): IInterface;
    procedure Delete(Index: Integer);
    property Count: Integer read GetCount;
  end;

implementation

uses IupOrm, System.SysUtils, Vcl.Dialogs;

{ TDuckTypedXMLList<T> }

function TDuckTypedXMLList.Add: IInterface;
begin
  Result := FAddMethod.Invoke(FObj, []).AsInterface;
end;

constructor TDuckTypedXMLList.Create(AIntf: IInterface);
var
  Ctx: TRttiContext;
  Typ: TRttiType;
begin
  inherited Create;
  FObj := AIntf as TObject;
  // Init Rtti
  Ctx := TIupOrm.GlobalFactory.RttiFactory.RttiContext;
  Typ := Ctx.GetType(FObj.ClassInfo);
  // Add Method
  FAddMethod := Typ.GetMethod('Add');
  if not Assigned(FAddMethod) then Exception.Create(Self.ClassName + ': "Add" method not found.');
  // Get_Item Method
  FGet_ItemMethod := Typ.GetMethod('Get_Item');
  if not Assigned(FGet_ItemMethod) then Exception.Create(Self.ClassName + ': "Get_Item" method not found.');
  // Delete Method
  FDeleteMethod := Typ.GetMethod('Delete');
  if not Assigned(FDeleteMethod) then Exception.Create(Self.ClassName + ': "Delete" method not found.');
  // GetCount Method
  FCountProperty := Typ.GetProperty('Count');
  if not Assigned(FCountProperty) then Exception.Create(Self.ClassName + ': "Count" property not found.');
end;

procedure TDuckTypedXMLList.Delete(Index: Integer);
begin
  FDeleteMethod.Invoke(FObj, [Index]);
end;

function TDuckTypedXMLList.GetCount: Integer;
begin
  Result := FCountProperty.GetValue(FObj).AsInteger;
end;

function TDuckTypedXMLList.Get_Item(Index: Integer): IInterface;
begin
  Result := FGet_ItemMethod.Invoke(FObj, [Index]).AsInterface;
end;

end.
