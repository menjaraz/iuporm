unit Model.CostType;

interface

uses
  Model.BaseConst, Model.BaseInterfaces, Model.BaseClasses, IupOrm.Attributes;

const
  GroupHeaders: array[0..2] of string = ('Totale', 'Varie', 'Carburante');

type
  // Classe che rappresente i tipi di spesa possibili
  [ioTable('COSTTYPES')]
  TCostType = class(TBaseClass, ICostType)
  strict private
    {$REGION 'ICostType'}
    FObjectType: Byte;
    {$ENDREGION}
  strict protected
    {$REGION 'ICostType'}
    function GetObjectType: Byte;
    procedure SetObjectType(Value: Byte);
    function GetListViewItem_GroupHeader: String; override;
    {$ENDREGION}
  public
    constructor Create(AID:Integer; ADescrizione:String; AObjectType:Byte); overload;
    {$REGION 'ICostType'}
    property ObjectType: Byte read GetObjectType write SetObjectType;
    {$ENDREGION}
  end;

implementation

{ TCostType }


constructor TCostType.Create(AID: Integer; ADescrizione: String;
  AObjectType: Byte);
begin
  inherited Create(AID, ADescrizione);
  ObjectType := AObjectType;
end;


{$REGION 'ICostType'}
// -----------------------------------------------------------------------------
function TCostType.GetListViewItem_GroupHeader: String;
begin
  inherited;
  Result := GroupHeaders[Self.ObjectType];
end;

function TCostType.GetObjectType: Byte;
begin
  Result := FObjectType;
end;

procedure TCostType.SetObjectType(Value: Byte);
begin
  if Value <> FObjectType then
  begin
    FObjectType := Value;
  end;
end;
// -----------------------------------------------------------------------------
{$ENDREGION}

end.
