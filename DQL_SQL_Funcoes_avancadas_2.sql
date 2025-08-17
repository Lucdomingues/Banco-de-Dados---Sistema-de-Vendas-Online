-- Seleciona o banco de dados
USE sistema_vendas;

---------------------------------------------------------------
-- 1) INNER JOIN
-- Mostra apenas os clientes que realmente compraram algo.
-- Retorna: Cliente, Produto e Quantidade comprada.
---------------------------------------------------------------
SELECT u.nome AS `Cliente`,
       pr.nome AS `Produto`,
       i.quantidade
FROM itens_pedidos AS i
INNER JOIN produtos AS pr
    ON i.produto_id = pr.id
INNER JOIN pedidos AS p
    ON i.pedido_id = p.id
INNER JOIN usuarios AS u
    ON p.usuario_id = u.id;

---------------------------------------------------------------
-- 2) LEFT JOIN
-- Lista todos os clientes, mesmo que não tenham comprado nada.
-- Se o cliente não tem compras, Produto aparecerá como NULL.
---------------------------------------------------------------
SELECT u.nome AS `Cliente`,
       pr.nome AS `Produto`
FROM itens_pedidos AS i
LEFT JOIN produtos AS pr
    ON i.produto_id = pr.id
LEFT JOIN pedidos AS p
    ON i.pedido_id = p.id
LEFT JOIN usuarios AS u
    ON p.usuario_id = u.id;

---------------------------------------------------------------
-- 3) RIGHT JOIN
-- Lista todos os produtos, mesmo que não tenham sido comprados.
-- Se nenhum cliente comprou, Cliente aparecerá como NULL.
---------------------------------------------------------------
SELECT pr.nome AS `Produto`,
       u.nome AS `Cliente`
FROM itens_pedidos AS i
RIGHT JOIN produtos AS pr
    ON i.produto_id = pr.id
RIGHT JOIN pedidos AS p
    ON i.pedido_id = p.id
RIGHT JOIN usuarios AS u
    ON p.usuario_id = u.id;

---------------------------------------------------------------
-- 4) SUBQUERY (Produto mais caro)
-- Mostra os clientes que compraram o produto mais caro da tabela.
-- A subquery busca o ID do produto mais caro, dentro da subquery,
-- temos outra subquery aninhada buscando pelo produto mais caro
-- e o SELECT principal retorna os clientes que compraram esse produto.
---------------------------------------------------------------
SELECT u.nome AS `Cliente/Produto Mais Caros`
FROM itens_pedidos AS i
JOIN pedidos AS p
    ON i.pedido_id = p.id
JOIN usuarios AS u
    ON p.usuario_id = u.id
WHERE i.produto_id in(
    SELECT id
    FROM produtos
    where preco = (
    select max(preco) from produtos
    )
);
