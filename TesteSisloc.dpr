program TesteSisloc;

uses
  Vcl.Forms,
  FrmExercios in 'FrmExercios.pas' {Frm_TesteSisloc},
  UntProduto in 'UntProduto.pas',
  UntTabelaBase in 'UntTabelaBase.pas',
  UntProdutoDesconto in 'UntProdutoDesconto.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrm_TesteSisloc, Frm_TesteSisloc);
  Application.Run;
end.
