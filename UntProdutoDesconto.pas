unit UntProdutoDesconto;

interface
uses
  UntTabelaBase;

type
  TProdutoDesconto = class(TTabelaBase)
    private
    FValor: Double;
    FQuantidade: Integer;
    public
      property Quantidade: Integer read FQuantidade;
      property Valor: Double read FValor;
      function Inserir(const aCodigo, aQuantidade: Integer; const aValor: Double): Boolean;
      procedure Carregar(const aCodigo, aQuantidade: Integer; const aValor: Double);
  end;
  TProdutoDescontos = array of TProdutoDesconto;
implementation

uses
  System.SysUtils;

{ TProdutoDesconto }

procedure TProdutoDesconto.Carregar(const aCodigo, aQuantidade: Integer;
  const aValor: Double);
begin
  FCodigo := aCodigo;
  FQuantidade := aQuantidade;
  FValor := aValor;
end;

function TProdutoDesconto.Inserir(const aCodigo, aQuantidade: Integer;
  const aValor: Double): Boolean;
begin
  Result := True;
  try
    with FQry do
    begin
      Close;
      SQL.Text := 'insert into produtodesconto select :codigo, :quantidade, :valor';
      ParamByName('codigo').AsInteger := aCodigo;
      ParamByName('quantidade').AsInteger := aQuantidade;
      ParamByName('valor').AsFloat := aValor;
      Execute;
    end;
  except
    on E: Exception do
    begin
      Result := False;
    end;
  end;
end;

end.
