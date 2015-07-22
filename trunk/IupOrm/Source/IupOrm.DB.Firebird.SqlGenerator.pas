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
    class procedure GenerateSqlForExists(const AQuery:IioQuery; const AContext:IioContext); override;
  end;

implementation

{ TioSqlGeneratorFirebird }

class procedure TioSqlGeneratorFirebird.GenerateSqlForExists(const AQuery: IioQuery; const AContext: IioContext);
begin
// No inherited
//  inherited;
  // Build the query text
  // -----------------------------------------------------------------
  AQuery.SQL.Add('SELECT CASE WHEN (EXISTS(SELECT * FROM ' + AContext.GetTable.GetSql
    + ' WHERE ' + AContext.GetProperties.GetIdProperty.GetSqlQualifiedFieldName + '=:'
    + AContext.GetProperties.GetIdProperty.GetSqlParamName
    + ')) THEN 1 ELSE 0 END FROM RDB$DATABASE');
  // -----------------------------------------------------------------
end;

class procedure TioSqlGeneratorFirebird.GenerateSqlNextID(const AQuery: IioQuery; const AContext: IioContext);
begin
// No inherited
//  inherited;
  // Build the query text
  // -----------------------------------------------------------------
  AQuery.SQL.Add('SELECT GEN_ID(' + AContext.GetTable.GetKeyGenerator + ',1) FROM RDB$DATABASE');
  // -----------------------------------------------------------------
end;

end.
