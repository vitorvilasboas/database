DROP DATABASE IF EXISTS loja; -- excluir database se existir
CREATE DATABASE loja DEFAULT CHARSET utf8;
USE loja;

DROP TABLE IF EXISTS loja.usuario;
CREATE TABLE loja.usuario (
  usu_id INT(11) NOT NULL auto_increment,
  usu_nome VARCHAR(45) NULL,
  usu_senha VARCHAR(45) NULL,
  usu_permissao VARCHAR(45) NULL,
  PRIMARY KEY (usu_id)
) ENGINE = InnoDB;

DROP TABLE IF EXISTS loja.cliente;
CREATE TABLE IF NOT EXISTS loja.cliente (
  cli_id INT NOT NULL,
  cli_nome VARCHAR(100) NOT NULL,
  cli_fone VARCHAR(45) NOT NULL,
  cli_dtnasc DATE NOT NULL,
  cli_endereco VARCHAR(45) NOT NULL,
  cli_cpf VARCHAR(45) NOT NULL,
  cli_rg VARCHAR(45) NOT NULL,
  cli_email VARCHAR(45) NOT NULL,
  cli_cep VARCHAR(45) NOT NULL,
  cli_usu_id INT NOT NULL,
  PRIMARY KEY (cli_id),
  CONSTRAINT fk_cli_usuario FOREIGN KEY (cli_usu_id) REFERENCES usuario (usu_id)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- CONSTRAINT nome_constraint FOREIGN KEY (coluna_afetada) REFERENCES tabela_de_referencia(atributo_de_referencia)

DROP TABLE IF EXISTS loja.pedido;
CREATE TABLE IF NOT EXISTS pedido (
  id_pedido INT NOT NULL auto_increment,
  valor_total_pedido VARCHAR(45) NOT NULL,
  data_pedido DATE NOT NULL,
  numero_pedido VARCHAR(45) NOT NULL,
  cli_ped_id INT NOT NULL,
  PRIMARY KEY (ped_id),
  INDEX fk_cli_ped (cli_ped_id ASC),
  CONSTRAINT fk_cli_ped FOREIGN KEY (cli_ped_id)
    REFERENCES loja.cliente (cli_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

DROP TABLE IF EXISTS loja.formas_pagamento;
CREATE TABLE loja.formas_pagamento (
  pag_id INT(11) NOT NULL,
  pag_tipo VARCHAR(45) NOT NULL, -- boleto, ccredito, cdebito, pix
  pag_ped_id INT(11) NOT NULL,
  PRIMARY KEY (pag_id),
  INDEX fk_pag_ped (pag_ped_id ASC),
  CONSTRAINT fk_pag_ped FOREIGN KEY (pag_ped_id) REFERENCES loja.pedido (ped_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

DROP TABLE IF EXISTS loja.categoria;
CREATE TABLE loja.categoria (
  cat_id INT(11) NOT NULL auto_increment,
  cat_tipo VARCHAR(45) NOT NULL, -- joias presentes
  PRIMARY KEY (cat_id)
) ENGINE = InnoDB;

DROP TABLE IF EXISTS loja.produto;
CREATE TABLE loja.produto (
  prod_id INT(11) NOT NULL,
  prod_nome VARCHAR(45) NOT NULL,
  `codigo_produtos` VARCHAR(45) NOT NULL,
  prod_cat_id INT NOT NULL,
  PRIMARY KEY (`id_produtos`),
  INDEX `fk_produtos_categoria1_idx` (`categoria_id_categoria` ASC),
  CONSTRAINT `fk_produtos_categoria1`
    FOREIGN KEY (`categoria_id_categoria`)
    REFERENCES `mydb`.`categoria` (`id_categoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `mydb`.`entrega` (
  ent_id INT NOT NULL,
  `nome_destinatario_entrega` VARCHAR(45) NOT NULL,
  `endereco_destinatario_entrega` VARCHAR(45) NOT NULL,
  `valor_total_entrega` VARCHAR(45) NOT NULL,
  `valor_frete_entrega` VARCHAR(45) NOT NULL,
  `cep_destinatario_entrega` VARCHAR(45) NOT NULL,
  `valor_total_compra` VARCHAR(45) NOT NULL,
  `prazo_previsto_entrega` VARCHAR(45) NOT NULL,
  `codigo_rastreamento` VARCHAR(45) NOT NULL,
  `pedido_id_pedido` INT NOT NULL,
  PRIMARY KEY (`id_entrega`),
  INDEX `fk_entrega_pedido1_idx` (`pedido_id_pedido` ASC) VISIBLE,
  CONSTRAINT `fk_entrega_pedido1`
    FOREIGN KEY (`pedido_id_pedido`)
    REFERENCES `mydb`.`pedido` (`id_pedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `mydb`.`tecnico` (
  `id_tecnico` INT NOT NULL,
  `nome_tecnico` VARCHAR(45) NOT NULL,
  `cpf_tecnico` VARCHAR(45) NOT NULL,
  `telefone_tecnico` VARCHAR(45) NOT NULL,
  `email_tecnico` VARCHAR(45) NOT NULL,
  `usuario_id_usuario` INT NOT NULL,
  PRIMARY KEY (`id_tecnico`),
  INDEX `fk_tecnico_usuario1_idx` (`usuario_id_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_tecnico_usuario1`
    FOREIGN KEY (`usuario_id_usuario`)
    REFERENCES `mydb`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `mydb`.`pedido_has_produtos` (
  `pedido_id_pedido` INT NOT NULL,
  `produtos_id_produtos` INT NOT NULL,
  PRIMARY KEY (`pedido_id_pedido`, `produtos_id_produtos`),
  INDEX `fk_pedido_has_produtos_produtos1_idx` (`produtos_id_produtos` ASC) VISIBLE,
  INDEX `fk_pedido_has_produtos_pedido_idx` (`pedido_id_pedido` ASC) VISIBLE,
  CONSTRAINT `fk_pedido_has_produtos_pedido`
    FOREIGN KEY (`pedido_id_pedido`)
    REFERENCES `mydb`.`pedido` (`id_pedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_has_produtos_produtos1`
    FOREIGN KEY (`produtos_id_produtos`)
    REFERENCES `mydb`.`produtos` (`id_produtos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;