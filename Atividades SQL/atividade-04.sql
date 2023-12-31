create database escola_sql_ryan;

use escola_sql_ryan;

create table alunos
(
	ALUNO_ID integer primary key,
	NOME varchar(255),
	DATA_NASCIMENTO date,
	ENDERECO varchar(255),
	TELEFONE varchar(15)
);

create table professores
(
	PROFESSOR_ID integer primary key,
	NOME varchar(255),
	DATA_CONTRATACAO date
);

create table disciplinas
(
	DISCIPLINA_ID integer primary key,
	NOME_DISCIPLINA varchar(255),
	CODIGO_DISCIPLINA varchar(10),
	CARGA_HORARIA integer
);

create table turmas
(
	TURMA_ID integer primary key,
	ANO_ESCOLAR integer,
	DISCIPLINA_ID integer,
	PROFESSOR_ID integer,

	foreign key (DISCIPLINA_ID) references disciplinas(DISCIPLINA_ID),
    foreign key (PROFESSOR_ID)  references professores(PROFESSOR_ID)
    
);

create table notas
(
	NOTA_ID integer primary key,
	ALUNO_ID integer,
	DISCIPLINA_ID integer,
	DATA_AVALIACAO date,
	NOTA float,
    
    foreign key (ALUNO_ID) references alunos(ALUNO_ID),
    foreign key (DISCIPLINA_ID) references disciplinas(DISCIPLINA_ID)
    
);

create table presenca
(
	PRESENCA_ID integer primary key,
	ALUNO_ID integer,
	TURMA_ID integer,
	DATA_AULA date,
	PRESENCA varchar(8),

	foreign key (ALUNO_ID) references alunos(ALUNO_ID),
    foreign key (TURMA_ID) references turmas(TURMA_ID)
    
);

INSERT INTO alunos (aluno_id, nome, data_nascimento, endereco, telefone) VALUES
	 (1, 'João Silva', '1995-03-15', 'Rua A, 123', '(11) 1234-5678'),
	 (2, 'Maria Santos', '1998-06-22', 'Av. B, 456', '(11) 9876-5432'),
	 (3, 'Carlos Oliveira', '1997-01-10', 'Rua C, 789', '(11) 5678-1234'),
	 (4, 'Ana Pereira', '1999-09-05', 'Av. D, 987', '(11) 4321-8765'),
	 (5, 'Pedro Rodrigues', '1996-07-18', 'Rua E, 654', '(11) 3456-7890'),
	 (6, 'Sara Costa', '2000-04-30', 'Av. F, 321', '(11) 8765-4321');
 
INSERT INTO professores (professor_id, nome, data_contratacao) VALUES
	 (1, 'Ana Lima', '2010-08-15'),
	 (2, 'José Santos', '2005-04-20'),
	 (3, 'Márcio Oliveira', '2012-11-10'),
	 (4, 'Cláudia Pereira', '2014-03-25'),
	 (5, 'Fernanda Rodrigues', '2018-09-08'),
	 (6, 'Ricardo Costa', '2019-12-01');

INSERT INTO disciplinas (disciplina_id, nome_disciplina, codigo_disciplina, carga_horaria) VALUES
	 (1, 'Programação em C', 'PC101', 60),
	 (2, 'Banco de Dados', 'BD201', 45),
	 (3, 'Desenvolvimento Web', 'DW301', 75),
	 (4, 'Algoritmos Avançados', 'AA401', 60),
	 (5, 'Inteligência Artificial', 'IA501', 90),
	 (6, 'Segurança da Informação', 'SI601', 45);
 
INSERT INTO turmas (turma_id, ano_escolar, disciplina_id, professor_id) VALUES
	 (101, 2023, 1, 1),
	 (102, 2023, 2, 2),
	 (103, 2023, 3, 3),
	 (104, 2023, 4, 4),
	 (105, 2023, 5, 5),
	 (106, 2023, 6, 6);
 
INSERT INTO notas (nota_id, aluno_id, disciplina_id, data_avaliacao, nota) VALUES
	 (1, 1, 1, '2023-03-10', 85),
	 (2, 2, 1, '2023-03-10', 78),
	 (3, 3, 1, '2023-03-10', 92),
	 (4, 4, 2, '2023-03-15', 88),
	 (5, 5, 2, '2023-03-15', 95),
	 (6, 6, 2, '2023-03-15', 75);

INSERT INTO presenca (presenca_id, aluno_id, turma_id, data_aula, presenca) VALUES
	 (1, 1, 101, '2023-03-10', 'presente'),
	 (2, 2, 101, '2023-03-10', 'presente'),
	 (3, 3, 101, '2023-03-10', 'presente'),
	 (4, 4, 102, '2023-03-15', 'ausente'),
	 (5, 5, 102, '2023-03-15', 'presente'),
	 (6, 6, 102, '2023-03-15', 'presente');

-- Qual é o nome do professor que ministra a disciplina com código "BD201"?

	select professores.nome 
    from professores 
    join turmas on professores.professor_id = turmas.professor_id
    join disciplinas on turmas.disciplina_id = disciplinas.disciplina_id
    where codigo_disciplina = "BD201";

-- Para a disciplina com código "PC101", obtenha a lista de alunos que obtiveram notas maiores que 80. 

	select alunos.nome
    from alunos 
    join notas on alunos.aluno_id = notas.aluno_id
    join disciplinas on notas.disciplina_id = disciplinas.disciplina_id
    where codigo_disciplina = "PC101" and notas.nota > 80;

-- Quais alunos estiveram presentes na aula da turma com ID 101 na data '2023-03-10'?

	select alunos.nome
    from alunos
    join presenca on alunos.aluno_id = presenca.aluno_id
    join turmas on presenca.turma_id = turmas.turma_id
    where turmas.turma_id = 101 and presenca.data_aula = "2023-03-10";

-- Calcule a média das notas dos alunos na disciplina com código "IA501".

	select avg(nota) as media
    from notas 
    join disciplinas on notas.disciplina_id = disciplinas.disciplina_id
    where disciplinas.codigo_disciplina = "IA501";

-- Liste todos os alunos e as disciplinas que eles estão matriculados. Inclua os alunos que não estão matriculados em nenhuma disciplina.

	select alunos.nome, disciplinas.nome_disciplina
    from alunos
    left join notas on alunos.aluno_id = notas.aluno_id
    left join disciplinas on notas.disciplina_id = disciplinas.disciplina_id;

-- Liste todos os alunos que não têm notas registradas.

	select alunos.nome 
    from alunos 
    left join notas on alunos.aluno_id = notas.aluno_id
    where notas.nota is null;

-- Quais disciplinas têm menos de 40 horas de carga horária ou mais de 100 horas de carga horária?

	select disciplinas.nome_disciplina
    from disciplinas 
    where carga_horaria < 40 or carga_horaria > 100;

-- Encontre o nome dos professores que não estão ministrando a disciplina "IA501".

	select professores.nome
    from professores
    join turmas on professores.professor_id = turmas.professor_id
    join disciplinas on turmas.disciplina_id = disciplinas.disciplina_id
    where not disciplinas.codigo_disciplina = "IA501";

-- Quais turmas não têm professores atribuídos?

	select turmas.ano_escolar
    from turmas 
    left join professores on turmas.professor_id = professores.professor_id
    where professores.professor_id is null;

-- Liste as disciplinas e seus códigos onde pelo menos um aluno obteve uma nota menor que 60.

	select disciplinas.nome_disciplina, disciplinas.codigo_disciplina 
    from disciplinas 
    join notas on disciplinas.disciplina_id = notas.disciplina_id
    where notas.nota < 60;

-- Qual é a média das notas dos alunos na disciplina com código "DW301" entre '2023-03-01' e '2023-03-31'?

	select avg(nota) as media
    from notas
    join disciplinas on notas.disciplina_id = disciplinas.disciplina_id
    where disciplinas.codigo_disciplina = "DW301"
    and notas.data_avaliacao between "2023-03-01" and "2023-03-31";

-- Liste todos os alunos que estão matriculados em mais de uma disciplina.

	select alunos.nome, count(alunos.aluno_id) as matricula
    from alunos
    join notas on alunos.aluno_id = notas.aluno_id
    join disciplinas on notas.disciplina_id = disciplinas.disciplina_id
    group by alunos.nome having matricula > 1;

-- Quais são os anos escolares distintos das turmas onde pelo menos um aluno faltou?

	select turmas.ano_escolar
    from turmas
    join presenca on turmas.turma_id = presenca.turma_id
    where presenca = "ausente";

-- Mostre o nome dos professores que estão ministrando a disciplina "PC101" ou "BD201".

	select professores.nome 
    from professores
    join turmas on professores.professor_id = turmas.professor_id
    join disciplinas as d on turmas.disciplina_id = d.disciplina_id
    where d.codigo_disciplina = "PC101" or d.codigo_disciplina = "BD201";

-- Qual é o nome do aluno que faltou em todas as aulas?

	select a.nome
    from alunos as a
    join presenca as p on a.aluno_id = p.aluno_id
    where not p.presenca = "presente";
    
-- Liste as disciplinas e seus códigos onde todos os alunos obtiveram uma nota maior ou igual a 70.

	select d.nome_disciplina, d.codigo_disciplina, min(nota) as menor_nota
    from disciplinas as d
    join notas as n on d.disciplina_id = n.disciplina_id
    group by d.nome_disciplina, d.codigo_disciplina having menor_nota >= 70;
    
-- Quais alunos obtiveram notas entre 80 e 90 na disciplina "IA501" ou "DW301"?

	select a.nome
    from alunos as a
    join notas as n on a.aluno_id = n.aluno_id
    join disciplinas as d on n.disciplina_id = d.disciplina_id
    where d.codigo_disciplina = "IA501" and n.nota between 80 and 90
    or d.codigo_disciplina = "DW201" and n.nota between 80 and 90;

-- Encontre o nome dos professores que não estão ministrando nenhuma disciplina com carga horária superior a 60 horas.

	select p.nome
    from professores as p
    join turmas as t on p.professor_id = t.professor_id
    join disciplinas as d on t.disciplina_id = d.disciplina_id
    where d.carga_horaria <= 60;

-- Quais são as datas de aulas para a disciplina com código "AA401" entre '2023-04-01' e '2023-04-30' onde pelo menos um aluno faltou?

	select p.data_aula
    from presenca as p
    join turmas as t on p.turma_id = t.turma_id
    join disciplinas as d on t.disciplina_id = d.disciplina_id
    where d.codigo_disciplina = "AA401" 
    and p.data_aula between "2023-04-01" and "2023-04-30" 
    and not p.presenca = "presente"; 

-- Liste os nomes dos alunos que não faltaram em nenhuma aula.

	select a.nome
    from alunos as a
    join presenca as p on a.aluno_id = p.aluno_id
    where not p.presenca = "ausente";