use sistema_vendas;

create view view_clientes_pedidos as
select u.nome as Cliente, 
i.pedido_id as Pedido, 
p.data_criacao as 'Data', 
format(sum(i.quantidade * i.preco_unitario), 2) as 'Valor Total'
from itens_pedidos as i
join pedidos as p
on i.pedido_id = p.id
join usuarios as u
on p.usuario_id = u.id
group by Pedido;

-- Chama a view `view_clientes_pedidos`:
-- select * from view_clientes_pedidos;

delimiter $$

create procedure sp_pedidos_por_cliente (cliente_id int)
begin
select u.nome as Cliente,
p.data_criacao as 'Data do pedido',
p.status_pedido as 'Status',
format(sum(i.quantidade * i.preco_unitario), 2) as 'Valor Total'
from itens_pedidos as i
join pedidos as p
on i.pedido_id = p.id
join usuarios as u
on p.usuario_id = u.id
where p.usuario_id = cliente_id
group by i.pedido_id;
end $$

delimiter ;

-- Chamada Procedure `sp_pedidos_por_cliente`:
-- call sp_pedidos_por_cliente(1);

delimiter $$

create procedure sp_faturamento_total ()
begin
select format(sum(preco_unitario), 2) as 'Faturamento Total' 
from itens_pedidos;
end $$

delimiter ;

-- Chamada Procedure `sp_faturamento_total`:
-- call sp_faturamento_total();

delimiter $$

create function fn_valor_total_pedido(id int)
returns decimal(10, 2)
deterministic
begin
declare valor_calculado decimal(10, 2);
select sum(quantidade * preco_unitario)
into valor_calculado
from itens_pedidos
where pedido_id = id;

return valor_calculado;
end $$

delimiter ;

-- Chamada Function `fn_valor_total_pedido`:
-- select fn_valor_total_pedido(1) as 'Valor do Pedido';

delimiter $$

create function fn_qtd_pedidos_cliente(id_pedido int)
returns int
deterministic
begin
declare qtd_pedidos int;
select count(id)
into qtd_pedidos
from pedidos
where id = id_pedido;

return qtd_pedidos;
end $$

delimiter ;

-- Chamada Function `fn_qtd_pedidos_cliente`:
-- select fn_qtd_pedidos_cliente(2) as 'Qtd Pedidos';

delimiter $$

create trigger tr_update_estoque
after insert
on itens_pedidos
for each row
begin
update produtos
set estoque = estoque - new.quantidade
where id = new.produto_id;
end $$

delimiter ;

-- Inserindo um novo item no pedido, automaticamente a trigger diminuirá o valor em estoque
-- INSERT INTO itens_pedidos (produto_id, pedido_id, quantidade, preco_unitario)
-- VALUES (1, 6, 3, 1999.00);

-- select * from produtos;
-- select * from itens_pedidos;

-- criação da tabela de auditoria para a trigger de cancelamento 
-- create table log_cancelamentos(
-- id int primary key auto_increment,
-- pedido_id int not null,
-- data_cancelamento timestamp not null default current_timestamp,
-- constraint fk_pedido foreign key (pedido_id) references pedidos(id)
-- )

delimiter $$ 

create trigger tr_log_pedidos_cancelados
after update 
on pedidos
for each row 
begin
if new.status_pedido = 'cancelado' then -- then indica quais comandos vão ser executado, caso seja true
insert into log_cancelamentos (pedido_id)
values (old.id);
end if;
end $$

delimiter ;

-- Alterando o status do pedido 2 para cancelado, para testar se a trigger 
-- está enviando as infos para a tabela de auditoria
-- update pedidos
-- set status_pedido = 'cancelado'
-- where id = 2;

-- select * from log_cancelamentos;
