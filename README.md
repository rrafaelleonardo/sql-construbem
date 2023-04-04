# SQL - Construbem

## Contexto
A hipotética corporação "ConstruBem" precisa encontrar informações estratégicas para impulsionar as vendas e manter os clientes, assim, ela tem dados internos em seus sistemas.
As vendas de itens nas categorias X, XT660, XTZ250, e CB750 precisam aumentar.


## Objetivo
Encontrar maneiras de aumentar a receita e reduzir o atrito do cliente. Você obterá dois bancos de dados para conseguir isto (potencial por cliente, e vendas de 2020 a 2022).


 Desafios importantes:
- __Prospecção:__ chances de atrair novos clientes - Determinar quais clientes têm mais potencial para comprar.
- __Aumentar a receita dos clientes atuais:__ Procurar possibilidades de introduzir novos itens e vender mais do mesmo produto.
- __Perda de clientes:__ Prevenir a perda de clientes.


## Tarefas:

Entender o nível de qualidade e consistência dos dados – campos missings, tipo de dados, etc.
1.	Importar os dados para o MySQL;
2.	Processar dados e criar um resumo da quantidade;
3.	Iniciar as análises T-SQL com gráficos no Power Point; e
4.	Adicionar mais complexidade às análises através da criação de um relatório no Power BI Desktop.


## Mapa de Dados

### Vendas em Potencial

•	**Client ID:** ID único de cada cliente

•	**Area:** área construída por ano, em metro quadrado. 

•	**Year:** ano

•	**BRL_Potencial:** estimativa de potencial máximo de vendas por cliente.


### Vendas

•	**Client ID:** ID único de cada cliente

•	**Categoria:** categorias de produto. 

•	**Subcategoria:** indica as subcategorias de produto. São 10 ao todo. Cada subcategoria pertence a apenas uma categoria.

•	**Produto:** produto específico sendo vendido para o cliente na transação específica.

•	**Year:** ano

•	**Month:** mês

•	**Cidade:** cidade do cliente

•	**Valor:** valor de vendas realizadas. 

•	**Volume:** volume do produto vendido (pode ser kg ou litros).
