CREATE DATABASE IF NOT EXISTS `ifeventos` DEFAULT CHARACTER SET latin1;
USE `ifeventos`;

DROP TABLE IF EXISTS `evento`;
CREATE TABLE `evento` (
  `eve_id` int(11) NOT NULL AUTO_INCREMENT,
  `eve_titulo` varchar(255) DEFAULT NULL,
  `eve_area` varchar(100) DEFAULT NULL,
  `eve_dtinicio` date DEFAULT NULL,
  `eve_dtfim` date DEFAULT NULL,
  `eve_responsavel` varchar(255) DEFAULT NULL,
  `eve_tipo` varchar(255) DEFAULT NULL,
  `eve_local` varchar(255) DEFAULT NULL,
  `eve_endereco` varchar(255) DEFAULT NULL,
  `eve_qtdvagas` int(11) DEFAULT NULL,
  PRIMARY KEY (`eve_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;

INSERT INTO `evento` VALUES (2,'Semana do Meio Ambiente ccccbvc','Muldisciplinar','2017-06-05','2017-06-07','Rafaela','Oficina','IFTO','Rua do Aï¿½ude S/N Formoso do Araguaia-TO',60),(4,'Semana Agroinformatica','Informatica e Agricultura','2017-11-08','2017-11-15','Demis','Evento INstitucional','IFTO','Rua 10 Centro',140),(5,'ExpoFormoso1','Agronomia','2017-06-10','2017-06-18','Wagner da Grafica','Pecuaria','Espaï¿½o Agropecuï¿½ria','BR 242 KM 341',980),(19,'dsfsdfdsf','sdfsdfsdf','0000-00-00','0000-00-00','sdfsdfsd','sdfsdfsdf','sdfsdfds','sdfsdfsf',34);