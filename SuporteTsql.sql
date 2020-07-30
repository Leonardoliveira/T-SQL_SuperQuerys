--Esses scripts são para apoio do dia-a-dia

--Restrição de não-nulo
CREATE TABLE CUR_CURSO (
  CUR_CODIGO INTEGER NOT NULL,
  CUR_NOME TEXT NOT NULL,
  CUR_PRECO NUMERIC
);

--Restrição NULL
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

--Restrição de unicidade
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

--Restrição de unicidade com mais de uma coluna
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

--Restrição CHECK
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

--Chaves primárias
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
CONSTRAINT nome_restricao FOREIGN KEY (campo1, campo2, …, campoN) REFERENCES tabela(campo1, campo2, …, campoN);

--Campos IDENTITY
CREATE TABLE contas_pagar (
  codcpg int NOT NULL IDENTITY(1,1),
  descricao varchar(100) NOT NULL,
  valor money NOT NULL CHECK(valor>0)
);

--Alteração de tabelas

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
--O comando sp_rename também permite alterar o nome de colunas.
EXEC sp_rename 'tabela.nome', 'novo_nome', 'COLUMN';
--exemplo
EXEC sp_rename 'carro.fabricacao', 'ano_fabricacao', 'COLUMN';

--Inclusão de restrições

--UNIQUE RESTRIÇÃO DE COLUNA
ALTER TABLE tabela ADD UNIQUE (coluna1, coluna2 ... colunaN);

--UNIQUE RESTRIÇÃO DE TABELA
ALTER TABLE tabela ADD CONSTRAINT nome_restricao UNIQUE (coluna1, coluna2 ... colunaN);

--PRIMARY KEY RESTRIÇÃO DE COLUNA
ALTER TABLE tabela ADD PRIMARY KEY (coluna1, coluna2 ... colunaN);

--PRIMARY KEY RESTRIÇÃO DE TABELA
ALTER TABLE tabela ADD CONSTRAINT nome_restricao PRIMARY KEY (coluna1, coluna2 ... colunaN);

--FOREIGN KEY RESTRIÇÃO DE COLUNA
ALTER TABLE tabela
ADD FOREIGN KEY (coluna1, coluna2 ... colunaN) REFERENCES tabela(coluna1, coluna2 ... colunaN);

--FOREIGN KEY RESTRIÇÃO DE TABELA
ALTER TABLE tabela
ADD CONSTRAINT nome_restricao
FOREIGN KEY (coluna1, coluna2 ... colunaN) REFERENCES tabela(coluna1, coluna2 ... colunaN);

--CHECK RESTRIÇÃO DE COLUNA
ALTER TABLE tabela ADD CHECK (condicao);

--CHECK RESTRIÇÃO DE TABELA
ALTER TABLE tabela
ADD CONSTRAINT nome_restricao CHECK (condicao);

--DEFAULT
ALTER TABLE tabela
ALTER CONSTRAINT nomeRestricao DEFAULT 'valor padrão' FOR nomeColuna;

--Exclusão de restrições
ALTER TABLE tabela DROP CONSTRAINT nome_restricao;

--Exclusão de tabelas
--Multiplas tabelas
DROP TABLE tabela1, tabela2 ... tabelaN;

--uma tabela
DROP TABLE dependente;

--excluir várias tabelas de uma única vez
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
DELETE FROM nome_tabela WHERE condição;

--Consultas básicas
SELECT * FROM carro WHERE modelo = 'Celta';
SELECT * FROM carro WHERE modelo <> 'Celta';

--Utilizando aliases
SELECT nome AS 'Nome do aluno', email AS 'Endereço de e-mail' FROM aluno;

--Ignorando valores repetidos
SELECT DISTINCT modelo, ano FROM carro;

--Ordenando os dados
SELECT nome, email FROM aluno ORDER BY nome ASC;

--forma desc
SELECT nome, email FROM aluno ORDER BY nome DESC;

--sem definição da ordem
SELECT nome, email FROM aluno ORDER BY nome;

SELECT nome, email FROM aluno ORDER BY nome ASC;

--usando várias colunas
SELECT * FROM tabela ORDER BY coluna1, coluna2 ... colunaN;

--Um pouco mais sobre filtros e a cláusula WHERE

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

--Através de uma subconsulta
SELECT * FROM tabela WHERE campo IN (SELECT campo FROM tabela2);
SELECT * FROM aluno WHERE nome IN ('Wagner', 'Não existe', 'Lucas Silva', 'Fabiano', 'Não existe');

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
	WHERE [NOME DO CAMPO DE CRITÉRIO] = 1;
--EXEMPLO
UPDATE FUN_FUNCIONARIOS
	SET FUN_CPF = '07736845069'
	WHERE FUN_ID = 1;

--UTILIZANDO O UPTADE COM MAIS DE UM CAMPO
UPDATE [NOME DA TABELA]
	SET [NOME DO CAMPO A SER ATUALIZADO] = '07736845069', [NOME DO CAMPO] = '1994-12-07'
	WHERE [NOME DO CAMPO DE CRITÉRIO] = 1;

--CRIANDO UMA CONSTRAINT DE UNIQUE
ALTER TABLE [NOME DA TABELA]
	ADD CONSTRAINT UC__FUN_FUNCIONARIOS_FUN_CPF [NOME DA CONSTRAINT, SEGUINDO ESSE PADRÃO = UC__NOME_DA_TABELA_NOME_DO CAMPO ] UNIQUE [CLUSTERED OU NONCLUSTERED] (FUN_CPF);
--EXEMPLO
ALTER TABLE FUN_FUNCIONARIOS
	ADD CONSTRAINT UC__FUN_FUNCIONARIOS_FUN_CPF UNIQUE NONCLUSTERED (FUN_CPF);

--CRIANDO CHAVE ESTRANGEIRA 
ALTER TABLE [NOMDE DA TABELA]
	ADD CONSTRAINT FK_PAC_PONTOS_ACESSOS__FUN_FUNCIONARIOS__FUN_ID [NOME DA CHAVE, SEGUINDO O PADRÃO = FK_TABELA_ATUAL__TABELA_REFERENCIA__CAMPO DA TABELA]
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
	(--INSERINDO MAIS PARAMETROS NA REGRA DE NEGÓCIO
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
  ON (condição)

--A sintaxe do RIGHT JOIN
SELECT * FROM tabela_da_esquerda apelido
  RIGHT JOIN tabela_da_direita apelido
  ON (condição)

--FUNÇÕES
--Para tratar cadeias de caracteres, as mais usadas são

--CONCAT: Agrupa duas ou mais cadeias de caracteres.
CONCAT(string1, string2 ... stringN);

--LOWER: Converte todos os caracteres para minúsculo.
LOWER(string);

--UPPER: Converte todos os caracteres para maiúsculo.
UPPER(string);

--REPLACE: Substitui todas as ocorrências de uma sequência de caracteres por outra.
REPLACE(string_original, string_a_trocar, string_nova);

--SUBSTRING: Retorna parte de uma cadeia de caracteres definida.
SUBSTRING('string_original', 'posicao', 'tamanho');

--funções escalares matemáticas, as mais utilizadas são

--ABS: Retorna o valor positivo absoluto do valor de entrada.
ABS(valor);

--LOG10: Retorna o logaritmo da base 10 do valor de entrada.
LOG10(valor);

--PI Retorna o valor da constante PI. 
PI();

--RAND: Retorna um número aleatório entre 0 e 1. Se for informado um valor no seu parâmetro, o número gerado deixará de ser aleatório, repetindo sempre que o mesmo parâmetro for informado. 
RAND([valor]);

--Para trabalhar com os tipos de data e hora, o SQL fornece várias funções, as utilizadas são as seguintes

--SYSDATETIME: Retorna data e hora no formato datetime2(7) do computador onde o banco de dados está instalado:
SYSDATETIME();

--CURRENT_TIMESTAMP: Retorna o timestamp do computador onde o banco de dados está instalado
CURRENT_TIMESTAMP();

--DATEFROMPARTS: Retorna uma data a partir dos parâmetros passados. Sua sintaxe é:
DATEFROMPARTS ( ano, mes, dia )

--DATEDIFF: Retorna a diferença entre duas datas.
DATEDIFF(unidade_retorno, data_inicial, data_final);

--A unidade de retorno pode ser:

--Year- Anos;
--Quarter – Trimestres;
--Month – Meses;
--Dayofyear – Dias do Ano;
--Day – Dias;
--Week – Semanas;
--Hour – Horas;
--Minute – Minutos;
--Second – Segundos;
--Millisecond – milissegundos;
--Microsecond – Microssegundos;
--Nanosecond – Nanossegundos.

--HOST_NAME: Retorna o nome da estação que está executando.

--DB_NAME: Retorna o banco de dados que está conectado agora.

--SYSTEM_USER: Retorna o usuário conectado.

--CAST: Realiza a conversão entre tipos de dados. 
CAST ( valor AS tipo_dados [ ( tamanho ) ] )

--FUNÇÕES de agregação ou sumarizadoras

--As mais utilizadas são:

--MIN: Retorna o menor valor;
--MAX: Retorna o maior valor;
--SUM: Calcula a soma de todos os valores;
--AVG: Calcula a média de todos os valores;
--COUNT: Retorna o número de itens.

--SELECIONANADO O TOTAL DE REGISTROS
SELECT codinst, COUNT(*) FROM aula

--USANDO GROUP BY
SELECT codinst, COUNT(*) FROM aula GROUP BY codinst

--USANDO GROUP BY COM HAVING
SELECT codinst, COUNT(*) FROM aula GROUP BY codinst HAVING codinst > 5;

--Também podemos informar funções de agregação no HAVING
SELECT codinst, COUNT(*) FROM aula GROUP BY codinst HAVING COUNT(*) >= 4;

--A sintaxe básica para criar uma função no SQL Server
CREATE FUNCTION nome_função (@parametro tipo, @parametro2 tipo2, ... @parametroN tipoN)
RETURNS tipo_retorno
BEGIN
  Comando1
  Comando2
  ComandoN
END

--Na assinatura da função, podemos informar possíveis parâmetros
CREATE FUNCTION nome_função (@parametro tipo, @parametro2 tipo2, ... @parametroN tipoN)

--Em seguida, caso a função for retornar algo, o tipo do retorno deve ser informado
RETURNS tipo_retorno

--E por fim, nós temos o bloco da função
BEGIN
  Comando1
  Comando2
  ComandoN
END

--DECLARANDO VARIAVEL
DECLARE @nome_variavel tipo_dado

--Para atribuir um valor para a variável, pode se utilizar a cláusula SET
SET @nome_variavel = valor

--Estruturas condicionais no T-SQL
--A sintaxe do IF é
IF Expressão booleana
  Comando caso a condição seja verdadeira

--Caso, o bloco do IF contenha mais de uma linha, é necessário usar o bloco de código Begin ... End
IF Expressão booleana
BEGIN

  Comando caso a condição seja verdadeira

  Comando2 caso a condição seja verdadeira

  Comando3 caso a condição seja verdadeira

END

--Também é possível executar um ou mais comandos caso a condição verificada no IF seja falsa. Para isso devemos declarar a palavra reservada ELSE
IF Expressão booleana
BEGIN

  Comando caso a condição seja verdadeira

  Comando2 caso a condição seja verdadeira

  Comando3 caso a condição seja verdadeira

END
ELSE
BEGIN
  Comando caso a condição seja falsa

  Comando2 caso a condição seja falsa

  Comando3 caso a condição seja falsa
END

--Veja um exemplo desta cláusula
DECLARE @nacionalidade varchar(50))
DECLARE @resultado varchar(50)
SET @nacionalidade = 'Brasileiro'
IF @nacionalidade = 'Brasileiro'
BEGIN
  SET @resultado = 'Você é brasileiro '
  SET @resultado = CONCAT('Parabéns ', @resultado)
END
ELSE
BEGIN
  SET @resultado = 'Você não é brasileiro'
  SET @resultado = CONCAT('Que Pena! ', @resultado)
END

--Estruturas de repetição no T-SQL
--A estrutura de repetição while executa um ou mais comandos enquanto a condição é verdadeira. A sintaxe dele é
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

--Um pouco sobre o retorno das funções
CREATE FUNCTION soma(@n1 int, @n2 int)
RETURNS int
BEGIN
  RETURN @n1 + @n2
END
--Na função acima, seu tipo de retorno é INT
RETURNS int

--CRIANDO UMA FUNÇÃO QUE RETORNA UMA TABELA
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

--Esta é uma tabela virtual. Dentro da função, podemos a utilizar como qualquer outra tabela do banco. Assim, para inserir os valores nela, usamos o comando INSERT que já conhecemos
INSERT INTO @tabela(campo) VALUES (@contador)

--Também podemos retornar uma tabela existente no banco. Para isso, deve ser informado que o retorno da função é do tipo TABLE. Por exemplo
CREATE FUNCTION alunos_maiores(@cod int)
RETURNS TABLE
AS
RETURN (SELECT *
        FROM  aluno
        WHERE codalu >= @cod)

--Apagando user functions
--O comando usado para apagar uma ou mais funções é o DROP FUNCTION. Sua sintaxe é a seguinte
DROP FUNCTION função1, função2, ... função;

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
	   CONCAT(FUN.FUN_SOBRENOME, ', ', FUN.FUN_NOME) AS [NOME FUNCIONÁRIO],
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
--Sua sintaxe mais básica é a seguinte
CREATE VIEW nome_view AS consulta;

--Sendo que consulta pode ser qualquer pesquisa utilizando SELECT. Por exemplo
CREATE VIEW carros_antigos AS
SELECT * FROM carro WHERE ano_fabricacao < 2013;

--Caso queria, é possível mudar o nome das colunas retornadas pela consulta
CREATE VIEW nome_view (novoNome1, novoNome1, novoNomeN) AS consulta;

--Alterando views
ALTER VIEW nome_view AS consulta;

--Excluindo views
DROP VIEW nome_view;

--Stored Procedures
--O comando usado para criar um procedure é o CREATE PROCEDURE. Veja a sintaxe básica dele
CREATE PROCEDURE nome_do_stored_procedure
[
{@nome_parâmetro1 tipo_de_dados_do_parâmetro} [=valor_default] [OUTPUT]
]
[,..n]
AS
comando 1
comando 2
...
comando n

--Cursores
--Para criá-los, deve se utilizar a cláusula DECLARE CURSOR, que possui a sintaxe
DECLARE nome_cursor CURSOR [ LOCAL | GLOBAL ]
     [ FORWARD_ONLY | SCROLL ]
     [ STATIC | KEYSET | DYNAMIC | FAST_FORWARD ]
     [ READ_ONLY | SCROLL_LOCKS | OPTIMISTIC ]
     [ TYPE_WARNING ]
     FOR comando_select
     [ FOR UPDATE [ OF column_name [ ,...n ] ] ]
[;]

--Mesmo a sintaxe possuindo várias opções, geralmente os cursores são criados com base na sintaxe simplificada
DECLARE nome_cursor CURSOR
     FOR comando_select

--Após a declaração do cursor, para ele ser percorrido, é necessário abri-lo com a cláusula OPEN
OPEN nome_cursor

--Ao final do seu uso, é importante fechá-lo com a cláusula CLOSE
CLOSE nome_cursor

--E desalocá-lo com a cláusula DEALLOCATE
DEALLOCATE nome_cursor

--Navegando pelos cursores
--A sintaxe mais simples do FETCH é
FETCH nome_cursor

--Neste caso, será retornado à primeira linha da consulta. Com ele também é possível atribuir o resultado da consulta a uma variável, através da cláusula INTO
--FETCH nome_cursor INTO @nome_variavel_1, @nome_variavel_2, etc;

--Podemos utilizar o FETCH com uma combinação de cláusulas para navegar no conteúdo do cursor, que podem ser:

--FETCH FIRST: retorna à primeira linha do cursor.
--FETCH NEXT: retorna a linha seguinte do cursor.
--FETCH PRIOR: retorna a linha anterior do cursor.
--FETCH RELATIVE n: retorna a linha na posição n em relação a linha atual (que será considerada 1).
--FETCH ABSOLUNT n: retorna a linha na posição n em relação a primeira linha do cursor.
--FETCH LAST: retorna a última linha do cursor.
--Para acompanhar nesta navegação pelo FETCH, o T-SQL fornece duas variáveis globais: @@CURSOR_ROWS e @@FETCH_STATUS. Sendo que o @@CURSOR_ROWS retorna o número de linhas existentes no cursor, que pode ser:

---m: O cursor é populado assincronamente. O valor retornado é o número de linhas no KEYSET.
---1: O cursor é dinâmico e o número de linhas não pode ser determinado.
--0: Ou nenhum cursor foi aberto, ou o cursor aberto já foi totalmente lido, ou último cursor aberto foi fechado ou desalocado.
--N: Número de linhas no cursor.
--Já o @@FETCH_STATUS retorna informações sobre o último FETCH executado, sendo que:

--0: FETCH executado com sucesso.
---1: FETCH falhou.
---2: O registro obtido foi perdido.
---9: O cursor não suporta operações FETCH.
--Além do FETCH, o comando UPDATE pode ser utilizado para atualizar alguma informação nos dados contidos no cursor (se ele não for read-only):
UPDATE nome_cursor SET coluna_nome = 'valor' WHERE CURRENT OF nome_cursor

--No caso acima, a coluna será alterada na linha atual do cursor.
--O mesmo pode ser feito com o comando DELETE
DELETE nome_cursor WHERE CURRENT OF nome_cursor

--TRANSAÇÕES
--BEGIN, COMMIT e ROLLBACK
--No T-SQL uma transação é definida dentro de um bloco declarado a partir do BEGIN TRANSACTION, conforme a sintaxe
BEGIN { TRAN | TRANSACTION }
    [ transacao_nome
      [ WITH MARK [ 'descricao' ] ]
--instruções
COMMIT [ transacao_nome]
ROLLBACK [transacao_nome]

--Triggers
--Veja a sintaxe de criação de um trigger:
CREATE TRIGGER nome_trigger on nome_tabela
evento tipo_evento
AS
BEGIN

   COMANDOS

END
