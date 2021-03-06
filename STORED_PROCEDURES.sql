--SELECIONANDO O BANCO
USE MeuRH;

--CRIANDO A STORED PROCEDURE
CREATE OR ALTER PROCEDURE SPR_REGISTRAR_ACESSO @P_FUN_ID INT, @P_DATA DATETIME
AS
BEGIN 
	--DESABILITANDO MENSAGEM DE LINHAS AFETADAS
	SET NOCOUNT ON;
	--DELCRARNDO UMA VARIAVEL PARA SABER OS PONTOS EM ABERTO DOS FUNCIONARIOS
	DECLARE @QTED_PONTOS_ABERTOS INT;
	SELECT @QTED_PONTOS_ABERTOS = COUNT(*)
		FROM PAC_PONTOS_ACESSOS
		WHERE FUN_ID = @P_FUN_ID
		AND PAC_DATA_FINAL IS NULL;
	IF @QTED_PONTOS_ABERTOS = 0
	BEGIN
		--NOVO PONTO
		INSERT INTO PAC_PONTOS_ACESSOS(PAC_DATA_INICIAL, FUN_ID)
			VALUES(@P_DATA, @P_FUN_ID)
	END

	ELSE
	BEGIN
		--ATUALIZAR O PONTO ABERTO
		UPDATE PAC_PONTOS_ACESSOS 
			SET PAC_DATA_FINAL = @P_DATA
			WHERE FUN_ID = @P_FUN_ID
			AND PAC_DATA_FINAL IS NULL;
	END;
	--HABILITANDO MENSAGEM DE LINHAS AFETADAS
	SET NOCOUNT OFF;
END;

--CHAMANDO A SPE
EXECUTE DBO.SPR_REGISTRAR_ACESSO 1, '2017-02-10 07:00:00'; 
--OUTRA FORMA
EXEC DBO.SPR_REGISTRAR_ACESSO 1, '2017-02-10 21:00:00'; 

--VISUALIZANDO A MUDAN�A
SELECT * FROM PAC_PONTOS_ACESSOS;

--VISUALIZANDO A VIEW
SELECT * FROM VW_PONTO_FUNCIONARIOS;