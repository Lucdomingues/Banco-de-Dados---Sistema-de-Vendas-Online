### DOCUMENTAÇÃO
# **Sistemas de Vendas Online**
---------------
# Sumário

 - [Glossário de Siglas](#glossário-de-siglas)
- [Objetivo](#objetivo)
- [Regras de Negócio e Análise de Requisitos](#regras-de-negócio-e-análise-de-requisitos)
- [Usuários](#usuários)
- [Produtos](#produtos)
- [Categorias](#categorias)
- [Pedidos](#pedidos)
- [Pagamentos](#pagamentos)
- [Modelo Conceitual](#modelo-conceitual)
- [Modelo Lógico](#modelo-lógico)
- [Modelo Físico](#modelo-físico)
- [DDL - Definição do Banco e Tabelas](#ddl---para-a-definição-do-db-e-tabelas)
- [DML - Povoamento das Tabelas](#dml---para-a-manipulação-de-toda-a-informação-povoamento-das-tabelas)
- [DQL - Consultas Básicas](#dql---para-consultas-básicas)
- [DQL - Consultas Intermediárias](#dql---para-consultas-intermediárias)
- [DQL - Consultas com JOINs e Subqueries](#dql---consultas-com-joins-e-subqueries)
- [Automação do Banco de Dados](#automação-do-banco-de-dados)
  - [View](#view)
  - [Stored Procedures](#stored-procedures)
  - [Functions](#functions)
  - [Trigger](#trigger)
- [Performance do Banco de Dados](#performance-do-banco-de-dados)

### **Glossário de siglas**
- **DDL:** Linguagem de Definição de Dados;
- **DML:** Linguagem de Manipulação de Dados;
- **DCL:** Linguagem de Controle de Dados;
- **DTL:** Linguagem de Transação de Dados;
- **DB:** Banco de Dados;
- **SGBD:** Sistema Gerenciador de Banco de Dados;
### **Objetivo**
Este projeto tem como finalidade a criação de uma arquitetura de um Banco de Dados Relacional, assim como, a construção e uso de comandos SQL **(DDl, DML)**.

### **Regras de Negócio e Análise de requisitos**

Será construído um **DB** para um **Sistema de Vendas Online**

### **Usuários**
- Cada usuário tem um nome, email único, senha, e data de cadastro.
- Um usuário pode ter vários endereços cadastrados.
- Um usuário pode fazer vários pedidos.
- Um usuário pode avaliar produtos.

### **Produtos**
- Cada produto tem nome, descrição, preço, estoque, e pertence a uma categoria.
- Produtos podem receber avaliações feitas pelos usuários (nota de 1 a 5 e comentário).

### **Categorias**
- Cada categoria pode ter vários produtos.

### **Pedidos**
- Cada pedido pertence a 1 usuário e pode conter vários produtos.
- Cada produto do pedido tem quantidade e preço do momento da compra (caso o preço mude depois).
- Cada pedido tem uma data de criação e um status: pendente, pago, cancelado, enviado, entregue.

### **Pagamentos**
- Um pagamento pertence a 1 pedido.
- Um pagamento tem forma (boleto, cartao, pix) e status (pendente, aprovado, recusado).

## **Modelo Conceitual**
![Modelo Conceitual](/DER_Sistema_de_vendas.drawio%20(1).png)

## **Modelo Lógico**
> **Observação:** O banco de dados foi criado, mesmo estando vazio, apenas para estruturarmos o modelo.
> Foi utilizado o SGBD MySQL por preferência e fins de aprendizado. No entanto, o MySQL também é uma opção bastante adequada para sistemas de vendas online, por ser amplamente utilizado no mercado.
> É excelente para onboarding, possui boa escalabilidade e atende bem a sistemas de médio e grande porte.
> **Outra opção para SGBD seria PostgreSQL**

![Modelo Lógico](modelo_logico_SVO.png)

Na criação do modelo lógico foi descoberto algumas questões que antes não tinham sido consideradas no modelo conceitual:
- Usúarios 1:N Endereços (usuarios possuem n endereços, endereços possuem apenas 1 usuário), o que pode não ser 
 interessante, pois a mesma regra serve para ambos, portanto, ajustamos a tabela no modelo lógico, tendo uma relação de N:M,
 foi implementada uma tabela associativa `Usuario_Endereco`;

## **Modelo Físico**
Na criação do Banco de dados houveram algumas mudanças:
- **Coluna** `status_pedido` da tabela `pedidos`, o tipo do dado era varchar(), porém foi substituído para `enum("pendente", "pago", "cancelado", "enviado", "entregue")`,
  garantindo a integridade do dado;
- **Coluna** `forma_pagamento` da tabela `pagamento`, o tipo do dado era varchar(), porém foi substituído para `enum("boleto", "cartao", "pix")`,
  garantindo a integridade do dado;
- **Coluna** `status_pagamento` da tabela `pagamento`, o tipo do dado era varchar(), porém foi substituído para `enum("pendente", "aprovado", "recusado")`,
  garantindo a integridade do dado;
- **Tabela** `itens_pedidos` recebeu 2 novas colunas necessárias para consultas frequentes, as colunas são `quantidade` e `preco_unitario` para ter um registro do preço no
  momento da compra
  `alter table itens_pedidos add column (
quantidade int not null default 1,
preco_unitario decimal(10, 2) not null
);`;

## **DDL - Para a definição do DB e Tabelas**
Query para a criação e definição do DB - `sistema_vendas`, e a prática do modelo físico, tivemos apenas pequenos ajustes em questão de regras, como citado logo a cima.

[Veja as Querys](https://github.com/Lucdomingues/Banco-de-Dados---Sistema-de-Vendas-Online/blob/main/DDL_SQL_CREATE.sql)

## **DML - Para a manipulação de toda a informação, povoamento das tabelas**
As querys aqui apresentadas são para o povoamento das tabelas, os dados são fictícios!
> **Observação:** Na tabela `itens_pedidos` foi adicionado duas novas colunas, que são de suma importância para um sistema de vendas, elas são, `quantidade` e `preco_unitario`
> permitindo assim o registro do valor daquele pedido no momento em que foi comprado.
> A seguinte alteração foi adicionada pelo comando:
> `alter table itens_pedidos add column (
quantidade int not null default 1,
preco_unitario decimal(10, 2) not null
);`

[Veja as Querys](https://github.com/Lucdomingues/Banco-de-Dados---Sistema-de-Vendas-Online/blob/main/DML_SQL_INSERT.sql)

## **DQL - Para consultas básicas**
Algumas querys básicas, contendo `select`, `where`, `order by`, `limit`, `like`;

O que é consultado:
- Listar produto com respectivo: id, nome, preço, estoque
- Listar pedido com status 'pago'
- Listar produto com estoque menor que 10
- Listar produto do mais caro para o mais barato
- Listar usuário com cadastro mais recente
- Listar 3 usuários com cadastro mais recente
- Listar 3 produtos mais baratos
- Listar e-mail terminando em @gmail.com
- Listar produto com preço entre 50 e 1000

[Veja as Querys](https://github.com/Lucdomingues/Banco-de-Dados---Sistema-de-Vendas-Online/blob/main/DQL_SQL_SELECT.sql)

## **DQL - Para consultas intermediárias**
Algumas querys intermediárias, contendo `join`, `group by`, `order by`, `limit`;

O que é consultado:
- Listar pedido com cliente, data e status
- Listar item de cada pedido
- Listar total por pedido
- Listar quantidade de pedido por status
- Listar faturamento total por cliente
- Listar produto mais vendido
- Listar média de preço de produto
- Listar produto mais caro
- Listar pedido mais caro

[Veja as Querys](https://github.com/Lucdomingues/Banco-de-Dados---Sistema-de-Vendas-Online/blob/main/DQL_Funcoes_avancadas.sql)

## **DQL - Consultas com JOINs e Subqueries**
Algumas querys intermediárias, contendo `inner join`, `left join`, `right join` e subquery;

O que é consultado:
- Listar clientes e os produtos que compraram (INNER JOIN)
- Listar todos os clientes e, se houver, os produtos comprados (LEFT JOIN)
- Listar todos os produtos e, se houver, os clientes que compraram (RIGHT JOIN)
- Listar o cliente que comprou o produto mais caro (Subquery com `MAX()`)

[Veja as Querys](https://github.com/Lucdomingues/Banco-de-Dados---Sistema-de-Vendas-Online/blob/main/DQL_SQL_Funcoes_avancadas_2.sql)

## **Automação do Banco de Dados**
Algumas `Views`, `Stored Procedures`, `Functions` e `Triggers`

[Veja a definição dessas funções](https://github.com/Lucdomingues/Banco-de-Dados---Sistema-de-Vendas-Online/blob/main/funcoes_otimizacao_db.sql)

### **View**
- `view_clientes_pedidos`: exibe todos os pedidos de cada cliente

Exemplo:
#### Chamando a view
 `select * from view_clientes_pedidos;`
#### Retorno
![Retorno da função view](https://github.com/Lucdomingues/Banco-de-Dados---Sistema-de-Vendas-Online/blob/main/retorno-view.png)

### **Stored Procedures**
- `sp_pedidos_por_cliente`: recebe o ID do cliente e retorna todos os pedidos desse cliente com detalhes do pedido e valor total.
- `sp_faturamento_total`: calcula e retorna o faturamento total de todos os pedidos.

Exemplo:
#### Chamando a Procedure 1
 `call sp_pedidos_por_cliente(1);`
#### Retorno
![Retorno da procedure](https://github.com/Lucdomingues/Banco-de-Dados---Sistema-de-Vendas-Online/blob/main/retorno_procedure_1.png)

Exemplo:
#### Chamando a Procedure 2
 `call sp_faturamento_total();`
#### Retorno
![Retorno da procedure](https://github.com/Lucdomingues/Banco-de-Dados---Sistema-de-Vendas-Online/blob/main/retorno_procedure_2.png)


### **Functions**
- `fn_valor_total_pedido`: recebe o ID de um pedido e retorna o valor total
- `fn_qtd_pedidos_cliente`: recebe o ID de um cliente e retorna a quantidade total de pedidos desse cliente.

Exemplo:
#### Chamando a function 1
 `select fn_valor_total_pedido(1) as 'Valor do Pedido';`
#### Retorno
![Retorno da função1](https://github.com/Lucdomingues/Banco-de-Dados---Sistema-de-Vendas-Online/blob/main/retorno-function-1.png)

Exemplo:
#### Chamando a function 2
 `select fn_qtd_pedidos_cliente(2) as 'Qtd Pedidos';`
#### Retorno
![Retorno da função2](https://github.com/Lucdomingues/Banco-de-Dados---Sistema-de-Vendas-Online/blob/main/retorno-function-2.png)


### **Trigger**
Importante para a **automação e independência** de nosso **Banco de dados**!
- `tr_update_estoque`: ao inserir um item na tabela `itens_pedidos`, diminui a quantidade correspondente no estoque do produto.
- `tr_log_pedidos_cancelados`: em um tabela de auditoria(tabela de log) para pedidos cancelados, ao cancelar um pedido essa
  informação será armazenada pela trigger na tabela `log_cancelamentos` automaticamente.


Exemplo da inserção da **Trigger** `tr_log_pedidos_cancelados`:

- Comando update:
`update pedidos
set status_pedido = 'cancelado'
where id = 2;`

- Retorno na tabela `log_cancelamentos`:

![Trigger Cancelamentos](https://github.com/Lucdomingues/Banco-de-Dados---Sistema-de-Vendas-Online/blob/main/trigger-cancelamentos.png)

## Performance do Banco de Dados

Foi criado o índice para `produtos.nome`:
Também temos índice para `produtos.email`, quando criamos a tabela, criamos a coluna email com `UNIQUE`, já formando um índice;

> **Observação**: como o volume de dados é relativamente baixo, não é tão visível a melhoria nas consultas,
> porém conseguimos ver a diferença usando `EXPLAIN`, antes passava pelas 6 linhas da tabela produtos
> agora passa pela unica linha referente ao produto consultado.

[Veja aqui as definições e consultas de performance](https://github.com/Lucdomingues/Banco-de-Dados---Sistema-de-Vendas-Online/blob/main/performance-db.sql)

- Antes sem índice:

  ![Sem Indice](https://github.com/Lucdomingues/Banco-de-Dados---Sistema-de-Vendas-Online/blob/main/no-indice.png)

- Depois com índice:

  ![Com Indice](https://github.com/Lucdomingues/Banco-de-Dados---Sistema-de-Vendas-Online/blob/main/indice-true.png)

