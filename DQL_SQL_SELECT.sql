USE sistema_vendas;

-- Listando todos os produtos com seu respectivo: id, nome, preco, estoque
SELECT id, nome, preco, estoque 
FROM produtos;

-- Listando todos os pedidos com status 'pago'
SELECT * 
FROM pedidos
WHERE status_pedido = 'pago';

-- Listando produtos com estoque menor que 10
SELECT * 
FROM produtos
WHERE estoque < 10;

-- Listando produtos do mais caro para o mais barato
SELECT * 
FROM produtos
ORDER BY preco DESC;

-- Listando o usuário com cadastro mais recente
SELECT * 
FROM usuarios
ORDER BY data_cadastro DESC
LIMIT 1;

-- Listando os 3 usuários com cadastro mais recente
SELECT * 
FROM usuarios
ORDER BY data_cadastro DESC 
LIMIT 3;

-- Listando os 3 produtos mais baratos
SELECT * 
FROM produtos
ORDER BY preco ASC 
LIMIT 3;

-- Listando todos os e-mails terminando em @gmail.com
SELECT * 
FROM usuarios
WHERE email LIKE '%@gmail.com';

-- Listando todos os produtos com preço entre 50 e 1000
SELECT * 
FROM produtos
WHERE preco BETWEEN 50 AND 1000;
