### DOCUMENTAÇÃO
# **Sistemas de Vendas Online**
---------------
# Sumário

  - [Glossário de siglas](#glossário-de-siglas)
  - [Objetivo](#objetivo)
  - [Regras de Negócio e Análise de requisitos](#regras-de-negócio-e-análise-de-requisitos)
  - [Usuários](#usuários)
  - [Produtos](#produtos)
  - [Categorias](#categorias)
  - [Pedidos](#pedidos)
  - [Pagamentos](#pagamentos)
  - [Modelo Conceitual](#modelo-conceitual)
  - [Modelo Lógico](#modelo-lógico)

### **Glossário de siglas**
- **DDL:** Linguagem de Definição de Dados;
- **DML:** Linguagem de Manipulação de Dados;
- **DCL:** Linguagem de Controle de Dados;
- **DTL:** Linguagem de Transação de Dados;
- **DB:** Banco de Dados;
- **SGBD:** Sistema Gerenciador de Banco de Dados;
### **Objetivo**
Este projeto tem como finalidade a criação de uma arquitetura de um Banco de Dados Relacional, assim como, a construção e uso das quatro categorias de comandos SQL **(DDl, DML, DCL e TCL)**.

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
