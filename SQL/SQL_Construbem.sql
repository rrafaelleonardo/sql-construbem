/* Criar Banco de dados */
create database db_construbem 
default character set utf8;


/* Ativar o Banco de Dados */
use db_construbem;


--
-- TB_SALES
--

/* Criar tabela tb_sales */
create table tb_sales (
Client_ID		varchar(20),
Categoria		varchar(15), 
Subcategoria	varchar(25), 
Produto			varchar(15), 
Year			varchar(10), 
Month			int, 
Cidade			varchar(15), 
Valor			float, 
Volume			int
)

/* Carregar dados via phpMyAdmin */
-- path: C:\wamp64\tmp\tb_sales.csv
-- desabilitar: Partial import
-- Skip this number of queries (for SQL) starting from the first one: digite 1
-- inserir o nome das colunas
-- habilitar: Do not abort on INSERT error

/* Consultar tabela tb_sales */
select * from tb_sales;

/* Contagem de numero de registros */
select count(Client_ID) as Qtde
from tb_sales;


--
-- LIMPEZA E TRATAMENTO DE DADOS (tb_sales)
--

/* Contagem distinta da coluna Year */
select Year, count(distinct Year) as Qtde
from tb_sales
group by Year
order by 1;
-- Out: Year, Qtde
	 -- 2020, 1
	 -- 2021, 1
      -- 2021-B, 1
	 -- 2022, 1

/* Exibir registro atraves de filtro */
select * , count(Client_ID) as Qtde
from tb_sales
where Year = '2021-B';

/* Deletar registro, cujo Year = '2021-B' */
delete from tb_sales
where Year = '2021-B';

/* Re-Contagem de numero de registros */
select count(Client_ID) as Qtde
from tb_sales;
-- Out: 14.798 registros

/* Consultar se há registros vazios da tabela tb_vendas atraves de filtro */
select * 
from tb_sales
where 
Client_ID = '' or
Categoria = '' or
Subcategoria = '' or
Produto = '' or
Year = '' or
Month = '' or
Cidade = '' or
Valor = '' or
Volume = '';

/* Deletar registros cujo o Produto e Cidade estejão vazias */
delete from tb_sales
where Produto = ''
or Cidade = '';

/* Re-Contagem de numero de registros */
select count(Client_ID) as Qtde
from tb_sales;
-- Out: 14.794 registros

/* Contagem distinta da coluna Subcategoria */
-- Deve haver apenas 10 Subcategorias
select Subcategoria, count(distinct Subcategoria) as Qtde
from tb_sales
group by Subcategoria
order by 1;
-- Existem 11 Subcategorias

/* Exibir registro atraves de filtro */
-- Possivel erro de digitalizacao "Sub-Categoria 99"
select *
from tb_sales
where Subcategoria = 'Sub-Categoria 99';

/* Deletar registros "Sub-Categoria 99" */
delete from tb_sales
where Subcategoria = 'Sub-Categoria 99';

/* Re-Contagem de numero de registros */
select count(Client_ID) as Qtde
from tb_sales;
-- Out: 14.792 registros

/* Re-exibir a contagem distinta da coluna Subcategoria */
-- Devem haver 10 Subcategorias
select Subcategoria, Categoria
from tb_sales
group by Subcategoria
order by 1;

/* Cada Sub-Categoria devem pertence a apenas uma categoria */
select SubCategoria, count(distinct Categoria) as Qtde
from tb_sales
group by SubCategoria
Having count(distinct Categoria) > 1;
-- As SubCategorias: "Sub-Categoria 7" e "Sub-Categoria 8" pertencem a mais categorias


/* Verificar qual Sub-Categoria pertence as mais de uma categoria */
select SubCategoria, Categoria, count(1) as Qtde
from tb_sales
where Categoria
in ('X', 'XT660', 'XTZ250', 'CB750')
group by SubCategoria, Categoria
Order by 1;
-- Realmente as SubCategorias,"Sub-Categoria 7" e "Sub-Categoria 8", pertencem a mais categorias

-- 14792 registros
/* Deletar as Sub-Categorias que pertence as mais de uma categoria e que possui a menor quantidade de registros*/
-- Sub-Categoria 7 cuja Categoria é 'XTZ250' que contém 8 registros; e 
-- Sub-Categoria 8 cuja Categoria é 'XT660' que contém 22 registros;

delete from tb_sales
where Categoria = 'XTZ250'
and SubCategoria = "Sub-Categoria 7";

/* Re-Contagem de numero de registros */
select count(Client_ID) as Qtde
from tb_sales;
-- Out: 14.784 registros

delete from tb_sales
where Categoria = 'XT660'
and SubCategoria = "Sub-Categoria 8";

/* Re-Contagem de numero de registros */
select count(Client_ID) as Qtde
from tb_sales;
-- Out: 14.762 registros


--
-- TB_POTENTIAL
--

/* Criar tabela tb_potential */
create table tb_potential  (
Client_ID			varchar(20), 
Year				int,
Area_Comercial		float, 
Area_Hibrida		int, 
Area_Residencial 	float,
Area_Industrial		float, 
BRL_Potential		float8
);

/* Configurar o MySQL para o carregamento do dados */
-- Habilitar o compartilhamento local
show global variables like 'local_infile';
show variables like 'secure_file_priv';
select @@global.secure_file_priv;
set global local_infile = 1;
set global local_infile = true;

/* Carregar arquivo csv para o MySQL via codigo */
LOAD DATA LOCAL INFILE  
'c:\\wamp64\\tmp\\potential.csv'
into table tb_potential
FIELDS TERMINATED by ','
ENCLOSED by '"'
lines terminated by '\r\n'
ignore 1 lines;

/* Consultar tabela tb_potential */
select * from tb_potential;

-- 10125 registros
/* Contagem de numero de registros da tabela tb_potential */
select count(Client_ID) as Qtde
from tb_potential;
-- Out: 10.125 registros

/* Consultar se há registros vazios da tabela tb_potential atraves de filtro */
select *
from tb_potential
where 
'Client_ID' = ''
or 'Year' = ''
or 'Area_Comercial' = ''
or 'Area_Hibrida' = ''
or 'Area_Residencial' = ''
or 'Area_Industrial' = ''
or 'BRLPotencial' = '';


--
-- CRIAR INDICES DAS TABELAS: TB_SALES E TB_POTENTIAL
--

/* Criar indices da tabela tb_sales e tb_potential */
create index index_sales on tb_sales (Client_ID);
create index index_potential on tb_potential (Client_ID);


-- drop table tb_vendas;
-- drop table tb_potencial;

--
-- TB_VENDAS
--

/* Criar tabela tb_vendas */
create table tb_vendas (
Cliente_ID		int,
Categoria 		varchar(15),
Subcategoria	varchar(25),
Produto			varchar(15),
Ano				varchar(5),
Mes				int,
Cidade			varchar(15),
Valor			float,
Volume			int
);

/* Inserir dados na tabela tb_vendas */
insert into tb_vendas (Cliente_ID, Categoria, Subcategoria, Produto, Ano, Mes, Cidade, Valor, Volume)
select replace (Client_ID, 'Client #',''), Categoria, Subcategoria, Produto, Year, Month, Cidade, Valor, Volume
from tb_sales
where Year
in ('2020', '2021', '2022');

/* Consultar tabela tb_vendas */
select * from tb_vendas;

/* Contagem de numero de registros */
select count(Cliente_ID) as Qtde
from tb_vendas;
-- Out: 14.762 registros


--
-- TB_POTENCIAL
--

/* Criar tabela tb_potencial */
create table tb_potencial  (
Cliente_ID			int, 
Ano					varchar(5),
Area_Comercial		float, 
Area_Hibrida		float, 
Area_Residencial	float,
Area_Industrial		float, 
ValorPotencial		float8
);

/* Inserir dados na tabela tb_potencial */
insert into tb_potencial (Cliente_ID, Ano, Area_Comercial, Area_Hibrida, Area_Residencial, Area_Industrial, ValorPotencial)
select replace (Client_ID, 'Client #',''), Year, Area_Comercial, Area_Hibrida, Area_Residencial, Area_Industrial, BRL_Potential
from tb_potential;

/* Consultar tabela tb_potencial */
select *
from tb_potencial;

/* Contagem de numero de registros */
select
count(Cliente_ID) as Qtde
from tb_potencial;
-- Out: 10.125 registros


--
-- ANALISE DE DADOS
--

/* tabela tb_vendas - Total de clientes */
-- Sem formatacao
select
count(distinct Cliente_ID) as Qtde
from tb_vendas;
-- Out: 1.562 registros

-- Com formatacao
select
format(count(distinct Cliente_ID), 0, 'de_DE') as Qtde
from tb_vendas;

/* tabela tb_vendas - Total vendidos */
-- Sem formatacao
select
sum(Valor) as Valor_Total
from tb_vendas;
-- Out: 289409914.92839366

-- Com formatacao
select
format(sum(Valor), 2, 'de_DE') as Valor_Total
from tb_vendas;
-- Out: 289.409.914,93

/* tabela tb_vendas - Contagem de: Categoria, SubCategoria, Produto e Cidade */
select
count(distinct Categoria) as Categoria,
count(distinct SubCategoria) as SubCategoria,
count(distinct Produto) as Produto,
count(distinct Cidade) as Cidade
from tb_vendas;

/* tabela tb_potencial - Total de clientes */
-- Sem formatacao
select 
count(distinct Cliente_ID) as Qtde
from tb_potencial;
-- Out: 3.375

-- Com formatacao
select 
format(count(distinct Cliente_ID), 0, 'de_DE') as Qtde
from tb_potencial;
-- Out: 3.375

/* tabela tb_potencial - Total vendidos */
-- Sem formatacao
select
sum(ValorPotencial) as Valor_Potencial_Total
from tb_potencial;
-- Out: 4229885012.483502

-- Com formatacao
select
format(sum(ValorPotencial), 2, 'de_DE') as Valor_Potencial_Total
from tb_potencial;
-- Out: 4.229.885.012,48

/* tabela tb_potencial - Total de Area: Area_Residencial, Area_Hibrida, Area_Comercial, Area_Industrial */
-- Sem formatacao
select
sum(Area_Residencial) as Area_Residencial,
sum(Area_Hibrida) as Area_Hibrida,
sum(Area_Comercial) as Area_Comercial,
sum(Area_Industrial) as Area_Industrial
from tb_potencial;

-- Com formatacao
select
format(sum(Area_Residencial), 2, 'de_DE') as Area_Residencial,
format(sum(Area_Hibrida), 2, 'de_DE') as Area_Hibrida,
format(sum(Area_Comercial), 2, 'de_DE') as Area_Comercial,
format(sum(Area_Industrial), 2, 'de_DE') as Area_Industrial
from tb_potencial;

/* Exibir Ano e Mes da tabela tb_vendas */
-- select 
-- min(Mes),
-- min(Ano),
-- max(Mes),
-- max(Ano)
-- from tb_vendas;

/* Exibir a Tabela Cliente_ID, Ano, Valor_Vendas e Valor_Total_Potencial da junção das tabelas: tb_venda e tb_potencial */
-- Criar tabela temporaria 01 temp01
-- Sem formatacao
create temporary table temp01(
select
v.Cliente_ID,
v.Ano,
sum(distinct v.Valor) as Valor_Vendas,
sum(distinct p.ValorPotencial) as Valor_Total_Potencial
from tb_vendas v
inner join tb_potencial p
on v.Cliente_ID = p.Cliente_ID
and v.Ano = p.Ano
group by v.Ano, p.Cliente_ID
);

/* Exibir tabela temporaria 01 temp01 */
select * 
from temp01;

/* Exibir a Tabela Ano, Valor_Vendas, Valor_Total_Potencial, Oportunidade, pct_Oportunidade(%), pct_Alcancado(%)
da tabela temporaria 01 temp01 */
-- Sem formatacao
select
Ano,
sum(Valor_Vendas) as Valor_Vendas,
sum(Valor_Total_Potencial) as Valor_Total_Potencial ,
sum(Valor_Total_Potencial) - sum(Valor_Vendas) as Oportunidade,
abs(((sum(Valor_Vendas) / sum(Valor_Total_Potencial)) * 100) - 100) as "pct_Oportunidade(%)",
abs((((sum(Valor_Vendas) / sum(Valor_Total_Potencial)) * 100) - 100) + 100) as "pct_Alcancado(%)"
from temp01
group by Ano
order by Ano;

-- Com formatacao
select
Ano,
format(sum(Valor_Vendas), 2, 'de_DE') as Valor_Vendas,
format(sum(Valor_Total_Potencial), 2, 'de_DE') as Valor_Total_Potencial ,
format(sum(Valor_Total_Potencial) - sum(Valor_Vendas), 2, 'de_DE') as Oportunidade,
format(abs(((sum(Valor_Vendas) / sum(Valor_Total_Potencial)) * 100) - 100), 2, 'de_DE') as "pct_Oportunidade(%)",
format(abs((((sum(Valor_Vendas) / sum(Valor_Total_Potencial)) * 100) - 100) + 100), 2, 'de_DE') as "pct_Alcancado(%)"
from temp01
group by Ano
order by Ano;

/* Exibir a Tabela tb_venda o Ano, Categoria e Valor */
-- Obs.: mês 8 (agosto)
select * 
from (
select
Ano,
Categoria,
Valor
from tb_vendas
where mes <= 8
) t;

/* Faturamento Total das categorias agrupados pelo Ano da tabela tb_vendas */
-- Obs.: mês 8 (agosto)
SELECT
Ano,
sum(case when Categoria = 'X' THEN Valor ELSE 0 END) AS X,
sum(case when Categoria = 'XT660' THEN Valor ELSE 0 END) AS XT660,
sum(case when Categoria = 'XTZ250' THEN Valor ELSE 0 END) AS XTZ250,
sum(case when Categoria = 'CB750' THEN Valor ELSE 0 END) AS CB750
FROM tb_vendas
WHERE mes <= 8 
GROUP BY Ano;

/* Faturamento agrupado pelo Ano da tabela tb_vendas*/
-- Obs.: mês 8 (agosto)
select Ano,
sum(Valor) as 'Valor Vendas'
from tb_vendas 
where mes <= 8 
group by Ano
order by Ano;

/* Quantidade de clientes agrupado por Ano da tabela tb_vendas*/
-- Obs.: mês 8 (agosto)
select
Ano,
count(distinct Cliente_ID) as 'Qtde Clientes'
from tb_vendas
where mes <= 8
group by Ano
order by Ano;


/* Exibir a Tabela Ano, Area_Comercial, Area_Hibrida, Area_Residencial, Area_Industrial,
AreaTotal e ValorVendasPotencial unido pelas juncao das tabelas tb_potencial e tb_vendas
e agrupado pelo Ano */
-- Criar tabela temporaria 02 temp02
-- Sem formatacao
create temporary table temp02(
select 
Ano, 
sum(Area_Comercial) as Area_Comercial, 
sum(Area_Hibrida) as Area_Hibrida, 
sum(Area_Residencial) as Area_Residencial, 
sum(Area_Industrial) as Area_Industrial, 
sum(Area_Comercial)+
sum(Area_Hibrida)+
sum(Area_Residencial)+
sum(Area_Industrial) as AreaTotal,
sum(ValorPotencial) as ValorVendasPotencial
from tb_potencial p
where not exists (select 1 
from tb_vendas v
where p.Cliente_ID = v.Cliente_ID
and	 p.Ano = v.Ano)
group by Ano
);

/* Exibir tabela temporaria 02 temp02 */
select *
from temp02;

/* Exibir a Tabela Ano, Area Comercial (%), Area Hibrida (%), Area Residencial (%),
Area Industrial (%), Area Total (m2), Valor Vendas Potencial (R$) unido pelas 
tabelas: tb_potencial e tb_vendas */
-- Sem formatacao
select	Ano,
Area_Comercial / AreaTotal * 100 as "Area Comercial (%)",
Area_Hibrida / AreaTotal * 100 as "Area Hibrida (%)",
Area_Residencial / AreaTotal * 100 as "Area Residencial (%)",
Area_Industrial / AreaTotal * 100 as "Area Industrial (%)",
Area_Comercial +
Area_Hibrida +
Area_Residencial +
Area_Industrial as "Area Total (m2)",
ValorVendasPotencial as "Valor Vendas Potencial (R$)"
from temp02
order by ano;

/* Exibir a Tabela Ano e Quantidade unido pelas juncoes das
 tabelas: tb_potencial e tb_vendas */
-- Criar tabela temporária 03 temp3
-- Sem formatacao
create temporary table temp03(
select p.Ano,
count(distinct Cliente_ID) as Qtde
from tb_potencial p
where not exists (select 1 
from tb_vendas v
where p.Cliente_ID = v.Cliente_ID 
and p.Ano = v.Ano )
group by p.Ano
with rollup
);

/* Exibir tabela temporaria 03 temp03 */
select * 
from temp03;

/* Ranking top 10 Cidades (ascendente) */
-- Sem formatacao
select 
Cidade, 
sum(valor) as Valor 
from tb_vendas
group by Cidade 
order by 2 desc
limit 10;

/* Ranking top 10 Cidades (descendente) */
-- Agrupar pela coluna: Cidade e Valor da tabela tb_vendas
-- Criar tabela temporária temp_cidade
-- Sem formatacao
create temporary table temp_cidade(
select *
from (
select
Cidade, 
sum(valor) as Valor 
from tb_vendas
group by Cidade 
order by 2 desc
limit 10
) x
order by 2
);

/* Exibir tabela Cidade e Valor da tabela temporaria temp_cidade */
select *
from temp_cidade;

/* Valor Total das Top 10 Cidades */
-- Sem formatacao
select
SUM(valor) as 'Valor Total'
from temp_cidade;

/* Quantidade das Cidades */
-- Sem formatacao
select 
count(distinct cidade) as 'Qtde cidade'
from tb_vendas;

/* Percentual das Quantidades das Top 10 Cidades */
-- Sem formatacao
set @total_top10 =
(select
SUM(Valor)
from temp_cidade);
select 
((@total_top10 / sum(valor)) * 100)  as pct_top10
from tb_vendas;

/* Quantidade das Transacoes realizadas das top 10 cidades */
-- Sem formatacao
select
count(distinct Cliente_ID) as 'Qtde transacoes'
from tb_vendas
where cidade in (select cidade from temp_cidade);

/* Quantidade Total das Transacoes realizadas de todas as Cidades */
select 
count(Cliente_ID) as 'Total transacoes'
from tb_vendas;

/* Exibir a Tabela Cliente_ID e Produto da tabela tb_venda */
-- Obs.: Clientes que consomem apenas 1 produto
create temporary table temp_produto(
select	Cliente_ID,
Produto
from tb_vendas
group by Produto,
Cliente_ID
);

/* Consultar a tabela temporaria temp_produto */
select *
from temp_produto;

/* Grafico de rosca */
-- Exibir o valor total de cada categoria
-- Sem formatacao
select
Categoria,
sum(Valor) as Valor
from (
select
Cliente_ID, 
count(Cliente_ID) as Qtde 
from temp_produto 
group by Cliente_ID 
having count(Cliente_ID) = 1 ) as temp
inner join tb_vendas v
on temp.Cliente_ID = v.Cliente_ID
group by Categoria
order by 1;

/*Exibir a Tabela Cliente_ID, Produto comprado em uma unica vez e a Quantidade da tabela temporária temp_produto */ 
-- Criar tabela temporaria temp_cliente
create temporary table temp_cliente
select
Cliente_ID,
Produto,
count(Cliente_ID) as Qtde
from temp_produto
group by Cliente_ID
having count(Cliente_ID) = 1;

/* Consultar tabela temporaria temp_cliente */
select * from temp_cliente;

/*Exibir a Tabela Produto comprado em uma unica vez e a Quantidade da tabela temporária temp_cliente */ 
select
Produto,
count(Cliente_ID) as Qtde
from temp_cliente
group by Cliente_ID
having count(Cliente_ID) = 1;

/* Contagem de numero de registros da tabela temporaria temp_cliente */
select
count(Qtde) as Qtde
from temp_cliente;

/* Valor Transacionado Total - Juncao da tabela temp_produto e tb_vendas */
-- Sem formatacao
select 
sum(Valor) as Valor
from (select Cliente_ID,
count(Cliente_ID) as Qtde
from temp_produto
group by Cliente_ID
having count(Cliente_ID) = 1) as x
inner join tb_vendas b
on x.Cliente_ID = b.Cliente_ID;

/* Exibir a Tabela Produto comprado em uma unica vez com a junção da tabela temporária temp_produto e tb_vendas */
select distinct Produto
from (select Cliente_ID, 
count(Cliente_ID) as Qtde 
from temp_produto
group by Cliente_ID 
having count(Cliente_ID) = 1 ) as temp
inner join tb_vendas v
on temp.Cliente_ID = v.Cliente_ID;

/*Exibir a Tabela Produto comprado em uma unica vez e a Quantidade da tabela temporária temp_produto */ 
-- Criar tabela temporaria temp_produto_unico
create temporary table temp_produto_unico
select distinct Produto,
count(Cliente_ID) as Qtde
from temp_produto
group by Cliente_ID
having count(Cliente_ID) = 1;

/* Consultar tabela temp_produto_unico */
select * from temp_produto_unico;

/* Contagem de registros da tabela temporaria temp_produto_unico */
select
count(Qtde) as Qtde
from temp_produto_unico;

/* Exibir a Tabela com Cliente_ID, Ano, Area_Comercial, Area_Hibrida, Area_Residencial,
Area_Industrial, Valor Potencial e Valor Vendas das vendas convertidas e vendas nao
 convertidas) */
-- Criar View
-- Sem formatacao
create view vw_Potencial
as
select
p.Cliente_ID, 
p.Ano,
p.Area_Comercial,
p.Area_Hibrida,
p.Area_Residencial,
p.Area_Industrial,
ValorPotencial as 'Valor Potencial',
sum(valor) as 'Valor Vendas'
FROM tb_potencial p
LEFT JOIN tb_vendas v
ON p.Cliente_ID = v.Cliente_ID
AND	p.Ano = v.Ano
GROUP BY p.Cliente_ID, 
p.Ano,
p.Area_Comercial,
p.Area_Hibrida,
p.Area_Residencial,
p.Area_Industrial, 
ValorPotencial;

/* Consultar a view*/
select * from vw_Potencial;
