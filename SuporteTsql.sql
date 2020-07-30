--Esses scripts s�o para apoio do dia-a-dia

--Restri��o de n�o-nulo
CREATE TABLE CUR_CURSO (
  CUR_CODIGO INTEGER NOT NULL,
  CUR_NOME TEXT NOT NULL,
  CUR_PRECO NUMERIC
);

--Restri��o NULL
CREATE TABLE CUR_CURSO (
  CUR_CODIGO INTEGER NULL,
  CUR_NOME TEXT NULL,
  CUR_PRECO NUMERIC NULL
);
CREATE TABLE CUR_CURSO (
  CUR_CODIGO INTEGER,
  CUR_NOME TEXT,
  CUR_PRECO NUMERIC
);

--Restri��o de unicidade
CREATE TABLE aluno (
  codigo int,
  nome varchar(100),
  CPF char(11) UNIQUE,
  email varchar(50),
  telefone varchar(11),
  dt_nascimento date
);
CREATE TABLE aluno (
  codigo int,
  nome varchar(100),
  CPF char(11),
  email varchar(50),
  telefone varchar(11),
  dt_nascimento date,
  CONSTRAINT cpf_unique UNIQUE(CPF)
);
CONSTRAINT nome_restricao UNIQUE(coluna)

--Restri��o de unicidade com mais de uma coluna
CREATE TABLE aluno (
  codigo int,
  nome varchar(100),
  CPF char(11),
  RG char(10),
  orgaoEmissor char(15),
  email varchar(50),
  telefone varchar(11),
  dt_nascimento date,
  CONSTRAINT cpf3_unique UNIQUE(CPF),
  CONSTRAINT rg_unique UNIQUE(RG, orgaoEmissor)
);

--Restri��o CHECK
CREATE TABLE produto (
  codpro int NOT NULL,
  descricao varchar(100) NOT NULL,
  preco money NOT NULL CHECK (preco>0),
);
CHECK (preco>0)
CREATE TABLE produto (
  codpro int NOT NULL,
  descricao varchar(100) NOT NULL,
  preco money NOT NULL,
  CONSTRAINT ch_preco CHECK (preco>0)
);

--DEFAULT
CREATE TABLE salario (
  codinst int NOT NULL,
  valor money NOT NULL DEFAULT 2000.00,
  cargo varchar(20) NOT NULL DEFAULT 'Instrutor Passeio'
);

--Chaves prim�rias
CREATE TABLE curso (
  codigo int NOT NULL PRIMARY KEY,
  nome varchar(100),
  descricao varchar(max)
);
CREATE TABLE curso (
  codigo int NOT NULL UNIQUE,
  nome varchar(100),
  descricao varchar(max)
);
CREATE TABLE aluno (
  codigo int,
  nome varchar(100),
  CPF char(11),
  email varchar(50),
  telefone varchar(11),
  dt_nascimento date,
  CONSTRAINT pk_codigo_cpf PRIMARY KEY(codigo, CPF)
);

--Chaves estrangeiras
CREATE TABLE funcionario (
  codfun int NOT NULL,
  CPF char(11) UNIQUE,
  nome varchar(50) NOT NULL,
  email varchar(50),
  endereco varchar(100) NOT NULL,
  CONSTRAINT pk_func PRIMARY KEY (codfun)
);
CREATE TABLE dependente (
  CPF char(11) NOT NULL PRIMARY KEY,
  nome varchar(50) NOT NULL,
  email varchar(50),
  dt_nascimento date
);
CREATE TABLE dependente (
  CPF char(11) NOT NULL PRIMARY KEY,
  nome varchar(50) NOT NULL,
  email varchar(50),
  dt_nascimento date,
  codfun int NOT NULL
);
CREATE TABLE dependente (
  CPF char(11) NOT NULL PRIMARY KEY,
  nome varchar(50) NOT NULL,
  email varchar(50),
  dt_nascimento date,
  codfun int NOT NULL FOREIGN KEY REFERENCES funcionario(codfun)
);
CREATE TABLE dependente (
  CPF char(11) NOT NULL PRIMARY KEY,
  nome varchar(50) NOT NULL,
  email varchar(50),
  dt_nascimento date,
  codfun int NOT NULL,
  CONSTRAINT PK_fun_dep FOREIGN KEY (codfun) REFERENCES funcionario(codfun)
);
CONSTRAINT nome_restricao FOREIGN KEY (campo1, campo2, �, campoN) REFERENCES tabela(campo1, campo2, �, campoN);

--Campos IDENTITY
CREATE TABLE contas_pagar (
  codcpg int NOT NULL IDENTITY(1,1),
  descricao varchar(100) NOT NULL,
  valor money NOT NULL CHECK(valor>0)
);

--Altera��o de tabelas

--Incluindo colunas
ALTER TABLE nome_tabela ADD nome_coluna tipo;
ALTER TABLE aluno ADD RG char(9);

--Alterando colunas
ALTER TABLE nome_tabela
ALTER COLUMN nome_coluna tipo;

ALTER TABLE aluno
ALTER COLUMN email char(30);

--Excluindo colunas
ALTER TABLE nome_tabela DROP COLUMN nome_coluna;
ALTER TABLE aluno DROP COLUMN endereco;

--Alterando o nome de tabelas e colunas
EXEC sp_rename 'nome_antigo', 'novo_nome';
--exemplo
EXEC sp_rename 'contas_pagar', 'contas_a_pagar';
--O comando sp_rename tamb�m permite alterar o nome de colunas.
EXEC sp_rename 'tabela.nome', 'novo_nome', 'COLUMN';
--exemplo
EXEC sp_rename 'carro.fabricacao', 'ano_fabricacao', 'COLUMN';

--Inclus�o de restri��es

--UNIQUE RESTRI��O DE COLUNA
ALTER TABLE tabela ADD UNIQUE (coluna1, coluna2 ... colunaN);

--UNIQUE RESTRI��O DE TABELA
ALTER TABLE tabela ADD CONSTRAINT nome_restricao UNIQUE (coluna1, coluna2 ... colunaN);

--PRIMARY KEY RESTRI��O DE COLUNA
ALTER TABLE tabela ADD PRIMARY KEY (coluna1, coluna2 ... colunaN);

--PRIMARY KEY RESTRI��O DE TABELA
ALTER TABLE tabela ADD CONSTRAINT nome_restricao PRIMARY KEY (coluna1, coluna2 ... colunaN);

--FOREIGN KEY RESTRI��O DE COLUNA
ALTER TABLE tabela
ADD FOREIGN KEY (coluna1, coluna2 ... colunaN) REFERENCES tabela(coluna1, coluna2 ... colunaN);

--FOREIGN KEY RESTRI��O DE TABELA
ALTER TABLE tabela
ADD CONSTRAINT nome_restricao
FOREIGN KEY (coluna1, coluna2 ... colunaN) REFERENCES tabela(coluna1, coluna2 ... colunaN);

--CHECK RESTRI��O DE COLUNA
ALTER TABLE tabela ADD CHECK (condicao);

--CHECK RESTRI��O DE TABELA
ALTER TABLE tabela
ADD CONSTRAINT nome_restricao CHECK (condicao);

--DEFAULT
ALTER TABLE tabela
ALTER CONSTRAINT nomeRestricao DEFAULT 'valor padr�o' FOR nomeColuna;

--Exclus�o de restri��es
ALTER TABLE tabela DROP CONSTRAINT nome_restricao;

--Exclus�o de tabelas
--Multiplas tabelas
DROP TABLE tabela1, tabela2 ... tabelaN;

--uma tabela
DROP TABLE dependente;

--excluir v�rias tabelas de uma �nica vez
DROP TABLE dependente1, dependente2, dependente3, dependente4;

--Inserindo dados
INSERT INTO nome_tabela (coluna1,coluna2,coluna3,... colunaN)
VALUES (valor1,valor2,valor3,...valorN);

--Atualizando dados
UPDATE nome_tabela SET nome_campo1 = valor1, nome_campo2 = valor2 ... nome_campoN = valorN

--Utilizando o where
UPDATE nome_tabela SET nome_campo1 = valor1, nome_campo2 = valor2 ... nome_campoN = valorN 
WHERE condicao;

--Deletando dados
DELETE FROM nome_tabela WHERE condi��o;

--Consultas b�sicas
SELECT * FROM carro WHERE modelo = 'Celta';
SELECT * FROM carro WHERE modelo <> 'Celta';

--Utilizando aliases
SELECT nome AS 'Nome do aluno', email AS 'Endere�o de e-mail' FROM aluno;

--Ignorando valores repetidos
SELECT DISTINCT modelo, ano FROM carro;

--Ordenando os dados
SELECT nome, email FROM aluno ORDER BY nome ASC;

--forma desc
SELECT nome, email FROM aluno ORDER BY nome DESC;

--sem defini��o da ordem
SELECT nome, email FROM aluno ORDER BY nome;

SELECT nome, email FROM aluno ORDER BY nome ASC;

--usando v�rias colunas
SELECT * FROM tabela ORDER BY coluna1, coluna2 ... colunaN;

--Um pouco mais sobre filtros e a cl�usula WHERE

--Usando operador and
SELECT * FROM aula WHERE codinst = 1 AND placa = 'asd0989';

--Usando operador or
SELECT * FROM aluno WHERE nome = 'wagner' OR codalu = 5;

--usando operador not
SELECT * FROM instrutor WHERE NOT codinst = 2;

--usando operador between
SELECT * FROM tabela WHERE campo BETWEEN valor_inicial AND valor_final;
SELECT * FROM aula WHERE agendamento BETWEEN '01/10/2014' AND '14/10/2014';

--usando operador in
SELECT * FROM tabela WHERE campo IN (valor1, valor2 ... valor);

--Atrav�s de uma subconsulta
SELECT * FROM tabela WHERE campo IN (SELECT campo FROM tabela2);
SELECT * FROM aluno WHERE nome IN ('Wagner', 'N�o existe', 'Lucas Silva', 'Fabiano', 'N�o existe');

--operador null
SELECT * FROM aluno WHERE RG = NULL;

--operador is  null
SELECT * FROM aluno WHERE RG IS NULL;

--operador is not null
SELECT * FROM aluno WHERE RG IS NOT NULL;

--ADICINANDO CAMPO EM TABELA COM REGISTROS
ALTER [TIPO DO OBJETO] [NOME DA TABELA] 
	ADD [NOME DO CAMPO] [TIPO DE DADOS] [NULO OU NOT NULL] DEFAULT '-';
--EXEMPLO
ALTER TABLE FUN_FUNCIONARIOS 
	ADD FUN_CPF CHAR(11) NOT NULL DEFAULT '-';

--UTILIZANDO O UPTADE COM APENAS UM CAMPO
UPDATE [NOME DA TABELA]
	SET [NOME DO CAMPO A SER ATUALIZADO] = '07736845069'
	WHERE [NOME DO CAMPO DE CRIT�RIO] = 1;
--EXEMPLO
UPDATE FUN_FUNCIONARIOS
	SET FUN_CPF = '07736845069'
	WHERE FUN_ID = 1;

--UTILIZANDO O UPTADE COM MAIS DE UM CAMPO
UPDATE [NOME DA TABELA]
	SET [NOME DO CAMPO A SER ATUALIZADO] = '07736845069', [NOME DO CAMPO] = '1994-12-07'
	WHERE [NOME DO CAMPO DE CRIT�RIO] = 1;

--CRIANDO UMA CONSTRAINT DE UNIQUE
ALTER TABLE [NOME DA TABELA]
	ADD CONSTRAINT UC__FUN_FUNCIONARIOS_FUN_CPF [NOME DA CONSTRAINT, SEGUINDO ESSE PADR�O = UC__NOME_DA_TABELA_NOME_DO CAMPO ] UNIQUE [CLUSTERED OU NONCLUSTERED] (FUN_CPF);
--EXEMPLO
ALTER TABLE FUN_FUNCIONARIOS
	ADD CONSTRAINT UC__FUN_FUNCIONARIOS_FUN_CPF UNIQUE NONCLUSTERED (FUN_CPF);

--CRIANDO CHAVE ESTRANGEIRA 
ALTER TABLE [NOMDE DA TABELA]
	ADD CONSTRAINT FK_PAC_PONTOS_ACESSOS__FUN_FUNCIONARIOS__FUN_ID [NOME DA CHAVE, SEGUINDO O PADR�O = FK_TABELA_ATUAL__TABELA_REFERENCIA__CAMPO DA TABELA]
	FOREIGN KEY([NOME DO CAMPO])
	REFERENCES FUN_FUNCIONARIOS([NOME DO CAMPO DA TABELA REFERENCIA]);
--EXEMPLO
ALTER TABLE PAC_PONTOS_ACESSOS
	ADD CONSTRAINT FK_PAC_PONTOS_ACESSOS__FUN_FUNCIONARIOS__FUN_ID
	FOREIGN KEY(FUN_ID)
	REFERENCES FUN_FUNCIONARIOS(FUN_ID);

--CRIANDO UMA CONSTRANIT DO TIPO CHECK 
ALTER TABLE [NOME DA TABELA]
	ADD CONSTRAINT CK_PAC_PONTOS_ACESSOS__DATA_INICIAL_DATA_FINAL [NOME DA CONSTRAINT] 
	CHECK 
	(
	 [INSERIR OS PARAMETROS DA REGRA DE NEGOCIOS]
	);
--EXEMPLO
ALTER TABLE PAC_PONTOS_ACESSOS
	ADD CONSTRAINT CK_PAC_PONTOS_ACESSOS__DATA_INICIAL_DATA_FINAL
	CHECK 
	(--INSERINDO MAIS PARAMETROS NA REGRA DE NEG�CIO
		PAC_DATA_INICIAL < PAC_DATA_FINAL AND 
		DATEPART(DAY, PAC_DATA_INICIAL) = DATEPART(DAY, PAC_DATA_FINAL) AND
		DATEPART(MONTH, PAC_DATA_INICIAL) = DATEPART(MONTH, PAC_DATA_FINAL) AND
		DATEPART(YEAR, PAC_DATA_INICIAL) = DATEPART(YEAR, PAC_DATA_FINAL)
	);

--APAGANDO UMA CONSTRAINT
ALTER TABLE [NOME DA TABELA] DROP CONSTRAINT [NOME DA CONSTRAINT];
--EXEMPLO
ALTER TABLE PAC_PONTOS_ACESSOS DROP CONSTRAINT CK_PAC_PONTOS_ACESSOS__DATA_INICIAL_DATA_FINAL;

--TREINANDO JOINS

--FAZENDO UMA CONSULTAS ENTRE TABELAS
SELECT tab1.coluna1, tab1.coluna2, ..., tab1.colunaN, tab2.coluna1, tab2.coluna2, ..., tab2.colunaN
FROM tabela1 tab1, tabela2 tab2
WHERE tab1.codtab1 = tab2.codtab1;

--SINTAXE DO INNER JOIN
SELECT * FROM tabela1 apelido1
  INNER JOIN tabela2 apelido2
  ON (apelido1.campo1 = apelido2.campo2)

--A sintaxe do LEFT JOIN no SQL
SELECT * FROM tabela_da_esquerda apelido
  LEFT JOIN tabela_da_direita apelido
  ON (condi��o)

--A sintaxe do RIGHT JOIN
SELECT * FROM tabela_da_esquerda apelido
  RIGHT JOIN tabela_da_direita apelido
  ON (condi��o)

--FUN��ES
--Para tratar cadeias de caracteres, as mais usadas s�o

--CONCAT: Agrupa duas ou mais cadeias de caracteres.
CONCAT(string1, string2 ... stringN);

--LOWER: Converte todos os caracteres para min�sculo.
LOWER(string);

--UPPER: Converte todos os caracteres para mai�sculo.
UPPER(string);

--REPLACE: Substitui todas as ocorr�ncias de uma sequ�ncia de caracteres por outra.
REPLACE(string_original, string_a_trocar, string_nova);

--SUBSTRING: Retorna parte de uma cadeia de caracteres definida.
SUBSTRING('string_original', 'posicao', 'tamanho');

--fun��es escalares matem�ticas, as mais utilizadas s�o

--ABS: Retorna o valor positivo absoluto do valor de entrada.
ABS(valor);

--LOG10: Retorna o logaritmo da base 10 do valor de entrada.
LOG10(valor);

--PI Retorna o valor da constante PI. 
PI();

--RAND: Retorna um n�mero aleat�rio entre 0 e 1. Se for informado um valor no seu par�metro, o n�mero gerado deixar� de ser aleat�rio, repetindo sempre que o mesmo par�metro for informado. 
RAND([valor]);

--Para trabalhar com os tipos de data e hora, o SQL fornece v�rias fun��es, as utilizadas s�o as seguintes

--SYSDATETIME: Retorna data e hora no formato datetime2(7) do computador onde o banco de dados est� instalado:
SYSDATETIME();

--CURRENT_TIMESTAMP: Retorna o timestamp do computador onde o banco de dados est� instalado
CURRENT_TIMESTAMP();

--DATEFROMPARTS: Retorna uma data a partir dos par�metros passados. Sua sintaxe �:
DATEFROMPARTS ( ano, mes, dia )

--DATEDIFF: Retorna a diferen�a entre duas datas.
DATEDIFF(unidade_retorno, data_inicial, data_final);

--A unidade de retorno pode ser:

--Year- Anos;
--Quarter � Trimestres;
--Month � Meses;
--Dayofyear � Dias do Ano;
--Day � Dias;
--Week � Semanas;
--Hour � Horas;
--Minute � Minutos;
--Second � Segundos;
--Millisecond � milissegundos;
--Microsecond � Microssegundos;
--Nanosecond � Nanossegundos.

--HOST_NAME: Retorna o nome da esta��o que est� executando.

--DB_NAME: Retorna o banco de dados que est� conectado agora.

--SYSTEM_USER: Retorna o usu�rio conectado.

--CAST: Realiza a convers�o entre tipos de dados. 
CAST ( valor AS tipo_dados [ ( tamanho ) ] )

--FUN��ES de agrega��o ou sumarizadoras

--As mais utilizadas s�o:

--MIN: Retorna o menor valor;
--MAX: Retorna o maior valor;
--SUM: Calcula a soma de todos os valores;
--AVG: Calcula a m�dia de todos os valores;
--COUNT: Retorna o n�mero de itens.

--SELECIONANADO O TOTAL DE REGISTROS
SELECT codinst, COUNT(*) FROM aula

--USANDO GROUP BY
SELECT codinst, COUNT(*) FROM aula GROUP BY codinst

--USANDO GROUP BY COM HAVING
SELECT codinst, COUNT(*) FROM aula GROUP BY codinst HAVING codinst > 5;

--Tamb�m podemos informar fun��es de agrega��o no HAVING
SELECT codinst, COUNT(*) FROM aula GROUP BY codinst HAVING COUNT(*) >= 4;

--A sintaxe b�sica para criar uma fun��o no SQL Server
CREATE FUNCTION nome_fun��o (@parametro tipo, @parametro2 tipo2, ... @parametroN tipoN)
RETURNS tipo_retorno
BEGIN
  Comando1
  Comando2
  ComandoN
END

--Na assinatura da fun��o, podemos informar poss�veis par�metros
CREATE FUNCTION nome_fun��o (@parametro tipo, @parametro2 tipo2, ... @parametroN tipoN)

--Em seguida, caso a fun��o for retornar algo, o tipo do retorno deve ser informado
RETURNS tipo_retorno

--E por fim, n�s temos o bloco da fun��o
BEGIN
  Comando1
  Comando2
  ComandoN
END

--DECLARANDO VARIAVEL
DECLARE @nome_variavel tipo_dado

--Para atribuir um valor para a vari�vel, pode se utilizar a cl�usula SET
SET @nome_variavel = valor

--Estruturas condicionais no T-SQL
--A sintaxe do IF �
IF Express�o booleana
  Comando caso a condi��o seja verdadeira

--Caso, o bloco do IF contenha mais de uma linha, � necess�rio usar o bloco de c�digo Begin ... End
IF Express�o booleana
BEGIN

  Comando caso a condi��o seja verdadeira

  Comando2 caso a condi��o seja verdadeira

  Comando3 caso a condi��o seja verdadeira

END

--Tamb�m � poss�vel executar um ou mais comandos caso a condi��o verificada no IF seja falsa. Para isso devemos declarar a palavra reservada ELSE
IF Express�o booleana
BEGIN

  Comando caso a condi��o seja verdadeira

  Comando2 caso a condi��o seja verdadeira

  Comando3 caso a condi��o seja verdadeira

END
ELSE
BEGIN
  Comando caso a condi��o seja falsa

  Comando2 caso a condi��o seja falsa

  Comando3 caso a condi��o seja falsa
END

--Veja um exemplo desta cl�usula
DECLARE @nacionalidade varchar(50))
DECLARE @resultado varchar(50)
SET @nacionalidade = 'Brasileiro'
IF @nacionalidade = 'Brasileiro'
BEGIN
  SET @resultado = 'Voc� � brasileiro '
  SET @resultado = CONCAT('Parab�ns ', @resultado)
END
ELSE
BEGIN
  SET @resultado = 'Voc� n�o � brasileiro'
  SET @resultado = CONCAT('Que Pena! ', @resultado)
END

--Estruturas de repeti��o no T-SQL
--A estrutura de repeti��o while executa um ou mais comandos enquanto a condi��o � verdadeira. A sintaxe dele �
WHILE Teste
BEGIN
Comando1
Comando2
...
ComandoN
END

--Veja um exemplo do seu uso
DECLARE @resultado varchar(max), @contador int
SET @contador = 0
SET @resultado = ''

WHILE @contador <= 10
BEGIN
  SET @resultado = CONCAT(@resultado, @contador, ', ')
  SET @contador = @contador + 1;
END

--Um pouco sobre o retorno das fun��es
CREATE FUNCTION soma(@n1 int, @n2 int)
RETURNS int
BEGIN
  RETURN @n1 + @n2
END
--Na fun��o acima, seu tipo de retorno � INT
RETURNS int

--CRIANDO UMA FUN��O QUE RETORNA UMA TABELA
CREATE FUNCTION multi_valorada(@numero int)
RETURNS @tabela TABLE(campo int)
BEGIN
  DECLARE @contador int
  SET @contador = 0

  WHILE @contador <= @numero
  BEGIN
    INSERT INTO @tabela(campo) VALUES (@contador)
    SET @contador = @contador + 1;
  END

  RETURN
END
--Acima, foi declarado no tipo de retorno uma tabela com apenas um campo do tipo inteiro
RETURNS @tabela TABLE(campo int)

--Esta � uma tabela virtual. Dentro da fun��o, podemos a utilizar como qualquer outra tabela do banco. Assim, para inserir os valores nela, usamos o comando INSERT que j� conhecemos
INSERT INTO @tabela(campo) VALUES (@contador)

--Tamb�m podemos retornar uma tabela existente no banco. Para isso, deve ser informado que o retorno da fun��o � do tipo TABLE. Por exemplo
CREATE FUNCTION alunos_maiores(@cod int)
RETURNS TABLE
AS
RETURN (SELECT *
        FROM  aluno
        WHERE codalu >= @cod)

--Apagando user functions
--O comando usado para apagar uma ou mais fun��es � o DROP FUNCTION. Sua sintaxe � a seguinte
DROP FUNCTION fun��o1, fun��o2, ... fun��o;

--CALCULANDO HORAS TRABALHADAS DO FUNCIONARIO
SELECT DATA,
	   FUN_ID,
	   (
		FORMAT(SUM([DIFERENCIA EM SEGUNDOS]) / 3600, '00') + ':' + 
		FORMAT((SUM([DIFERENCIA EM SEGUNDOS]) % 3600)/60, '00') + ':' +
		FORMAT(((SUM([DIFERENCIA EM SEGUNDOS])%3600)%60), '00')
	   ) AS [HORAS TRABALHADAS]
FROM(
	SELECT DATEDIFF(SECOND, PAC_DATA_INICIAL, PAC_DATA_FINAL) [DIFERENCIA EM SEGUNDOS], 
		CONVERT(DATE,PAC_DATA_FINAL) AS DATA,
		FUN_ID
		FROM PAC_PONTOS_ACESSOS
	) AS DADOS_PONTO
	GROUP BY DATA, FUN_ID
	ORDER BY DATA;

--TRAZENDO OS NOMES DOS FUNCIONARIOS
SELECT DADOS_PONTO.DATA,
	   CONCAT(FUN.FUN_SOBRENOME, ', ', FUN.FUN_NOME) AS [NOME FUNCION�RIO],
	   (
		FORMAT(SUM([DIFERENCIA EM SEGUNDOS]) / 3600, '00') + ':' + 
		FORMAT((SUM([DIFERENCIA EM SEGUNDOS]) % 3600)/60, '00') + ':' +
		FORMAT(((SUM([DIFERENCIA EM SEGUNDOS])%3600)%60), '00')
	   ) AS [HORAS TRABALHADAS]
FROM(
	SELECT DATEDIFF(SECOND, PAC_DATA_INICIAL, PAC_DATA_FINAL) [DIFERENCIA EM SEGUNDOS], 
		CONVERT(DATE,PAC_DATA_FINAL) AS DATA,
		FUN_ID
		FROM PAC_PONTOS_ACESSOS
	) AS DADOS_PONTO
	INNER JOIN FUN_FUNCIONARIOS AS FUN
	ON DADOS_PONTO.FUN_ID = FUN.FUN_ID
	GROUP BY DADOS_PONTO.DATA, CONCAT(FUN.FUN_SOBRENOME, ', ', FUN.FUN_NOME)
	ORDER BY DADOS_PONTO.DATA;

--CRIANDO VIEWS
--Sua sintaxe mais b�sica � a seguinte
CREATE VIEW nome_view AS consulta;

--Sendo que consulta pode ser qualquer pesquisa utilizando SELECT. Por exemplo
CREATE VIEW carros_antigos AS
SELECT * FROM carro WHERE ano_fabricacao < 2013;

--Caso queria, � poss�vel mudar o nome das colunas retornadas pela consulta
CREATE VIEW nome_view (novoNome1, novoNome1, novoNomeN) AS consulta;

--Alterando views
ALTER VIEW nome_view AS consulta;

--Excluindo views
DROP VIEW nome_view;

--Stored Procedures
--O comando usado para criar um procedure � o CREATE PROCEDURE. Veja a sintaxe b�sica dele
CREATE PROCEDURE nome_do_stored_procedure
[
{@nome_par�metro1 tipo_de_dados_do_par�metro} [=valor_default] [OUTPUT]
]
[,..n]
AS
comando 1
comando 2
...
comando n

--Cursores
--Para cri�-los, deve se utilizar a cl�usula DECLARE CURSOR, que possui a sintaxe
DECLARE nome_cursor CURSOR [ LOCAL | GLOBAL ]
     [ FORWARD_ONLY | SCROLL ]
     [ STATIC | KEYSET | DYNAMIC | FAST_FORWARD ]
     [ READ_ONLY | SCROLL_LOCKS | OPTIMISTIC ]
     [ TYPE_WARNING ]
     FOR comando_select
     [ FOR UPDATE [ OF column_name [ ,...n ] ] ]
[;]

--Mesmo a sintaxe possuindo v�rias op��es, geralmente os cursores s�o criados com base na sintaxe simplificada
DECLARE nome_cursor CURSOR
     FOR comando_select

--Ap�s a declara��o do cursor, para ele ser percorrido, � necess�rio abri-lo com a cl�usula OPEN
OPEN nome_cursor

--Ao final do seu uso, � importante fech�-lo com a cl�usula CLOSE
CLOSE nome_cursor

--E desaloc�-lo com a cl�usula DEALLOCATE
DEALLOCATE nome_cursor

--Navegando pelos cursores
--A sintaxe mais simples do FETCH �
FETCH nome_cursor

--Neste caso, ser� retornado � primeira linha da consulta. Com ele tamb�m � poss�vel atribuir o resultado da consulta a uma vari�vel, atrav�s da cl�usula INTO
--FETCH nome_cursor INTO @nome_variavel_1, @nome_variavel_2, etc;

--Podemos utilizar o FETCH com uma combina��o de cl�usulas para navegar no conte�do do cursor, que podem ser:

--FETCH FIRST: retorna � primeira linha do cursor.
--FETCH NEXT: retorna a linha seguinte do cursor.
--FETCH PRIOR: retorna a linha anterior do cursor.
--FETCH RELATIVE n: retorna a linha na posi��o n em rela��o a linha atual (que ser� considerada 1).
--FETCH ABSOLUNT n: retorna a linha na posi��o n em rela��o a primeira linha do cursor.
--FETCH LAST: retorna a �ltima linha do cursor.
--Para acompanhar nesta navega��o pelo FETCH, o T-SQL fornece duas vari�veis globais: @@CURSOR_ROWS e @@FETCH_STATUS. Sendo que o @@CURSOR_ROWS retorna o n�mero de linhas existentes no cursor, que pode ser:

---m: O cursor � populado assincronamente. O valor retornado � o n�mero de linhas no KEYSET.
---1: O cursor � din�mico e o n�mero de linhas n�o pode ser determinado.
--0: Ou nenhum cursor foi aberto, ou o cursor aberto j� foi totalmente lido, ou �ltimo cursor aberto foi fechado ou desalocado.
--N: N�mero de linhas no cursor.
--J� o @@FETCH_STATUS retorna informa��es sobre o �ltimo FETCH executado, sendo que:

--0: FETCH executado com sucesso.
---1: FETCH falhou.
---2: O registro obtido foi perdido.
---9: O cursor n�o suporta opera��es FETCH.
--Al�m do FETCH, o comando UPDATE pode ser utilizado para atualizar alguma informa��o nos dados contidos no cursor (se ele n�o for read-only):
UPDATE nome_cursor SET coluna_nome = 'valor' WHERE CURRENT OF nome_cursor

--No caso acima, a coluna ser� alterada na linha atual do cursor.
--O mesmo pode ser feito com o comando DELETE
DELETE nome_cursor WHERE CURRENT OF nome_cursor

--TRANSA��ES
--BEGIN, COMMIT e ROLLBACK
--No T-SQL uma transa��o � definida dentro de um bloco declarado a partir do BEGIN TRANSACTION, conforme a sintaxe
BEGIN { TRAN | TRANSACTION }
    [ transacao_nome
      [ WITH MARK [ 'descricao' ] ]
--instru��es
COMMIT [ transacao_nome]
ROLLBACK [transacao_nome]

--Triggers
--Veja a sintaxe de cria��o de um trigger:
CREATE TRIGGER nome_trigger on nome_tabela
evento tipo_evento
AS
BEGIN

   COMANDOS

END
