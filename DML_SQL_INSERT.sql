use sistema_vendas;

# Povoando Tabela Usuários
insert into usuarios (nome, email, senha, data_cadastro)
values ("Ana Oliveira", "ana@gmail.com", "r58jrdk5fp4GOA1", "2025-08-01 10:00:00"),
("João Silva", "joao@hotmail.com", "ykmFaNft2ZbHo7U", "2025-08-02 12:15:00"),
("Carla Souza", "carla@gmail.com", "wObcBF1bxZV6W3I", "2025-08-02 14:00:00"),
("Bruno Lima", "bruno@gmail.com", "mI4B2jGVcNEX0Uv", "2025-08-03 08:45:00"),
("Luana Mendes", "luana@outlook.com", "fqP8KL4TrbtvmW5", "2025-08-03 16:30:00");
# Povoando Tabela Endereços
insert into enderecos (rua, numero, cep, complemento)
values ("Rua das Flores", "123", "01234-000", "Apto 12"),
("Av. Brasil", "45", "04567-200", "Casa"),
("Rua João Goulart", "890", "06789-555", "Fundos"),
("Rua dos Alfeneiros", "4", "12345-678", "Próximo ao parque"),
("Av. Central", "2200", "00880-100", "Bloco B");
# Povoando Tabela Usuario_Endereço
insert into usuario_endereco (usuario_id, endereco_id)
values (1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);
# Povoando Tabela Categorias
insert into categorias (nome_categoria)
values ("Eletrônicos"),
("Roupas"),
("Livros"),
("Alimentos"),
("Móveis");
# Povoando Tabela Produtos
insert into produtos (nome, descricao, preco, estoque, categoria_id)
values ("Smartphone Samsung A54", "Tela 6.5”, 128GB", 1999.00, 10, 1),
("Camiseta Branca Algodão", "100% algodão", 49.90, 50, 2),
("Livro 'Clean Code'", "Programação limpa", 89.90, 20, 3),
("Cadeira Gamer", "Reclinável, ergonômica", 899.00, 5, 5),
("Barra de Cereal", "Sabor chocolate", 3.50, 100, 4),
("Notebook Dell i5", "8GB RAM, 256GB SSD", 3599.00, 8, 1);
# Povoando Tabela Pedidos
insert into pedidos (usuario_id, data_criacao, status_pedido)
values (1, "2025-08-04 10:30:00", "pago"),
(2, "2025-08-05 14:00:00", "pendente"),
(3, "2025-08-05 17:45:00", "cancelado"),
(4, "2025-08-06 09:00:00", "entregue"),
(5, "2025-08-06 11:30:00", "enviado");
# Adicionando 2 colunas novas para tabela itens_pedidos
alter table itens_pedidos add column (
quantidade int not null default 1,
preco_unitario decimal(10, 2) not null
);
# Povoando Tabela Itens_Pedidos
insert into itens_pedidos (produto_id, pedido_id, quantidade, preco_unitario)
values (1, 1, 1, 1999.00),
(5, 1, 3, 3.50),
(3, 2, 1, 89.90),
(2, 2, 2, 49.90),
(5, 3, 10, 3.50),
(4, 4, 1, 899.00),
(2, 4, 1, 49.90),
(6, 5, 1, 3599.00),
(3, 5, 1, 89.90);
# Povoando Tabela Pagamento
insert into pagamento (forma_pagamento, status_pagamento, pedido_id)
values("cartão", "aprovado", 1),
("pix", "pendente", 2),
("boleto", "recusado", 3),
("cartão", "aprovado", 4),
("pix", "aprovado", 5);
# Povoando Tabela Avaliações
insert into avaliacoes (usuario_id, produto_id, nota, comentario)
values (1, 1, 5, "Excelente!"),
(2, 3, 4, "Muito bom, mas complexo."),
(2, 2, 5, null),
(3, 5, 3, "Bom, mas podia ser mais doce."),
(4, 4, 5, "Confortável demais!"),
(5, 2, 4, "Tecido ótimo!");