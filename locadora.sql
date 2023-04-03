DROP DATABASE IF EXISTS locadora; 
CREATE DATABASE locadora DEFAULT CHARACTER SET utf8 ;
USE locadora;

DROP TABLE IF EXISTS carro;
CREATE TABLE carro (
  car_id int(11) NOT NULL AUTO_INCREMENT,
  car_placa char(8) DEFAULT NULL,
  car_renavan varchar(45) DEFAULT NULL,
  car_modelo varchar(100) DEFAULT NULL,
  car_ano int(4) DEFAULT NULL,
  car_marca varchar(45) DEFAULT NULL,
  car_preco double(10,2) DEFAULT NULL,
  car_categoria char(1) DEFAULT NULL,
  PRIMARY KEY (car_id)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS cliente;
CREATE TABLE cliente (
  cli_id int(11) NOT NULL AUTO_INCREMENT,
  cli_nome varchar(100) DEFAULT NULL,
  cli_cidade varchar(70) DEFAULT NULL,
  cli_sexo char(1) DEFAULT NULL,
  cli_dtnasc date DEFAULT NULL,
  cli_salario double(10,2) DEFAULT NULL,
  PRIMARY KEY (cli_id)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS locacao;
CREATE TABLE locacao (
  loc_cli_id int(11) NOT NULL,
  loc_car_id int(11) NOT NULL,
  loc_id int(11) NOT NULL AUTO_INCREMENT,
  loc_data date DEFAULT NULL,
  loc_data_entrega date DEFAULT NULL,
  PRIMARY KEY (loc_id),
  KEY fk_cliente_has_carro_carro1_idx (loc_car_id),
  KEY fk_cliente_has_carro_cliente_idx (loc_cli_id),
  CONSTRAINT fk_cliente_has_carro_carro1 FOREIGN KEY (loc_car_id) REFERENCES carro (car_id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_cliente_has_carro_cliente FOREIGN KEY (loc_cli_id) REFERENCES cliente (cli_id) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

INSERT INTO carro VALUES (1,'OXN-0134','76453890','UNO',2000,'FIAT',25000.00,'E'),(2,'JUA-2367','98900982','SANDERO',2005,'RENAULT',43000.00,'D'),(3,'ABA-8964','65234100','PALIO',2013,'FIAT',32000.00,'D'),(4,'YFR-9023','18904556','UNO',2009,'FIAT',29000.00,'E'),(5,'IJH-2056','09785433','COBALT',2012,'CHEVROLET',54000.00,'C'),(6,'TRE-7654','23456789','COROLLA',2016,'TOYOTA',78000.00,'B');
INSERT INTO cliente VALUES (1,'Marcos','Formoso do Araguaia','M',NULL,NULL),(2,'Maria','Araguatins','F',NULL,NULL),(3,'Jose','Goiania','M',NULL,NULL),(4,'Vitor','Uberlandia','M',NULL,NULL),(5,'Paulo',NULL,'M',NULL,NULL),(6,'Pedro','Araraquara','M','1990-09-12',3500.43),(7,'Julia','Coritiba','F','1997-07-05',945.56),(8,'Joao','Colinas','M','1992-03-13',2100.00),(9,'Mariana','Florianopolis','F','2000-08-22',1300.40),(10,'Thiago','Cuiaba','M','1975-01-01',9800.77);
INSERT INTO locacao VALUES (1,4,1,'2017-04-23','2017-04-27'),(10,6,2,'2017-05-02','2017-05-05'),(8,2,3,'2017-02-19','2017-02-28'),(7,1,4,'2017-04-08','2017-04-09'),(5,5,5,'2017-03-08','2017-03-13'),(3,3,6,'2017-05-12','2017-05-17');

