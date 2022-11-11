-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema universidad
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema universidad
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `universidad` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
-- -----------------------------------------------------
-- Schema pizzerias
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pizzerias
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizzerias` DEFAULT CHARACTER SET utf8mb3 ;
USE `universidad` ;

-- -----------------------------------------------------
-- Table `universidad`.`persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universidad`.`persona` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nif` VARCHAR(9) NULL DEFAULT NULL,
  `nombre` VARCHAR(25) NOT NULL,
  `apellido1` VARCHAR(50) NOT NULL,
  `apellido2` VARCHAR(50) NULL DEFAULT NULL,
  `ciudad` VARCHAR(25) NOT NULL,
  `direccion` VARCHAR(50) NOT NULL,
  `telefono` VARCHAR(9) NULL DEFAULT NULL,
  `fecha_nacimiento` DATE NOT NULL,
  `sexo` ENUM('H', 'M') NOT NULL,
  `tipo` ENUM('profesor', 'alumno') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nif` (`nif` ASC) INVISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 25
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `universidad`.`departamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universidad`.`departamento` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `universidad`.`profesor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universidad`.`profesor` (
  `id_profesor` INT UNSIGNED NOT NULL,
  `id_departamento` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_profesor`),
  INDEX `id_departamento` (`id_departamento` ASC) VISIBLE,
  CONSTRAINT `profesor_ibfk_1`
    FOREIGN KEY (`id_profesor`)
    REFERENCES `universidad`.`persona` (`id`),
  CONSTRAINT `profesor_ibfk_2`
    FOREIGN KEY (`id_departamento`)
    REFERENCES `universidad`.`departamento` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `universidad`.`grado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universidad`.`grado` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `universidad`.`asignatura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universidad`.`asignatura` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `creditos` FLOAT UNSIGNED NOT NULL,
  `tipo` ENUM('básica', 'obligatoria', 'optativa') NOT NULL,
  `curso` TINYINT UNSIGNED NOT NULL,
  `cuatrimestre` TINYINT UNSIGNED NOT NULL,
  `id_profesor` INT UNSIGNED NULL DEFAULT NULL,
  `id_grado` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_profesor` (`id_profesor` ASC) VISIBLE,
  INDEX `id_grado` (`id_grado` ASC) VISIBLE,
  CONSTRAINT `asignatura_ibfk_1`
    FOREIGN KEY (`id_profesor`)
    REFERENCES `universidad`.`profesor` (`id_profesor`),
  CONSTRAINT `asignatura_ibfk_2`
    FOREIGN KEY (`id_grado`)
    REFERENCES `universidad`.`grado` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 84
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `universidad`.`curso_escolar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universidad`.`curso_escolar` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `anyo_inicio` YEAR NOT NULL,
  `anyo_fin` YEAR NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `universidad`.`alumno_se_matricula_asignatura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universidad`.`alumno_se_matricula_asignatura` (
  `id_alumno` INT UNSIGNED NOT NULL,
  `id_asignatura` INT UNSIGNED NOT NULL,
  `id_curso_escolar` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_alumno`, `id_asignatura`, `id_curso_escolar`),
  INDEX `id_asignatura` (`id_asignatura` ASC) VISIBLE,
  INDEX `id_curso_escolar` (`id_curso_escolar` ASC) VISIBLE,
  CONSTRAINT `alumno_se_matricula_asignatura_ibfk_1`
    FOREIGN KEY (`id_alumno`)
    REFERENCES `universidad`.`persona` (`id`),
  CONSTRAINT `alumno_se_matricula_asignatura_ibfk_2`
    FOREIGN KEY (`id_asignatura`)
    REFERENCES `universidad`.`asignatura` (`id`),
  CONSTRAINT `alumno_se_matricula_asignatura_ibfk_3`
    FOREIGN KEY (`id_curso_escolar`)
    REFERENCES `universidad`.`curso_escolar` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `pizzerias` ;

-- -----------------------------------------------------
-- Table `pizzerias`.`begudes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzerias`.`begudes` (
  `idbegudes` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `descripcio` VARCHAR(150) NOT NULL,
  `imagen` VARCHAR(45) NOT NULL,
  `preu` DOUBLE NOT NULL,
  PRIMARY KEY (`idbegudes`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pizzerias`.`categoria_a`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzerias`.`categoria_a` (
  `idcategoria_a` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idcategoria_a`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pizzerias`.`categoria_b`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzerias`.`categoria_b` (
  `idcategoria_b` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idcategoria_b`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pizzerias`.`provincies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzerias`.`provincies` (
  `idprovincies` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idprovincies`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pizzerias`.`localitat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzerias`.`localitat` (
  `idlocalitat` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `provincies_idprovincies` INT NOT NULL,
  PRIMARY KEY (`idlocalitat`),
  INDEX `fk_localitat_provincies1_idx` (`provincies_idprovincies` ASC) VISIBLE,
  CONSTRAINT `fk_localitat_provincies1`
    FOREIGN KEY (`provincies_idprovincies`)
    REFERENCES `pizzerias`.`provincies` (`idprovincies`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pizzerias`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzerias`.`client` (
  `idclient` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `cognom1` VARCHAR(45) NOT NULL,
  `cognom2` VARCHAR(45) NOT NULL,
  `adreça` VARCHAR(150) NOT NULL,
  `codi_postal` INT NOT NULL,
  `telefon` VARCHAR(15) NOT NULL,
  `localitat_idlocalitat` INT NOT NULL,
  PRIMARY KEY (`idclient`),
  INDEX `fk_client_localitat1_idx` (`localitat_idlocalitat` ASC) VISIBLE,
  CONSTRAINT `fk_client_localitat1`
    FOREIGN KEY (`localitat_idlocalitat`)
    REFERENCES `pizzerias`.`localitat` (`idlocalitat`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pizzerias`.`hamburgueses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzerias`.`hamburgueses` (
  `idhamburgueses` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `descripcio` VARCHAR(150) NOT NULL,
  `imatge` VARCHAR(45) NOT NULL,
  `preu` DOUBLE NOT NULL,
  PRIMARY KEY (`idhamburgueses`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pizzerias`.`pizzes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzerias`.`pizzes` (
  `idpizzes` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `descripcio` VARCHAR(150) NOT NULL,
  `imatge` VARCHAR(45) NOT NULL,
  `preu` DOUBLE NOT NULL,
  `categoria_a_idcategoria_a` INT NOT NULL,
  `categoria_b_idcategoria_b` INT NOT NULL,
  PRIMARY KEY (`idpizzes`),
  INDEX `fk_pizzes_categoria_a1_idx` (`categoria_a_idcategoria_a` ASC) VISIBLE,
  INDEX `fk_pizzes_categoria_b1_idx` (`categoria_b_idcategoria_b` ASC) VISIBLE,
  CONSTRAINT `fk_pizzes_categoria_a1`
    FOREIGN KEY (`categoria_a_idcategoria_a`)
    REFERENCES `pizzerias`.`categoria_a` (`idcategoria_a`),
  CONSTRAINT `fk_pizzes_categoria_b1`
    FOREIGN KEY (`categoria_b_idcategoria_b`)
    REFERENCES `pizzerias`.`categoria_b` (`idcategoria_b`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pizzerias`.`tenda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzerias`.`tenda` (
  `idtenda` INT NOT NULL AUTO_INCREMENT,
  `direccio` VARCHAR(45) NOT NULL,
  `localitat_idlocalitat` INT NOT NULL,
  PRIMARY KEY (`idtenda`),
  INDEX `fk_tenda_localitat1_idx` (`localitat_idlocalitat` ASC) VISIBLE,
  CONSTRAINT `fk_tenda_localitat1`
    FOREIGN KEY (`localitat_idlocalitat`)
    REFERENCES `pizzerias`.`localitat` (`idlocalitat`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pizzerias`.`treballador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzerias`.`treballador` (
  `idtreballador` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `lloc_treball` ENUM('repartidor', 'cuiner') NOT NULL,
  `tenda_idtenda` INT NOT NULL,
  PRIMARY KEY (`idtreballador`, `tenda_idtenda`),
  INDEX `fk_treballador_tenda1_idx` (`tenda_idtenda` ASC) VISIBLE,
  CONSTRAINT `fk_treballador_tenda1`
    FOREIGN KEY (`tenda_idtenda`)
    REFERENCES `pizzerias`.`tenda` (`idtenda`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pizzerias`.`comanda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzerias`.`comanda` (
  `idcomanda` INT NOT NULL AUTO_INCREMENT,
  `tipus` ENUM('domicili', 'botiga') NOT NULL,
  `data_venta` DATETIME NOT NULL,
  `hamburgueses_idhamburgueses` INT NOT NULL,
  `pizzes_idpizzes` INT NOT NULL,
  `begudes_idbegudes` INT NOT NULL,
  `client_idclient` INT NOT NULL,
  `treballador_idtreballador` INT NOT NULL,
  `treballador_tenda_idtenda` INT NOT NULL,
  PRIMARY KEY (`idcomanda`, `hamburgueses_idhamburgueses`, `pizzes_idpizzes`, `begudes_idbegudes`, `client_idclient`, `treballador_idtreballador`, `treballador_tenda_idtenda`),
  INDEX `fk_comanda_client1_idx` (`client_idclient` ASC) VISIBLE,
  INDEX `fk_comanda_hamburgueses1_idx` (`hamburgueses_idhamburgueses` ASC) VISIBLE,
  INDEX `fk_comanda_pizzes1_idx` (`pizzes_idpizzes` ASC) VISIBLE,
  INDEX `fk_comanda_begudes1_idx` (`begudes_idbegudes` ASC) VISIBLE,
  INDEX `fk_comanda_treballador1_idx` (`treballador_idtreballador` ASC, `treballador_tenda_idtenda` ASC) VISIBLE,
  CONSTRAINT `fk_comanda_begudes1`
    FOREIGN KEY (`begudes_idbegudes`)
    REFERENCES `pizzerias`.`begudes` (`idbegudes`),
  CONSTRAINT `fk_comanda_client1`
    FOREIGN KEY (`client_idclient`)
    REFERENCES `pizzerias`.`client` (`idclient`),
  CONSTRAINT `fk_comanda_hamburgueses1`
    FOREIGN KEY (`hamburgueses_idhamburgueses`)
    REFERENCES `pizzerias`.`hamburgueses` (`idhamburgueses`),
  CONSTRAINT `fk_comanda_pizzes1`
    FOREIGN KEY (`pizzes_idpizzes`)
    REFERENCES `pizzerias`.`pizzes` (`idpizzes`),
  CONSTRAINT `fk_comanda_treballador1`
    FOREIGN KEY (`treballador_idtreballador` , `treballador_tenda_idtenda`)
    REFERENCES `pizzerias`.`treballador` (`idtreballador` , `tenda_idtenda`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
