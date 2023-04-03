DROP DATABASE IF EXISTS escola; 
CREATE DATABASE escola DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE escola;

DROP TABLE IF EXISTS pessoa;
CREATE TABLE pessoa (
  ID_PESSOA INT(11) NOT NULL AUTO_INCREMENT,
  ID_PESSOA_ALUNO INT(11) NOT NULL,
  NOME VARCHAR(50) DEFAULT NULL,
  SOBRENOME VARCHAR(50) DEFAULT NULL,
  SEXO VARCHAR(2) DEFAULT NULL,
  TELEFONE BIGINT(20) DEFAULT NULL,
  PRIMARY KEY (ID_PESSOA), 
  CONSTRAINT FK_ID_ALUNO FOREIGN KEY (ID_PESSOA_ALUNO) REFERENCES ALUNO(ID_ALUNO) 
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

DROP TABLE IF EXISTS aluno;
CREATE TABLE aluno (
	ID_ALUNO int(10) unsigned NOT NULL AUTO_INCREMENT,
    NOME varchar(45) NOT NULL,
    CPF VARCHAR(14) DEFAULT NULL,
    TELEFONE VARCHAR(13) DEFAULT NULL,
    PRIMARY KEY (ID_ALUNO)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

DROP TABLE IF EXISTS professor;
CREATE TABLE professor (
	ID_PROFESSOR int(10) unsigned NOT NULL AUTO_INCREMENT,
    NOME varchar(45) NOT NULL,
    CPF varchar(14) DEFAULT NULL,
    TELEFONE varchar(13) DEFAULT NULL,
    PRIMARY KEY (ID_PROFESSOR)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

DROP TABLE IF EXISTS turma;
CREATE TABLE turma (
	ID_TURMA INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    ID_ALUNO_TURMA INT(10) UNSIGNED NOT NULL,
    ID_PROFESSOR_TURMA INT(10) UNSIGNED NOT NULL,
    SALA INT(11) NOT NULL,
    PRIMARY KEY (ID_TURMA),
    -- KEY FK_ALUNO_TURMA (ID_ALUNO_TURMA),
	-- KEY FK_PROFESSOR_TURMA (ID_PROFESSOR_TURMA),
    CONSTRAINT FK_ALUNO_TURMA FOREIGN KEY (ID_ALUNO_TURMA) REFERENCES ALUNO (ID_ALUNO),
    CONSTRAINT FK_PROFESSOR_TURMA FOREIGN KEY (ID_PROFESSOR_TURMA) REFERENCES PROFESSOR (ID_PROFESSOR)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

INSERT INTO PESSOA VALUES 
(1, 'Maria', 'João Azevedo', 'F', 341238441), 
(2, 'José', 'Stella Reis', 'F', 34512890);

INSERT INTO ALUNO VALUES 
(1,'JULIA S','213.333.587-52','7.132.895'), (2,'DANIEL','213.333.587-52','7.132.895'), (3,'MARIANA ','213.333.587-52','7.132.895'), (4,'WANESSA','213.333.587-52','7.132.895'), 
(5,'CARLOS','213.333.587-52','7.132.895'), (6,'RICARDO ','213.333.587-52','7.132.895'), (7,'AMANDA ','213.333.587-52','7.132.895'), (8,'RODRIG','213.333.587-52','7.132.895'), 
(9,'PATRICIA','213.333.587-52','7.132.895'), (10,'MARCELO','213.333.587-52','7.132.895'), (11,'PEDRO','213.333.587-52','7.132.895');

INSERT INTO ALUNO (ID_ALUNO, NOME, CPF, TELEFONE) VALUES (12, "DANIEL", '213.333.587-52','7.132.895');

INSERT INTO ALUNO (NOME, CPF, TELEFONE) VALUES ("VITOR", "111.111.222-48", "1.325.689");

INSERT INTO professor VALUES 
(1,'IGOR','111.111.222-48','1.325.689'), (2,'JUH','111.111.222-48','1.325.689'), (3,'LICE','111.111.222-48','1.325.689'),
(4,'PATY','111.111.222-48','1.325.689'), (5,'WANIA','111.111.222-48','1.325.689');

INSERT INTO TURMA VALUES (1,6,4,10), (2,6,5,10);

SELECT * FROM ALUNO;

DELETE FROM ALUNO WHERE ID_ALUNO = 5;