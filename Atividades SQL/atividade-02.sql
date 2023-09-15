create schema senai_04;

use  senai_04;

-- Criando tabela produtos

create table produtos
(
	id_produtos integer primary key,
	nome varchar (100),
    preco numeric
);

-- Inserindo informações na tabela produto

insert into produtos (id_produtos, nome, preco) values
(1, "Iphone 14", 5000),
(2, "Iphone 13", 4500),
(3, "Iphone 12", 4000),
(4, "Iphone 11", 2500),
(5, "Iphone X", 2100),
(6, "Galaxy S20", 3000),
(7, "LG K10", 800),
(8, "Xiaomi poco", 2800),
(9, "Nokia Tijolao", 300),
(10, "Moto v30", 6712);

-- Criando tabela pedidos

create table pedidos
(
	id_pedidos int primary key,
    id_produtos integer,
	quantidade integer,
    
	-- Criando referência para chave estrangeira
    
    foreign key(id_produtos) references produtos(id_produtos)
);

-- Inserindo informações na tabela pedidos

insert into pedidos (id_pedidos, id_produtos, quantidade) values
(1,1,280),
(2,2,400),
(3,3,80),
(4,4,71),
(5,5,15),
(6,6,28),
(7,7,33),
(8,8,39),
(9,9,47),
(10,10,29);

-- Mostrando todas informações de todas as tabelas

select * from produtos;
select * from pedidos;

-- Conectando a tabela pedidos e produtos

select nome from produtos inner join pedidos on
produtos.id_produtos=pedidos.id_produtos where id_pedidos = 4;

-- Lembrar dos alias (Apelidos) = [as]

select produtos.id_produtos, pedidos.quantidade, produtos.preco from produtos inner join pedidos on 
produtos.id_produtos=pedidos.id_produtos where nome = "Iphone X";
