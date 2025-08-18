use sistema_vendas;

-- consultas para analisar a performance do índice
-- explain
-- select nome from produtos
-- where nome = 'Barra de Cereal';

-- select sql_no_cache nome 
-- from produtos
-- where nome = 'Barra de Cereal';

create index indice_nome_produto
on produtos(nome);

