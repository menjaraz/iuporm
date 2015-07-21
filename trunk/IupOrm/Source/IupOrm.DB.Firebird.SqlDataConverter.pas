unit IupOrm.DB.Firebird.SqlDataConverter;

interface

uses
  IupOrm.DB.Interfaces, IupOrm.Context.Properties.Interfaces, System.Rtti,
  IupOrm.DB.SqLite.SqlDataConverter;

type

  // Classe che si occupa di convertire i dati per la compilazione
  //  dell'SQL
  TioSqlDataConverterFirebird = class(TioSqlDataConverterSqLite)  // (TioSqlDataConverter)
  strict protected
  public
    class function TValueToSql(const AValue:TValue): String; override;
  end;

implementation

uses
  System.TypInfo, System.SysUtils;

{ TioSqlConverterSqLite }

class function TioSqlDataConverterFirebird.TValueToSql(const AValue: TValue): String;
begin
  // Usa il risultato della classe antenata e ne modifica il risultato solo in
  //  caso di DateTime
  Result := inherited TValueToSql(AValue);
  // If the value is of type TDateTime...
  if (AValue.TypeInfo.Kind = tkFloat) and (AValue.TypeInfo = System.TypeInfo(TDateTime)) then
    Result := FormatDateTime('mm/dd/yyyy hh:nn:ss', AValue.AsExtended);
end;

end.
