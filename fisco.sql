CREATE SCHEMA IF NOT EXISTS `fisco` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `fisco` ;

CREATE TABLE IF NOT EXISTS `fisco`.`nota_fiscal` (
  `nf_cod` INT NOT NULL AUTO_INCREMENT,
  `item_cod` INT NULL,
  `prod_cod` INT NULL,
  `valor_un` DOUBLE(10,2) NULL,
  `quantidade` INT NULL,
  `desconto` DOUBLE(10,2) NULL,
  PRIMARY KEY (`nf_cod`)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8 COLLATE = utf8_general_ci;
