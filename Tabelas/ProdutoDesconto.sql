CREATE TABLE dbo.ProdutoDesconto
	(
	Codigo int NOT NULL,
	Quantidade int NOT NULL,
	Valor float(53) NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.ProdutoDesconto ADD CONSTRAINT
	PK_ProdutoDesconto PRIMARY KEY CLUSTERED 
	(
	Codigo,
	Quantidade
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.ProdutoDesconto ADD CONSTRAINT
	FK_ProdutoDesconto_Produto FOREIGN KEY
	(
	Codigo
	) REFERENCES dbo.Produto
	(
	Codigo
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.ProdutoDesconto SET (LOCK_ESCALATION = TABLE)
