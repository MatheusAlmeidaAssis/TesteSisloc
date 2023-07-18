unit UntTabelaBase;

interface

uses
  Data.DB, FireDAC.Comp.Client;

type
  TTabelaBase = class abstract
  protected
    FQry: TFDQuery;
    FCodigo: Integer;
  public
    property Codigo: Integer read FCodigo;
    constructor Create(qry: TFDQuery);
  end;

implementation

{ TTabelaBase }

constructor TTabelaBase.Create(qry: TFDQuery);
begin
  FQry := qry;
end;

end.
