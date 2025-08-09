USE sistema_vendas;

-- 1. Lista todos os pedidos com cliente, data e status
SELECT 
    p.id AS `Id do pedido`, 
    u.nome AS `Nome do cliente`,
    p.data_criacao AS `Data do pedido`,
    p.status_pedido AS `Status do pedido`
FROM pedidos AS p
JOIN usuarios AS u 
    ON p.usuario_id = u.id;

-- 2. Lista itens de cada pedido
SELECT 
    p.id AS `Id do pedido`,
    pr.nome AS `Produto`,
    i.quantidade,
    i.preco_unitario AS `Preço unitário`
FROM itens_pedidos AS i
JOIN produtos AS pr
    ON i.produto_id = pr.id
JOIN pedidos AS p
    ON i.pedido_id = p.id;

-- 3. Total por pedido
SELECT 
    u.nome AS `Cliente`,
    i.pedido_id AS `Id do pedido`,
    SUM(i.quantidade * i.preco_unitario) AS `Total`
FROM itens_pedidos AS i
JOIN pedidos AS p
    ON i.pedido_id = p.id
JOIN usuarios AS u
    ON p.usuario_id = u.id
GROUP BY u.nome, i.pedido_id;

-- 4. Quantidade de pedidos por status
SELECT 
    COUNT(id) AS `Quantidade`, 
    status_pedido AS `Status`
FROM pedidos
GROUP BY status_pedido;

-- 5. Faturamento total por cliente
SELECT 
    u.nome AS `Cliente`,
    SUM(i.quantidade * i.preco_unitario) AS `Total`
FROM itens_pedidos AS i
JOIN pedidos AS p
    ON i.pedido_id = p.id
JOIN usuarios AS u
    ON p.usuario_id = u.id
GROUP BY u.nome
ORDER BY Total DESC;

-- 6. Produto mais vendido
SELECT 
    p.nome AS `Mais vendido`, 
    SUM(i.quantidade) AS `Quantidade`
FROM itens_pedidos AS i
JOIN produtos AS p 
    ON i.produto_id = p.id
GROUP BY p.nome
ORDER BY Quantidade DESC
LIMIT 1;

-- 7. Média de preço dos produtos
SELECT 
    ROUND(AVG(preco), 2) AS `Média de preço`
FROM produtos;

-- 8. Produto mais caro
SELECT 
    nome AS `Mais caro`
FROM produtos
ORDER BY preco DESC
LIMIT 1;

-- 9. Pedido mais caro
SELECT 
    p.id AS `Pedido`,
    u.nome AS `Cliente`,
    SUM(i.quantidade * i.preco_unitario) AS `Total`
FROM itens_pedidos AS i
JOIN pedidos AS p
    ON i.pedido_id = p.id
JOIN usuarios AS u
    ON p.usuario_id = u.id
GROUP BY p.id, u.nome
ORDER BY Total DESC
LIMIT 1;
