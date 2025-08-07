create database sistema_vendas;
use sistema_vendas;

create table usuarios(
id int primary key not null auto_increment,
nome varchar(100) not null,
email varchar(100) not null unique,
senha varchar(255) not null,
data_cadastro timestamp not null default current_timestamp # Inserção automatica de data e horas atuais
);

create table enderecos(
id int primary key not null auto_increment,
rua varchar(100) not null,
numero varchar(20) not null,
cep varchar(15) not null,
complemento varchar(100)
);

create table usuario_endereco(
id int primary key not null auto_increment,
usuario_id int not null,
endereco_id int not null,
constraint fk_usuario_endereco_1 foreign key (usuario_id) references usuarios(id),
constraint fk_usuario_endereco_2 foreign key (endereco_id) references enderecos(id)
);

create table categorias(
id int primary key not null auto_increment,
nome_categoria varchar(45) not null
);

create table produtos(
id int primary key not null auto_increment,
nome varchar(100) not null,
descricao varchar(200),
preco decimal(10, 2) unsigned not null,
estoque int unsigned not null default 0,
categoria_id int not null,
constraint fk_produtos foreign key (categoria_id) references categorias(id)
);

create table avaliacoes(
id int primary key not null auto_increment,
usuario_id int not null,
produto_id int not null,
nota int unsigned not null check (nota > 0 and nota <= 5),
comentario varchar(200),
constraint fk_avaliacoes_1 foreign key (usuario_id) references usuarios(id),
constraint fk_avaliacoes_2 foreign key (produto_id) references produtos(id)
);

create table pedidos(
id int primary key not null auto_increment,
usuario_id int not null,
data_criacao timestamp not null default current_timestamp,
status_pedido enum("pendente", "pago", "cancelado", "enviado", "entregue") not null default 'pendente',
constraint fk_pedidos foreign key (usuario_id) references usuarios(id)
);

create table itens_pedidos(
id int primary key not null auto_increment,
produto_id int not null,
pedido_id int not null,
constraint fk_itens_pedidos_1 foreign key (produto_id) references produtos(id),
constraint fk_itens_pedidos_2 foreign key (pedido_id) references pedidos(id)
);

create table pagamento(
id int primary key not null auto_increment,
forma_pagamento enum("boleto", "cartao", "pix") not null,  # Poderia ser feito assim: check(forma_pagamento in("boleto", "cartao", "pix"))
status_pagamento enum("pendente", "aprovado", "recusado") not null default "pendente",
pedido_id int not null,
constraint fk_pagamento foreign key (pedido_id) references pedidos(id)
);
