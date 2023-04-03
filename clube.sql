DROP DATABASE IF EXISTS clube;
CREATE DATABASE clube;
USE clube;

DROP TABLE IF EXISTS pessoa;
CREATE TABLE pessoa (
  id_pessoa int(10) unsigned NOT NULL,
  id_dependente int(10) unsigned null,
  nome varchar(200) NOT NULL,
  rg varchar(30) NOT NULL,
  cpf varchar(14) NOT NULL,
  est_civil varchar(20) NOT NULL,
  sexo varchar(20) NOT NULL,
  dt_nascimento date NOT NULL,
  rua varchar(50) NOT NULL,
  bairro varchar(50) NOT NULL,
  cep varchar(9) NOT NULL,
  cidade varchar(50) NOT NULL,
  uf varchar(2) NOT NULL,
  telefone varchar(25) NOT NULL,
  dt_admissao date NOT NULL,
  foto longblob,
  PRIMARY KEY  (id_pessoa)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `socio`;
CREATE TABLE `socio` (
  `id_socio` int(10) unsigned NOT NULL auto_increment,
  `id_pessoa` int(10) unsigned NOT NULL,
  `local_trab` varchar(100) default NULL,
  `rua_trab` varchar(50) default NULL,
  `bairro_trab` varchar(50) default NULL,
  `cep_trab` varchar(11) default NULL,
  `cidade_trab` varchar(50) default NULL,
  `uf_trab` varchar(2) default NULL,
  `telefone_trab` varchar(25) default NULL,
  `cargo` varchar(100) default NULL,
  `quant_convite` int(10) unsigned NOT NULL,
  `dt_ini_emissao` date NOT NULL,
  `email` varchar(200) NULL,
  PRIMARY KEY  (`id_socio`),
  KEY `fk_socio_pessoa` (`id_pessoa`),
  CONSTRAINT `fk_socio_pessoa` FOREIGN KEY (`id_pessoa`) REFERENCES `pessoa` (`id_pessoa`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `ambiente`;
CREATE TABLE `ambiente` (
  `id_ambiente` int(10) unsigned NOT NULL auto_increment,
  `nome_dep` varchar(100) NOT NULL,
  `tipo_dep` varchar(15) NOT NULL,
  `preco_dep` float default NULL,
  PRIMARY KEY  (`id_ambiente`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `modalidade`;
CREATE TABLE `modalidade` (
  `id_modalidade` int(10) unsigned NOT NULL auto_increment,
  `nome_mod` varchar(50) NOT NULL,
  `preco_mod` float NOT NULL,
  PRIMARY KEY  (`id_modalidade`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `material`;
CREATE TABLE `material` (
  `id_material` int(10) unsigned NOT NULL auto_increment,
  `nome_mat` varchar(100) NOT NULL,
  `qtd_total` integer(4) NOT NULL,
  `qtd_disponivel` integer(4) NOT NULL,
  PRIMARY KEY  (`id_material`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `convite`;
CREATE TABLE `convite` (
  `id_convite` int(10) unsigned NOT NULL auto_increment,
  `data_cadastro` date NOT NULL,
  `id_socio` int(10) unsigned NOT NULL,
  `data_uso` date default NULL,
  PRIMARY KEY  (`id_convite`),
  KEY `fk_convite_socio` (`id_socio`),
  CONSTRAINT `fk_convite_socio` FOREIGN KEY (`id_socio`) REFERENCES `socio` (`id_socio`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `dependente`;
CREATE TABLE `dependente` (
  `id_dependente` int(10) unsigned NOT NULL auto_increment,
  `id_pessoa` int(10) unsigned NOT NULL,
  `id_socio` int(10) unsigned NOT NULL,
  `parentesco` varchar(50) default NULL,
  PRIMARY KEY  (`id_dependente`),
  KEY `fk_dependente_socio` (`id_socio`),
  KEY `fk_dependente_pessoa` (`id_pessoa`),
  CONSTRAINT `FK_dependente_pessoa` FOREIGN KEY (`id_pessoa`) REFERENCES `pessoa` (`id_pessoa`) ON DELETE CASCADE,
  CONSTRAINT `FK_dependente_socio` FOREIGN KEY (`id_socio`) REFERENCES `socio` (`id_socio`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

 
DROP TABLE IF EXISTS `funcionario`;
CREATE TABLE `funcionario` (
  `id_funcionario` int(10) unsigned NOT NULL auto_increment,
  `id_modalidade` int(10) unsigned default NULL,
  `id_pessoa` int(10) unsigned NOT NULL,
  `tipo_func` varchar(40) NOT NULL,
  PRIMARY KEY  (`id_funcionario`),
  KEY `fk_funcionario_pessoa` (`id_pessoa`),
  KEY `fk_funcionario_modalidade` USING BTREE (`id_modalidade`),
  CONSTRAINT `fk_funcionario_modalidade` FOREIGN KEY (`id_modalidade`) REFERENCES `modalidade` (`id_modalidade`) ON DELETE CASCADE,
  CONSTRAINT `fk_funcionario_pessoa` FOREIGN KEY (`id_pessoa`) REFERENCES `pessoa` (`id_pessoa`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `horario`;
CREATE TABLE `horario` (
  `id_horario` int(10) unsigned NOT NULL ,
  `id_modalidade` int(10) unsigned NOT NULL,
  `hora` time NOT NULL,
  `vagas` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`id_horario`),
  KEY `FK_horario_modalidade` (`id_modalidade`),
  CONSTRAINT `fk_horario_modalidade` FOREIGN KEY (`id_modalidade`) REFERENCES `modalidade` (`id_modalidade`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `login`;
CREATE TABLE `login` (
  `id_login` int(10) unsigned NOT NULL auto_increment,
  `id_pessoa` int(10) unsigned NOT NULL,
  `apelido` varchar(20) NOT NULL,
  `senha` varchar(20) NOT NULL,
  PRIMARY KEY  (`id_login`),
  KEY `fk_login_pessoa` (`id_pessoa`),
  CONSTRAINT `fk_login_pessoa` FOREIGN KEY (`id_pessoa`) REFERENCES `pessoa` (`id_pessoa`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `matricula`;
CREATE TABLE `matricula` (
  `id_matricula` int(10) unsigned NOT NULL auto_increment,
  `id_funcionario` int(10) unsigned NOT NULL,
  `id_pessoa` int(10) unsigned NOT NULL,
  `id_horario` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`id_matricula`),
  KEY `FK_matricula_pessoa` (`id_pessoa`),
  KEY `fk_matricula_funcionario` USING BTREE (`id_funcionario`),
  KEY `FK_matricula_horario` (`id_horario`),
  CONSTRAINT `fk_matricula_funcionario` FOREIGN KEY (`id_funcionario`) REFERENCES `funcionario` (`id_funcionario`) ON DELETE CASCADE,
  CONSTRAINT `FK_matricula_horario` FOREIGN KEY (`id_horario`) REFERENCES `horario` (`id_horario`) ON DELETE CASCADE,
  CONSTRAINT `fk_matricula_pessoa` FOREIGN KEY (`id_pessoa`) REFERENCES `pessoa` (`id_pessoa`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `mensalidade`;
CREATE TABLE `mensalidade` (
  `id_mensalidade` int(10) unsigned NOT NULL auto_increment,
  `id_socio` int(10) unsigned NOT NULL,
  `dt_vencimento` date NOT NULL,
  `dt_pagamento` date default NULL,
  `tipo` varchar(30) NOT NULL,
  `valor` float NOT NULL,
  PRIMARY KEY  (`id_mensalidade`),
  KEY `fk_mensalidade_socio` (`id_socio`),
  CONSTRAINT `fk_mensalidade_socio` FOREIGN KEY (`id_socio`) REFERENCES `socio` (`id_socio`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



DROP TABLE IF EXISTS `reserva`;
CREATE TABLE `reserva` (
  `id_reserva` int(10) unsigned NOT NULL auto_increment,
  `id_ambiente` int(10) unsigned NOT NULL,
  `id_socio` int(10) unsigned NOT NULL,
  `dt_reservada` date NOT NULL,
  `situacao` varchar(40) NOT NULL,
  `valor` float default NULL,
  `hora_reservada` time NOT NULL,
  PRIMARY KEY  (`id_reserva`),
  KEY `fk_reserva_ambiente` (`id_ambiente`),
  CONSTRAINT `fk_reserva_ambiente` FOREIGN KEY (`id_ambiente`) REFERENCES `ambiente` (`id_ambiente`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `modalidade` (`id_modalidade`,`nome_mod`,`preco_mod`) VALUES 
 (2,'Musculacao',50),
 (3,'Ginastica',100),
 (4,'Natacao',120),
 (5,'Mensalidade',100);
 
INSERT INTO `ambiente` (`id_ambiente`,`nome_dep`,`tipo_dep`,`preco_dep`) VALUES 
 (1,'Campo de Tênis A','LIVRE',NULL),
 (2,'Campo de Tênis B','LIVRE',NULL),
 (3,'Campo de Tênis C','LIVRE',NULL),
 (4,'Piscina Adulta A','LIVRE',NULL),
 (5,'Piscina Adulta B','LIVRE',NULL),
 (6,'Piscina Infantil A','LIVRE',NULL),
 (7,'Piscina Infantil B','LIVRE',NULL),
 (8,'Mesa de Bilhar A','SEM ONUS',NULL),
 (9,'Mesa de Bilhar B','SEM ONUS',NULL),
 (10,'Mesa de Bilhar C','SEM ONUS',NULL),
 (11,'Mesa de Tênis A','SEM ONUS',NULL),
 (12,'Mesa de Tênis B','SEM ONUS',NULL),
 (13,'Mesa de Pebolim A','SEM ONUS',NULL),
 (14,'Mesa de Pebolim B','SEM ONUS',NULL),
 (15,'Campo de Futebol Society A','LIVRE',NULL),
 (16,'Quadra Poliesportiva A','LIVRE',NULL),
 (17,'Quadra Poliesportiva B','LIVRE',NULL),
 (18,'Quadra de Vôlei de Areia A','LIVRE',NULL),
 (19,'Quadra de Vôlei de Areia B','LIVRE',NULL),
 (20,'Academia de Musculação e Ginástica A','LIVRE',NULL),
 (21,'Quiosque com Churrasqueira A','COM ONUS',200),
 (22,'Quiosque com Churrasqueira B','COM ONUS',200),
 (23,'Quiosque com Churrasqueira C','COM ONUS',200),
 (24,'Quiosque com Churrasqueira D','COM ONUS',200),
 (25,'Quiosque com Churrasqueira E','COM ONUS',200),
 (26,'Salão de Festa A','COM ONUS',600);

INSERT INTO `pessoa` (`id_pessoa`,`nome`,`rg`,`cpf`,`est_civil`,`sexo`,`dt_nascimento`,`rua`,`bairro`,`cep`,`cidade`,`uf`,`telefone`,`dt_admissao`,`foto`) VALUES 
(1,'Administrador do Sistema','0','000.000.000-00','Solteiro(a)','Masculino','2008-06-20','0','0','00000-000','Palmas','TO','(00)0000-0000','2008-06-20',NULL),
(2,'Vitor Mendes Vilas Boas','729.843','695.128.501-25','Casado(a)','Masculino','1988-02-12','1004 Sul','Centro','77023-514','Palmas','TO','(63)3217-1258','2008-07-03',NULL);
 
INSERT INTO `funcionario` (`id_funcionario`,`id_modalidade`,`id_pessoa`,`tipo_func`) VALUES (1,NULL,1,'Administrativo Root');

INSERT INTO `socio` (`id_socio`,`id_pessoa`,`local_trab`,`rua_trab`,`bairro_trab`,`cep_trab`,`cidade_trab`,`uf_trab`,`telefone_trab`,`cargo`,`quant_convite`,`dt_ini_emissao`,`email`) VALUES 
(1,2,'TRE','Av. Theotonio Segurado','Centro','77000-000','Palmas','TO','(63)3218-6481','Estagiário','10','2008-07-03','clubevidaesaude@uol.com.br');
 
INSERT INTO `login` (`id_login`,`id_pessoa`,`apelido`,`senha`) VALUES (1,1,'admin','admin'),(2,2,'socio','socio');


alter table pessoa add constraint fk_pessoa_dependente
foreign key (id_dependente) references dependente (id_dependente) on delete cascade;

DELIMITER $
create trigger trg_dependente after insert ON dependente
for EACH row
begin
  update pessoa set id_dependente = new.id_dependente where id_pessoa = new.id_pessoa;
end;

$ DELIMITER

DELIMITER $
CREATE TRIGGER trg_convites after update on convite
  FOR each row
  begin
    update socio set quant_convite = quant_convite -1 where id_socio = old.id_socio;
	end;

$ DELIMITER;

DELIMITER $

CREATE TRIGGER trg_vagas after insert on matricula
  FOR EACH ROW begin
    update horario set vagas = vagas -1 where id_horario = new.id_horario;
	end;

$ DELIMITER;

DELIMITER $

CREATE TRIGGER trg_vagas_soma after delete on matricula
  FOR EACH ROW begin
    update horario set vagas = vagas +1 where id_horario = old.id_horario;
	end;

$ DELIMITER;