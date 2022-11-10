-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizzeria` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `pizzeria` ;

-- -----------------------------------------------------
-- Table `pizzeria`.`provincias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`provincias` (
  `provincia` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`provincia`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria`.`localitats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`localitats` (
  `Localitat` VARCHAR(45) NOT NULL,
  `provincias_provincia` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Localitat`, `provincias_provincia`),
  INDEX `fk_localitats_provincias1_idx` (`provincias_provincia` ASC) VISIBLE,
  CONSTRAINT `fk_localitats_provincias1`
    FOREIGN KEY (`provincias_provincia`)
    REFERENCES `pizzeria`.`provincias` (`provincia`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`client` (
  `idclient` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `cogonm1` VARCHAR(45) NOT NULL,
  `cognom2` VARCHAR(45) NOT NULL,
  `adreça` VARCHAR(200) NOT NULL,
  `telefon` INT NOT NULL,
  `localitats_Localitat` VARCHAR(45) NOT NULL,
  `localitats_provincias_provincia` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idclient`, `localitats_Localitat`, `localitats_provincias_provincia`),
  INDEX `fk_client_localitats1_idx` (`localitats_Localitat` ASC, `localitats_provincias_provincia` ASC) VISIBLE,
  CONSTRAINT `fk_client_localitats1`
    FOREIGN KEY (`localitats_Localitat` , `localitats_provincias_provincia`)
    REFERENCES `pizzeria`.`localitats` (`Localitat` , `provincias_provincia`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria`.`tenda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`tenda` (
  `idtenda` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `adreça` VARCHAR(100) NOT NULL,
  `localitats_Localitat` VARCHAR(45) NOT NULL,
  `localitats_provincias_provincia` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idtenda`, `localitats_Localitat`, `localitats_provincias_provincia`),
  INDEX `fk_tenda_localitats1_idx` (`localitats_Localitat` ASC, `localitats_provincias_provincia` ASC) VISIBLE,
  CONSTRAINT `fk_tenda_localitats1`
    FOREIGN KEY (`localitats_Localitat` , `localitats_provincias_provincia`)
    REFERENCES `pizzeria`.`localitats` (`Localitat` , `provincias_provincia`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria`.`treballadors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`treballadors` (
  `idtreballador` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `cognom1` VARCHAR(45) NOT NULL,
  `cognom2` VARCHAR(45) NOT NULL,
  `NIF` VARCHAR(45) NOT NULL,
  `telefon` INT NOT NULL,
  `lloc` VARCHAR(45) NOT NULL DEFAULT 'Cuiner o Repartidor',
  `tenda_idtenda` INT NOT NULL,
  PRIMARY KEY (`idtreballador`, `tenda_idtenda`),
  INDEX `fk_treballadors_tenda1_idx` (`tenda_idtenda` ASC) VISIBLE,
  CONSTRAINT `fk_treballadors_tenda1`
    FOREIGN KEY (`tenda_idtenda`)
    REFERENCES `pizzeria`.`tenda` (`idtenda`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria`.`comandes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`comandes` (
  `idcomanda` INT NOT NULL AUTO_INCREMENT,
  `preu_total` DOUBLE NOT NULL,
  `data` DATETIME NOT NULL,
  `client_idclient` INT NOT NULL,
  `tenda_idtenda` INT NOT NULL,
  `treballadors_idtreballador` INT NOT NULL,
  `treballadors_tenda_idtenda` INT NOT NULL,
  PRIMARY KEY (`idcomanda`, `client_idclient`, `tenda_idtenda`, `treballadors_idtreballador`, `treballadors_tenda_idtenda`),
  INDEX `fk_comandes_client1_idx` (`client_idclient` ASC) VISIBLE,
  INDEX `fk_comandes_tenda1_idx` (`tenda_idtenda` ASC) VISIBLE,
  INDEX `fk_comandes_treballadors1_idx` (`treballadors_idtreballador` ASC, `treballadors_tenda_idtenda` ASC) VISIBLE,
  CONSTRAINT `fk_comandes_client1`
    FOREIGN KEY (`client_idclient`)
    REFERENCES `pizzeria`.`client` (`idclient`),
  CONSTRAINT `fk_comandes_tenda1`
    FOREIGN KEY (`tenda_idtenda`)
    REFERENCES `pizzeria`.`tenda` (`idtenda`),
  CONSTRAINT `fk_comandes_treballadors1`
    FOREIGN KEY (`treballadors_idtreballador` , `treballadors_tenda_idtenda`)
    REFERENCES `pizzeria`.`treballadors` (`idtreballador` , `tenda_idtenda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria`.`productes_comanda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`productes_comanda` (
  `idproductes_comanda` INT NOT NULL AUTO_INCREMENT,
  `comandes_idcomanda` INT NOT NULL,
  PRIMARY KEY (`idproductes_comanda`, `comandes_idcomanda`),
  INDEX `fk_productes_comanda_comandes1_idx` (`comandes_idcomanda` ASC) VISIBLE,
  CONSTRAINT `fk_productes_comanda_comandes1`
    FOREIGN KEY (`comandes_idcomanda`)
    REFERENCES `pizzeria`.`comandes` (`idcomanda`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria`.`begudes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`begudes` (
  `idbegudes` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `descripcio` VARCHAR(100) NOT NULL,
  `imatge` VARCHAR(45) NOT NULL,
  `preu` DOUBLE NOT NULL,
  `productes_comanda_idproductes_comanda` INT NOT NULL,
  PRIMARY KEY (`idbegudes`, `productes_comanda_idproductes_comanda`),
  INDEX `fk_begudes_productes_comanda1_idx` (`productes_comanda_idproductes_comanda` ASC) VISIBLE,
  CONSTRAINT `fk_begudes_productes_comanda1`
    FOREIGN KEY (`productes_comanda_idproductes_comanda`)
    REFERENCES `pizzeria`.`productes_comanda` (`idproductes_comanda`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria`.`categoria_a`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`categoria_a` (
  `idcategoria_a` INT NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idcategoria_a`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria`.`categoria_b`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`categoria_b` (
  `idcategoria_b` INT NOT NULL,
  `nom` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idcategoria_b`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria`.`hamburguesas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`hamburguesas` (
  `idhamburguesas` INT NOT NULL AUTO_INCREMENT,
  `nom_hamburguesa` VARCHAR(45) NOT NULL,
  `descripcio` VARCHAR(100) NOT NULL,
  `imatge` VARCHAR(45) NOT NULL,
  `preu` DOUBLE NOT NULL,
  `productes_comanda_idproductes_comanda` INT NOT NULL,
  PRIMARY KEY (`idhamburguesas`, `productes_comanda_idproductes_comanda`),
  INDEX `fk_hamburguesas_productes_comanda1_idx` (`productes_comanda_idproductes_comanda` ASC) VISIBLE,
  CONSTRAINT `fk_hamburguesas_productes_comanda1`
    FOREIGN KEY (`productes_comanda_idproductes_comanda`)
    REFERENCES `pizzeria`.`productes_comanda` (`idproductes_comanda`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria`.`pizzas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`pizzas` (
  `idpizzas` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `descripcio` VARCHAR(100) NOT NULL,
  `imatge` VARCHAR(45) NOT NULL,
  `preu` DOUBLE NOT NULL,
  `productes_comanda_idproductes_comanda` INT NOT NULL,
  `categoria_a_idcategoria_a` INT NOT NULL,
  `categoria_b_idcategoria_b` INT NOT NULL,
  PRIMARY KEY (`idpizzas`, `productes_comanda_idproductes_comanda`, `categoria_a_idcategoria_a`, `categoria_b_idcategoria_b`),
  INDEX `fk_pizzas_productes_comanda1_idx` (`productes_comanda_idproductes_comanda` ASC) VISIBLE,
  INDEX `fk_pizzas_categoria_a1_idx` (`categoria_a_idcategoria_a` ASC) VISIBLE,
  INDEX `fk_pizzas_categoria_b1_idx` (`categoria_b_idcategoria_b` ASC) VISIBLE,
  CONSTRAINT `fk_pizzas_productes_comanda1`
    FOREIGN KEY (`productes_comanda_idproductes_comanda`)
    REFERENCES `pizzeria`.`productes_comanda` (`idproductes_comanda`),
  CONSTRAINT `fk_pizzas_categoria_a1`
    FOREIGN KEY (`categoria_a_idcategoria_a`)
    REFERENCES `pizzeria`.`categoria_a` (`idcategoria_a`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pizzas_categoria_b1`
    FOREIGN KEY (`categoria_b_idcategoria_b`)
    REFERENCES `pizzeria`.`categoria_b` (`idcategoria_b`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
