unit FrmExercios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.VCLUI.Wait, FireDAC.Comp.UI,
  FireDAC.Phys.ODBCBase, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFrm_TesteSisloc = class(TForm)
    Btn_Exercicio1: TButton;
    Con_Principal: TFDConnection;
    Qry_Exec: TFDQuery;
    fdphysmsqldrvrlnk1: TFDPhysMSSQLDriverLink;
    fdgxwtcrsr1: TFDGUIxWaitCursor;
    Btn_QuestaoD: TButton;
    Btn_QuestaoE: TButton;
    procedure Btn_Exercicio1Click(Sender: TObject);
    procedure Btn_QuestaoDClick(Sender: TObject);
    procedure Btn_QuestaoEClick(Sender: TObject);
  private
    { Private declarations }
    function CalcularValorVendaDVDs(const qtdDVD: Integer): Double;
    function InserirProblemaExercio1: Integer;
  public
    { Public declarations }
  end;

var
  Frm_TesteSisloc: TFrm_TesteSisloc;

implementation

uses
  UntProduto, UntProdutoDesconto;

{$R *.dfm}

procedure TFrm_TesteSisloc.Btn_Exercicio1Click(Sender: TObject);
var
  qtdDVD: Integer;
  continue: Boolean;
begin
  continue := False;
  while not continue do
  begin
    continue := TryStrToInt(InputBox('Quantidade de DVDs', 'Quantos DVDs deseja comprar?', '0'), qtdDVD);
    if not continue or (qtdDVD < 0) then
    begin
      ShowMessage('Digite um positivo numero valido!');
      continue := False;
    end
    else
      continue := True;
  end;

  ShowMessage('Valor da Venda R$: ' + FloatToStr(CalcularValorVendaDVDs(qtdDVD)));
end;

procedure TFrm_TesteSisloc.Btn_QuestaoDClick(Sender: TObject);
var
  codigo: Integer;
begin
  codigo := InserirProblemaExercio1;
  if (codigo > 0) then
    ShowMessage('Dvd inserido com sucesso com o codigo: ' + IntToStr(codigo));
end;

procedure TFrm_TesteSisloc.Btn_QuestaoEClick(Sender: TObject);
var
  qtd, codigo: Integer;
  continue: Boolean;
  produto: TProduto;
begin
  continue := False;
  while not continue do
  begin
    continue := TryStrToInt(InputBox('Codigo Produto', 'Qual o codigo do produto que deseja comprar?', '0'), codigo);

    if not continue or (codigo < 0) then
    begin
      ShowMessage('Digite um positivo numero valido!');
      continue := False;
    end
    else
      continue := True;
  end;
  continue := False;
  while not continue do
  begin
    continue := TryStrToInt(InputBox('Quantidade do produto', 'Quantos deseja comprar?', '0'), qtd);

    if not continue or (qtd < 0) then
    begin
      ShowMessage('Digite um positivo numero valido!');
      continue := False;
    end
    else
      continue := True;
  end;
  produto := TProduto.Create(Qry_Exec);
  try
    ShowMessage('Valor da Venda R$: ' +
      FloatToStr(produto.CalcularValorVenda(codigo, qtd)));
  finally
    FreeAndNil(produto);
  end;
end;

function TFrm_TesteSisloc.InserirProblemaExercio1: Integer;
var
  produto: TProduto;
  produtoDesconto: TProdutoDesconto;
begin
  produto := TProduto.Create(Qry_Exec);
  produtoDesconto := TProdutoDesconto.Create(Qry_Exec);
  try
    Result := produto.Inserir('DVD', 1.1);
    produtoDesconto.Inserir(Result, 10, 1);
    produtoDesconto.Inserir(Result, 20, 0.9);
  finally
    FreeAndNil(produto);
    FreeAndNil(produtoDesconto);
  end;
end;

function TFrm_TesteSisloc.CalcularValorVendaDVDs(const qtdDVD: Integer): Double;
const
  vlrUnidDVD = 1.10;
  vlr10UnidDVD = 1.00;
  vlr20UnidDVD = 0.90;
var
  i: Integer;
begin
  Result := 0;

  for i := 1 to qtdDVD do
  begin
    if (i > 10) and (i < 21) then
      Result := Result + vlr10UnidDVD
    else if (i > 20) then
      Result := Result + vlr20UnidDVD
    else
      Result := Result + vlrUnidDVD;
  end;
end;

end.
