create database concessionaria;

use concessionaria;

create table carros 
(
	id integer primary key,
    nome varchar(100),
    descricao varchar(200),
    preco numeric,
    categoria varchar(50),
    quantidade_estoque integer
);

create table clientes
(
	id integer primary key,
    nome varchar(100),
    cpf bigint(11),
    endereco varchar(200),
    telefone bigint(11),
    email varchar(100)
);

create table compras
(
	id integer primary key,
    cliente_id integer,
    data_compra date,
    total_compra integer,
    
    foreign key(cliente_id) references clientes(id)
    
);

create table carros_compra
(
	id integer primary key,
    compra_id integer,
    carro_id integer,
    quantidade integer,
    subtotal numeric,
    
    foreign key(compra_id) references compras(id),
    foreign key(carro_id) references carros(id)
    
);

create table estoque
(
	id integer primary key,
    carro_id integer,
    quantidade_estoque integer,
    
    foreign key(carro_id) references carros(id)
);

insert into carros (id, nome, descricao, preco, categoria, quantidade_estoque) values
(1, "Jeep Renegade", "Carro 4 portas, cinza", 179999.99, "SUV", 10),
(2, "Ferrari Spider", "Carro vermelho, 2 portas", 3100000.60, "Esportivo", 2),
(3, "X1 BMW", "Carro seminovo, na cor preta", 129999.90, "SUV", 1);

insert into clientes (id, nome, cpf, endereco, telefone, email) values
(1, "Robert Downey Junior", 76521398711, "Rua Richman 777", 17677623452, "rob_downey@gmail.com"),
(2, "Taylor Swift", 31313131313, "Cornelia Street", 11313131313, "taylorswift13@tsmail.com"),
(3, "Gabriela Fernandes", 12345678910, "Lá na aldeia", 11197287087, "gabfernandes@hotmail.com");

insert into compras (id, cliente_id, data_compra, total_compra) values
(1, 1, "2023-08-4", 179999.99),
(2, 2, "1989-12-13", 3100000.60),
(3, 3, "2006-08-08", 129999.90);

insert into carros_compra (id, compra_id, carro_id, quantidade, subtotal) values
(1, 1, 1, 5, 899999.95),
(2, 2, 2, 2, 6200001.2),
(3, 3, 3, 1, 129999.90);

insert into estoque (id, carro_id, quantidade_estoque) values
(1, 1, 10),
(2, 2, 2),
(3, 3, 1);

-- 1.  Escreva uma consulta para listar todos os carros disponíveis na loja.

	select * from carros; 

-- 2.  Recupere os detalhes de um carro específico usando seu ID.

	select * from carros where id=1;

-- 3.  Mostre o nome, o CPF e o e-mail de todos os clientes cadastrados.

	select nome, cpf, email from clientes;

-- 4.  Recupere os detalhes de uma compra específica, incluindo o nome do cliente, a data da compra e o total.

	select nome, data_compra, total_compra from clientes inner join compras on clientes.id = compras.cliente_id where compras.id = 2; 

-- 5.  Liste os carros que estão em estoque, juntamente com a quantidade disponível.

	select nome, quantidade_estoque from carros where quantidade_estoque > 0;

-- 6.  Crie uma consulta para mostrar os clientes que compraram um determinado carro (usando o ID do carro).

	select clientes.nome from clientes inner join compras on clientes.id = compras.cliente_id inner join carros_compra on compras.id = carros_compra.compra_id where carros_compra.carro_id > 0 ;
    
    -- carros -> carros_compra -> compras -> cliente

-- 7.  Exiba o total de cada compra, juntamente com os nomes dos carros comprados, para um cliente específico.

	-- select total_compra, carro.nome;

-- 8.  Mostre os carros que foram comprados em uma determinada data.

select nome from carros inner join compras on carros.id = compras.id where data_compra = "1989-12-13";

-- 9.  Recupere o total de vendas de cada cliente (nome e total) em ordem decrescente.

-- 10.  Exiba o nome do cliente que fez a compra mais cara até o momento.

-- 11.  Crie uma consulta para calcular a quantidade total de carros em estoque.
	
   select sum(quantidade_estoque) from estoque;

-- 12.  Liste as compras feitas por um cliente específico, incluindo a data da compra e o total.

-- 13.  Mostre os carros que nunca foram comprados.

-- 14.  Mostre os clientes que ainda não fizeram nenhuma compra.



