DROP SCHEMA IF EXISTS loja ;
CREATE DATABASE loja DEFAULT CHARACTER SET utf8;
USE loja;

DROP TABLE IF EXISTS entrega;
CREATE TABLE entrega (
  ent_id int(11) NOT NULL AUTO_INCREMENT,
  ent_endereco varchar(255) DEFAULT NULL,
  ent_ped_id int(11) NOT NULL,
  ent_cli_id int(11) NOT NULL,
  PRIMARY KEY (`ent_id`),
  KEY `ent_ped_id` (`ent_ped_id`),
  CONSTRAINT `ENTREGA_ibfk_1` FOREIGN KEY (`ent_ped_id`) REFERENCES `pedido` (`ped_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS cliente;
CREATE TABLE cliente (
  cli_id int(11) unsigned NOT NULL,
  cli_nome varchar(255) NOT NULL,
  cli_end varchar(50) DEFAULT NULL,
  cli_end_cidade varchar(255) DEFAULT NULL,
  cli_end_cep char(8) DEFAULT NULL,
  cli_telefone varchar(20) DEFAULT NULL,
  cli_dt_nascimento date DEFAULT NULL,
  cli_perc_desconto decimal(2,2) DEFAULT NULL,
  cli_uf_id int(11) unsigned NOT NULL,
  PRIMARY KEY (`cli_id`),
  UNIQUE KEY `cliente_id_UNIQUE` (`cli_id`),
  KEY `fk_cliente_estado_idx` (`cli_uf_id`),
  CONSTRAINT `fk_cliente_estado` FOREIGN KEY (`cli_uf_id`) REFERENCES `estado` (`uf_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS estado;
CREATE TABLE estado (
  uf_id int(11) unsigned NOT NULL,
  uf_nome varchar(100) NOT NULL,
  PRIMARY KEY (`uf_id`),
  UNIQUE KEY `uf_codigo_UNIQUE` (`uf_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `pedido`;
CREATE TABLE pedido (
  ped_id int(11) NOT NULL AUTO_INCREMENT,
  ped_tipo enum('A VISTA','A PRAZO') DEFAULT NULL,
  ped_dt_entrada date DEFAULT NULL,
  ped_valor_total decimal(7,2) DEFAULT NULL,
  ped_desconto decimal(7,2) DEFAULT NULL,
  ped_dt_saida date DEFAULT NULL,
  ped_cli_id int(11) unsigned NOT NULL,
  PRIMARY KEY (`ped_id`),
  KEY `fk_pedido_cliente1_idx` (`ped_cli_id`),
  CONSTRAINT `fk_pedido_cliente1` FOREIGN KEY (`ped_cli_id`) REFERENCES `cliente` (`cli_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS produto;
CREATE TABLE produto (
  prod_id int(11) NOT NULL AUTO_INCREMENT,
  prod_nome varchar(255) DEFAULT NULL,
  prod_preco double(10,2) DEFAULT NULL,
  PRIMARY KEY (prod_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS produtos_do_pedido;
CREATE TABLE produtos_do_pedido (
  pdp_ped_id int(11) NOT NULL,
  pdp_prod_id int(11) NOT NULL,
  pdp_id int(11) NOT NULL,
  pdp_quantidade int(11) DEFAULT NULL,
  pdp_valor_unitario double(10,2) DEFAULT NULL,
  pdp_valor_total double(10,2) DEFAULT NULL,
  PRIMARY KEY (pdp_id),
  KEY fk_pedido_has_produto_produto1_idx (pdp_prod_id),
  KEY fk_pedido_has_produto_pedido1_idx (pdp_ped_id),
  CONSTRAINT fk_pedido_has_produto_pedido1 
    FOREIGN KEY (pdp_ped_id) 
    REFERENCES pedido (ped_id) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION,
  CONSTRAINT fk_pedido_has_produto_produt1 
    FOREIGN KEY (pdp_prod_id) 
    REFERENCES produto (prod_id) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
