-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema youtube
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema youtube
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `youtube` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `youtube` ;

-- -----------------------------------------------------
-- Table `youtube`.`canal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`canal` (
  `idcanal` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `descripcio` VARCHAR(45) NOT NULL,
  `data_creacio` DATETIME NOT NULL,
  `usuari_idusuari` INT NOT NULL,
  PRIMARY KEY (`idcanal`, `usuari_idusuari`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `youtube`.`usuari`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`usuari` (
  `idusuari` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(100) NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  `data_naixement` DATE NOT NULL,
  `sexe` VARCHAR(45) NOT NULL,
  `pais` VARCHAR(45) NOT NULL,
  `codi_postal` INT NOT NULL,
  `canal_idcanal` INT NOT NULL,
  `canal_usuari_idusuari` INT NOT NULL,
  PRIMARY KEY (`idusuari`, `canal_idcanal`, `canal_usuari_idusuari`),
  INDEX `fk_usuari_canal1_idx` (`canal_idcanal` ASC, `canal_usuari_idusuari` ASC) VISIBLE,
  CONSTRAINT `fk_usuari_canal1`
    FOREIGN KEY (`canal_idcanal` , `canal_usuari_idusuari`)
    REFERENCES `youtube`.`canal` (`idcanal` , `usuari_idusuari`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `youtube`.`comentaris`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`comentaris` (
  `idcomentaris` INT NOT NULL AUTO_INCREMENT,
  `canal_idcanal` INT NOT NULL,
  `canal_usuari_idusuari` INT NOT NULL,
  `usuari_idusuari` INT NOT NULL,
  PRIMARY KEY (`idcomentaris`, `canal_idcanal`, `canal_usuari_idusuari`, `usuari_idusuari`),
  INDEX `fk_comentaris_canal1_idx` (`canal_idcanal` ASC, `canal_usuari_idusuari` ASC) VISIBLE,
  INDEX `fk_comentaris_usuari1_idx` (`usuari_idusuari` ASC) VISIBLE,
  CONSTRAINT `fk_comentaris_canal1`
    FOREIGN KEY (`canal_idcanal` , `canal_usuari_idusuari`)
    REFERENCES `youtube`.`canal` (`idcanal` , `usuari_idusuari`),
  CONSTRAINT `fk_comentaris_usuari1`
    FOREIGN KEY (`usuari_idusuari`)
    REFERENCES `youtube`.`usuari` (`idusuari`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `youtube`.`video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`video` (
  `idvideo` INT NOT NULL AUTO_INCREMENT,
  `titol` VARCHAR(100) NOT NULL,
  `descripcio` VARCHAR(500) NOT NULL,
  `grandària` INT NOT NULL,
  `nom_arxiu` VARCHAR(45) NOT NULL,
  `durada` TIME NOT NULL,
  `thumbnail` VARCHAR(45) NOT NULL,
  `reproduccions` INT NOT NULL,
  `likes` INT NOT NULL,
  `deslikes` INT NOT NULL,
  `usuari_idusuari` INT NOT NULL,
  PRIMARY KEY (`idvideo`),
  INDEX `fk_video_usuari1_idx` (`usuari_idusuari` ASC) VISIBLE,
  CONSTRAINT `fk_video_usuari1`
    FOREIGN KEY (`usuari_idusuari`)
    REFERENCES `youtube`.`usuari` (`idusuari`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `youtube`.`estats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`estats` (
  `idestats` INT NOT NULL AUTO_INCREMENT,
  `public` VARCHAR(45) NOT NULL,
  `privat` VARCHAR(45) NOT NULL,
  `ocult` VARCHAR(45) NOT NULL,
  `video_idvideo` INT NOT NULL,
  PRIMARY KEY (`idestats`, `video_idvideo`),
  INDEX `fk_estats_video1_idx` (`video_idvideo` ASC) VISIBLE,
  CONSTRAINT `fk_estats_video1`
    FOREIGN KEY (`video_idvideo`)
    REFERENCES `youtube`.`video` (`idvideo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `youtube`.`etiquetes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`etiquetes` (
  `idetiquetes` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `video_idvideo` INT NOT NULL,
  PRIMARY KEY (`idetiquetes`, `video_idvideo`),
  INDEX `fk_etiquetes_video1_idx` (`video_idvideo` ASC) VISIBLE,
  CONSTRAINT `fk_etiquetes_video1`
    FOREIGN KEY (`video_idvideo`)
    REFERENCES `youtube`.`video` (`idvideo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `youtube`.`playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`playlist` (
  `idplaylist` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `data_creacio` DATETIME NOT NULL,
  `estat` VARCHAR(45) NOT NULL,
  `usuari_idusuari` INT NOT NULL,
  PRIMARY KEY (`idplaylist`, `usuari_idusuari`),
  INDEX `fk_playlist_usuari1_idx` (`usuari_idusuari` ASC) VISIBLE,
  CONSTRAINT `fk_playlist_usuari1`
    FOREIGN KEY (`usuari_idusuari`)
    REFERENCES `youtube`.`usuari` (`idusuari`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `youtube`.`suscripcio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`suscripcio` (
  `idsuscripcio` INT NOT NULL AUTO_INCREMENT,
  `usuari_idusuari` INT NOT NULL,
  `canal_idcanal` INT NOT NULL,
  `canal_usuari_idusuari` INT NOT NULL,
  PRIMARY KEY (`idsuscripcio`, `canal_idcanal`, `canal_usuari_idusuari`),
  INDEX `fk_suscripcio_usuari1_idx` (`usuari_idusuari` ASC) VISIBLE,
  INDEX `fk_suscripcio_canal1_idx` (`canal_idcanal` ASC, `canal_usuari_idusuari` ASC) VISIBLE,
  CONSTRAINT `fk_suscripcio_canal1`
    FOREIGN KEY (`canal_idcanal` , `canal_usuari_idusuari`)
    REFERENCES `youtube`.`canal` (`idcanal` , `usuari_idusuari`),
  CONSTRAINT `fk_suscripcio_usuari1`
    FOREIGN KEY (`usuari_idusuari`)
    REFERENCES `youtube`.`usuari` (`idusuari`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `youtube`.`valoracions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`valoracions` (
  `idvaloracions` INT NOT NULL AUTO_INCREMENT,
  `like` VARCHAR(45) NOT NULL,
  `deslike` VARCHAR(45) NOT NULL,
  `data_creacio` DATETIME NOT NULL,
  `comentaris_idcomentaris` INT NOT NULL,
  `comentaris_canal_idcanal` INT NOT NULL,
  `comentaris_canal_usuari_idusuari` INT NOT NULL,
  `comentaris_usuari_idusuari` INT NOT NULL,
  `usuari_idusuari` INT NOT NULL,
  `video_idvideo` INT NOT NULL,
  PRIMARY KEY (`idvaloracions`, `comentaris_idcomentaris`, `comentaris_canal_idcanal`, `comentaris_canal_usuari_idusuari`, `comentaris_usuari_idusuari`, `usuari_idusuari`, `video_idvideo`),
  INDEX `fk_valoracions_comentaris1_idx` (`comentaris_idcomentaris` ASC, `comentaris_canal_idcanal` ASC, `comentaris_canal_usuari_idusuari` ASC, `comentaris_usuari_idusuari` ASC) VISIBLE,
  INDEX `fk_valoracions_usuari1_idx` (`usuari_idusuari` ASC) VISIBLE,
  INDEX `fk_valoracions_video1_idx` (`video_idvideo` ASC) VISIBLE,
  CONSTRAINT `fk_valoracions_comentaris1`
    FOREIGN KEY (`comentaris_idcomentaris` , `comentaris_canal_idcanal` , `comentaris_canal_usuari_idusuari` , `comentaris_usuari_idusuari`)
    REFERENCES `youtube`.`comentaris` (`idcomentaris` , `canal_idcanal` , `canal_usuari_idusuari` , `usuari_idusuari`),
  CONSTRAINT `fk_valoracions_usuari1`
    FOREIGN KEY (`usuari_idusuari`)
    REFERENCES `youtube`.`usuari` (`idusuari`),
  CONSTRAINT `fk_valoracions_video1`
    FOREIGN KEY (`video_idvideo`)
    REFERENCES `youtube`.`video` (`idvideo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
