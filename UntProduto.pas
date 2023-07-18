unit UntProduto;

interface
uses
  UntTabelaBase, UntProdutoDesconto;

type
  TProduto = class(TTabelaBase)
    private
      FValor: Double;
      FNome: string;
      FProdutoDescontos: TProdutoDescontos;
    public
      property Nome: string  read FNome;
      property Valor: Double read FValor;
      property ProdutoDescontos: TProdutoDescontos read FProdutoDescontos;
      function Inserir(const aNome: string; const aValor: Double): Integer;
      function CalcularValorVenda(const aCodigo, aQuantidade: Integer): Double;
      procedure Carregar(const aCodigo: Integer; const aNome: string;
        const aValor: Double);
      destructor Destroy; override;  
  end;

implementation

uses
  System.SysUtils;

{ TProduto }

function TProduto.CalcularValorVenda(const aCodigo,
  aQuantidade: Integer): Double;
var
  produtoDesconto: TProdutoDesconto;
  i, x: Integer;
begin
  Result := 0;
  with FQry do
  begin
    Close;
    SQL.Text := 'select * from produto where codigo = :codigo';
    ParamByName('codigo').AsInteger := aCodigo;
    Open;
    First;
    Carregar(FieldByName('codigo').AsInteger, FieldByName('nome').AsString,
      FieldByName('valor').AsFloat);
    Close;
    SQL.Text := 'select * from produtodesconto where codigo = :codigo order by quantidade';
    ParamByName('codigo').AsInteger := aCodigo;
    Open;
    SetLength(FProdutoDescontos, RecordCount);
    First;
    while not Eof do
    begin
      FProdutoDescontos[RecNo - 1] := TProdutoDesconto.Create(FQry);
      FProdutoDescontos[RecNo - 1].Carregar(FieldByName('codigo').AsInteger,
        FieldByName('quantidade').AsInteger, FieldByName('valor').AsFloat);
      Next;
    end;
  end;

  for i := 1 to aQuantidade do
  begin
    if (Length(FProdutoDescontos) > 0) then
    begin
      if (i > FProdutoDescontos[0].Quantidade) then
      begin
        for x := Low(FProdutoDescontos) to High(FProdutoDescontos) do
        begin
          if (x + 1 <= High(FProdutoDescontos)) then
          begin
            if (i > FProdutoDescontos[x].Quantidade) and
              (i < FProdutoDescontos[x + 1].Quantidade + 1) then
              Result := Result + FProdutoDescontos[x].Valor;        
          end
          else
          begin
            if (i > FProdutoDescontos[x].Quantidade) then
              Result := Result + FProdutoDescontos[x].Valor;
          end;
        end;
      end
      else
        Result := Result + FValor;    
    end
    else
      Result := Result + FValor;    
  end;
end;

procedure TProduto.Carregar(const aCodigo: Integer; const aNome: string;
  const aValor: Double);
begin
  FCodigo := aCodigo;
  FNome := aNome;
  FValor := aValor;
end;

destructor TProduto.Destroy;
var
  i: Integer;
begin
  for i := Low(FProdutoDescontos) to High(FProdutoDescontos) do
    FreeAndNil(FProdutoDescontos[i]);
    
  inherited;
end;

function TProduto.Inserir(const aNome: string; const aValor: Double): Integer;
begin
  with FQry do
  begin
    Close;
    Open('select max(1) from produto');
    if (Fields[0].IsNull) then
      Result := 1
    else
      Result := Fields[0].AsInteger + 1;
    Close;
    SQL.Text := 'insert into produto select :codigo, :nome, :valor';
    ParamByName('codigo').AsInteger := Result;
    ParamByName('nome').AsString := aNome;
    ParamByName('valor').AsFloat := aValor;
    Execute;
  end;
end;

end.
