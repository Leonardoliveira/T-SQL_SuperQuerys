--SELECIONANDO O BANCO
USE MeuRH;

--CRIANDO A TRIGGER
CREATE TRIGGER TGR_PONTO_FUNCIONARIO
ON PAC_PONTOS_ACESSOS
AFTER INSERT, UPDATE
AS
BEGIN
	DECLARE @FUN_ID INT;
	SELECT @FUN_ID = FUN_ID FROM inserted;
	DECLARE @NOME_FUNCIONARIO VARCHAR(70);
	SELECT @NOME_FUNCIONARIO = CONCAT(FUN_SOBRENOME, ', ', FUN_NOME) 
	FROM FUN_FUNCIONARIOS;
	DECLARE @DATA_PONTO_INICIAL DATE;
	DECLARE @DATA_PONTO_FINAL DATE;
	SELECT @DATA_PONTO_INICIAL = PAC_DATA_INICIAL, @DATA_PONTO_FINAL = PAC_DATA_FINAL 
		FROM inserted;
	IF @DATA_PONTO_FINAL IS NULL
	BEGIN
		INSERT INTO LOG_LOGS(LOG_EVENTO) VALUES (@NOME_FUNCIONARIO + 'BATEU O PONTO EM ' + FORMAT(@DATA_PONTO_INICIAL, 'dd/MM/yy hh:mm'));
	END
	ELSE
	BEGIN
		INSERT INTO LOG_LOGS(LOG_EVENTO) VALUES (@NOME_FUNCIONARIO + 'BATEU O PONTO EM ' + FORMAT(@DATA_PONTO_FINAL, 'dd/MM/yy hh:mm'));
	END;
END;
