-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema optica
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema optica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `optica` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `optica` ;

-- -----------------------------------------------------
-- Table `optica`.`clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`clients` (
  `idclients` INT NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  `cognom1` VARCHAR(45) NOT NULL,
  `cognom2` VARCHAR(45) NOT NULL,
  `adreça` VARCHAR(200) NOT NULL,
  `telefon` INT NOT NULL,
  `mail` VARCHAR(45) NOT NULL,
  `data_registre` DATE NOT NULL,
  `recomana` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idclients`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `optica`.`proveidors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`proveidors` (
  `Nom_proveidor` VARCHAR(45) NOT NULL,
  `Adreça_proveidor` VARCHAR(200) NOT NULL,
  `Telefon_proveidor` INT NOT NULL,
  `FAX_proveidor` INT NOT NULL,
  `NIF_proveidor` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`NIF_proveidor`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `optica`.`ulleres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`ulleres` (
  `idulleres` INT NOT NULL AUTO_INCREMENT,
  `marca` VARCHAR(45) NOT NULL,
  `graduacio_esq` DOUBLE NOT NULL,
  `graduacio_der` DOUBLE NOT NULL,
  `montura` VARCHAR(45) NOT NULL,
  `color_montura` VARCHAR(45) NOT NULL,
  `color_vidre_esq` VARCHAR(45) NOT NULL,
  `color_vidre_dret` VARCHAR(45) NOT NULL,
  `preu` DOUBLE NOT NULL,
  `proveidors_NIF_proveidor` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idulleres`),
  INDEX `marca_idx` (`marca` ASC) VISIBLE,
  INDEX `fk_ulleres_proveidors_idx` (`proveidors_NIF_proveidor` ASC) VISIBLE,
  CONSTRAINT `fk_ulleres_proveidors`
    FOREIGN KEY (`proveidors_NIF_proveidor`)
    REFERENCES `optica`.`proveidors` (`NIF_proveidor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `optica`.`ventes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`ventes` (
  `data_venta` DATE NOT NULL,
  `treballador` VARCHAR(45) NOT NULL,
  `ulleres_idulleres` INT NOT NULL,
  `clients_idclients` INT NOT NULL,
  PRIMARY KEY (`ulleres_idulleres`, `clients_idclients`),
  INDEX `fk_ventes_clients1_idx` (`clients_idclients` ASC) VISIBLE,
  CONSTRAINT `fk_ventes_ulleres1`
    FOREIGN KEY (`ulleres_idulleres`)
    REFERENCES `optica`.`ulleres` (`idulleres`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ventes_clients1`
    FOREIGN KEY (`clients_idclients`)
    REFERENCES `optica`.`clients` (`idclients`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
