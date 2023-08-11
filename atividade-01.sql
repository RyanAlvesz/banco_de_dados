-- Criando Banco de Dados
create schema senai_carapicuiba;

-- Colocando o nosso em uso
use senai_carapicuiba;

-- Criando Tabela
create table turmas

(
	id int primary key not null auto_increment,
	nome varchar(50) not null,
    codigo integer not null,
    descricao varchar(100) not null,
    sala varchar (15) not null
    
);

-- inserindo dados na tabela
insert into turmas (nome, codigo, descricao, sala) values
("Desenvolvimento de Sistemas", 12345, "É um ótimo curso", "B10"),
("Excel", 12121, "Já foi um bom curso", "B01"),
("Power BI", 23561, "Muito ruim", "B08"),
("Eletroeletrônica", 12135, "Modinha", "A03"),
("Banco de Dados", 55555, "Show", "B09");
 
-- Mostrando todos os dados da tabela

select * from turmas;

-- Selecionando objeto específico 
select nome, descricao from turmas where nome="Eletroeletrônica";

-- Selecionando tudo da tabela turmas onde o id é 3 
select * from turmas where id=3;

-- Mudando o nome da coluna nome onde o id é 3 da tabela turmas
update turmas set nome = "Informática Básica" where id="3";

-- Mostrando todas as colunas
select nome from turmas where id < 3;

-- Mudando o código de colunas de id's específicos
update turmas set codigo = 333333 where id = 2;
update turmas set codigo = 12120 where id = 3;

-- Adicionando nova coluna a tabela turmas, de tipo varchar, que não pode ser nulo
alter table turmas add data_inicio varchar(20) not null;

-- Removendo tupla da tabela turmas onde o id é 3
delete from turmas where id = 3;

-- Mostrando colunas código e nome da tabela turma, onde sala é AO3 e o id é maior que 2
select codigo, nome from turmas where sala="A03" and id > 2;