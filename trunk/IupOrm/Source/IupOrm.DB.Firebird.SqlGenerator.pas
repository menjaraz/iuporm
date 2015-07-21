unit IupOrm.DB.Firebird.SqlGenerator;

interface

uses
  IupOrm.DB.SqLite.SqlGenerator, IupOrm.DB.Interfaces,
  IupOrm.Context.Interfaces;

type

  // Classe che si occupa di generare il codice SQL delle varie query
  TioSqlGeneratorFirebird = class(TioSqlGeneratorSqLite)
  public
    class procedure GenerateSqlNextID(const AQuery:IioQuery; const AContext:IioContext); override;
  end;

implementation

{ TioSqlGeneratorFirebird }

class procedure TioSqlGeneratorFirebird.GenerateSqlNextID(const AQuery: IioQuery; const AContext: IioContext);
begin
// No inherited
//  inherited;
  // Build the query text
  AQuery.SQL.Add('SELECT NEXT VALUE FOR :KeyGenerator');
end;

end.
