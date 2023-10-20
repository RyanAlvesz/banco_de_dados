create database cursos_sql_ryan;

use cursos_sql_ryan;

create table cursos
(
	id integer primary key not null auto_increment,
    nome_curso varchar(100) not null,
	carga_horaria integer not null,
    categoria varchar(50) not null
);

insert into cursos (nome_curso, carga_horaria, categoria) values
("Desenvolvimento de Sistemas", 1200, "Curso Técnico"),
("Eletroeletrônica", 1200, "Curso Técnico"),
("Curso de Excel", 60, "FIC");

create table disciplinas
(
	id integer primary key not null auto_increment,
	nome_disciplina varchar(100) not null,
    codigo_disciplina varchar(10) not null,
    curso_id integer,
    
    foreign key (curso_id) references cursos(id)
    
);

insert into disciplinas (nome_disciplina, codigo_disciplina, curso_id) values
("Banco de Dados", "BCD", 1),
("Programação Web Back-End", "PWBE", 1),
("Desenho Técnico", "DT", 2);

create table alunos
(
	id integer primary key not null auto_increment, 
    nome varchar(100) not null,
    cpf bigint not null,
    telefone bigint,
    data_de_nascimento date not null,
    endereco varchar(200) not null
);

insert into alunos (nome, cpf, telefone, data_de_nascimento, endereco) values
("Gabriela Fernandes", 53186706874, 11972870187, "2006-08-08", "Rua Luiz Scott"),
("Ryan Alves", 51766995837, 11986351543, "2006-08-04", "Rua Bonita"),
("Taylor Swift", 13131313131, 11913131313, "1989-12-13", "Cornelia Street");

create table professores
(
	id integer primary key not null auto_increment,
	nome varchar(100) not null,
    cpf bigint not null,
    telefone bigint,
    data_de_nascimento date not null,
    data_de_contratacao date not null,
);

insert into professores (nome, cpf, telefone, data_de_nascimento, data_de_contratacao) values
("Bruno Gomes", 99999999999, 11999999999, "1996-05-01", "2023-01-09"),
("Fernando Leonid", 10101010101, 11910101010, "1976-08-30", "1999-11-13"),
("Vitor de Jesus", 11111111111, 11911111111, "1996-03-25", "2023-01-09");

create table matriculas
(
	id integer primary key not null,
    data_matricula date not null,
    curso_id integer not null,
    aluno_id integer not null,
    
    foreign key (curso_id) references cursos(id),
    foreign key (aluno_id) references alunos(id)
    
);

insert into matriculas (id, data_matricula, curso_id, aluno_id) values 
(23111765, "2023-01-13", 1, 2),
(23111725, "2023-01-13", 1, 1),
(23111713, "2023-01-13", 2, 3);

create table turmas
(
	id integer primary key not null auto_increment,
	ano_escolar integer not null,
    disciplina_id integer,
    professor_id integer,
    codigo_turma varchar(20),
    
	foreign key (disciplina_id) references disciplinas(id),
    foreign key (professor_id) references professores(id)
    
);

insert into turmas (ano_escolar, disciplina_id, professor_id, codigo_turma) values
(2023, 1, 1, 'DS1AIT'),
(2023, 2, 3, 'DS1BIT'),
(2023, 3, 2, 'ELE1IT');

create table notas
(
	id integer primary key not null auto_increment, 
    nota float not null,
    data_avaliacao date not null,
    aluno_id integer,
    disciplina_id integer,

	foreign key (aluno_id) references alunos(id),
    foreign key (disciplina_id) references disciplinas(id)

);

insert into notas (nota, data_avaliacao, aluno_id, disciplina_id) values 
(100, "2023-10-06", 1, 1),
(100, "2023-10-06", 2, 1),
(13.13, "2023-10-06", 1, 2);

create table presencas
(
	id integer primary key not null auto_increment, 
	data_aula date not null,
    presenca varchar(8) not null,
    aluno_id integer,
    disciplina_id integer,
    
    foreign key (aluno_id) references alunos(id),
    foreign key (disciplina_id) references disciplinas(id)

);

insert into presencas (data_aula, presenca, aluno_id, disciplina_id) values
("2023-10-06", "PRESENTE", 1, 1),
("2023-10-06", "PRESENTE", 2, 2),
("2023-10-06", "AUSENTE", 2, 3);

create table eventos_academicos
(
	id integer primary key not null auto_increment, 
    data datetime not null,
    tema varchar(50) not null,
    turma_id integer,
    
    foreign key (turma_id) references turmas(id)
    
);

insert into eventos_academicos (data, tema, turma_id) values 
("2024-12-13 18:00:00", "Formatura 3° ano SESI Carapicuíba", 2),
("2024-12-20 19:00:00", "Formatura Eletroeletrônica", 3),
("2024-12-20 19:00:00", "Formatura Desenvolvimento de sistemas", 1);

create table atividades_pesquisa
(
	id integer primary key not null auto_increment, 
    tema varchar(50) not null,
    turma_id integer,
    
    foreign key (turma_id) references turmas(id)
    
);

insert into atividades_pesquisa (tema, turma_id) values 
("DER", 1),
("Array e JSON", 2),
("AUTOCAD", 3);

create table parcerias
(
	id integer primary key not null auto_increment, 
    nome_empresa varchar(100) not null,
    tipo_parceira varchar(50) not null
);

insert into parcerias (nome_empresa, tipo_parceira) values 
("Antilhas", "Estágio"),
("Puzzle Language School", "Projetos"),
("Google", "Estágio");

-- 1: seleciona o nome das disciplinas de cada curso
select disciplinas.nome_disciplina, cursos.nome_curso from disciplinas
inner join cursos on disciplinas.id=cursos.id;

-- 2: seleciona todos os alunos matriculados na turma do Professor Leonid
select alunos.nome, matriculas.data_matricula from matriculas
inner join alunos on matriculas.aluno_id=alunos.id
inner join presencas on alunos.id=presencas.aluno_id
inner join disciplinas on presencas.disciplina_id=disciplinas.id
inner join turmas on disciplinas.id=turmas.disciplina_id
inner join professores on turmas.professor_id=professores.id
where professores.nome = "Fernando Leonid";

-- 3: seleciona os eventos acadêmicos de cada curso e turma
select e.tema, cursos.nome_curso from eventos_academicos as e
inner join turmas on e.turma_id=turmas.id
inner join disciplinas on turmas.disciplina_id=disciplinas.id
inner join cursos on disciplinas.curso_id=cursos.id;

-- 4: seleciona os professores que lecionam cada disciplinas em
-- suas respectivas turmas
select professores.nome, disciplinas.codigo_disciplina, turmas.id from professores
inner join turmas on professores.id=turmas.professor_id
inner join disciplinas on turmas.disciplina_id=disciplinas.id;

-- 5: seleciona os alunos cujo nome começa com G ou que estiveram presentes 
-- na aula do dia 06-10-2023
select alunos.nome, presencas.presenca from alunos 
inner join presencas on alunos.id=presencas.aluno_id
where nome LIKE 'G%' OR presencas.presenca='PRESENTE' AND presencas.data_aula = '2023-10-06';

-- 6: seleciona a média dos alunos
select avg(notas.nota) as avg_notas from notas;

-- RELATÓRIO DO DESEMPENHO
select  matriculas.id as codigo_aluno, alunos.nome, avg(notas.nota) as media_escolar, cursos.nome_curso from notas 
inner join alunos on notas.id=alunos.id
inner join matriculas on alunos.id=matriculas.aluno_id
inner join cursos on matriculas.curso_id=cursos.id
group by alunos.nome;

-- HISTÓRICO ESCOLAR
select alunos.id, alunos.nome, cursos.nome_curso, presencas.data_aula, presencas.presenca from alunos
inner join matriculas on alunos.id=matriculas.aluno_id
join cursos on matriculas.curso_id=cursos.id
join disciplinas on cursos.id=disciplinas.curso_id
join presencas on disciplinas.id=presencas.disciplina_id
group by alunos.id order by alunos.nome;

-- AGENDA DE EVENTOS ACADÊMICOS
select turmas.codigo_turma, eventos_academicos.data_evento, eventos_academicos.tema from eventos_academicos
inner join turmas on eventos_academicos.turma_id=turmas.id;

-- REGISTRO DE FREQUÊNCIA
select alunos.nome, presencas.presenca, disciplinas.nome_disciplina, cursos.nome_curso from alunos
inner join presencas on alunos.id=presencas.aluno_id
inner join disciplinas on presencas.disciplina_id=disciplinas.id
inner join cursos on disciplinas.curso_id=cursos.id;

-- GESTÃO DE MATRÍCULAS E INSCRIÇÕES
select alunos.nome, matriculas.id as codigo_aluno, matriculas.data_matricula, cursos.nome_curso from alunos
inner join matriculas on alunos.id=matriculas.aluno_id
inner join cursos on matriculas.curso_id=cursos.id;

