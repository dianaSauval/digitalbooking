-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema remodigitalbookingprod
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema remodigitalbookingprod
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `remodigitalbookingprod` DEFAULT CHARACTER SET utf8mb4 ;
USE `remodigitalbookingprod` ;

-- -----------------------------------------------------
-- Table `remodigitalbookingprod`.`caracteristicas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `remodigitalbookingprod`.`caracteristicas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `icono` VARCHAR(255) NULL DEFAULT NULL,
  `nombre` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `remodigitalbookingprod`.`categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `remodigitalbookingprod`.`categorias` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(255) NULL DEFAULT NULL,
  `titulo` VARCHAR(255) NULL DEFAULT NULL,
  `url_img` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `remodigitalbookingprod`.`ciudades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `remodigitalbookingprod`.`ciudades` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(255) NULL DEFAULT NULL,
  `pais` VARCHAR(255) NULL DEFAULT NULL,
  `provincia` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `remodigitalbookingprod`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `remodigitalbookingprod`.`productos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(255) NULL DEFAULT NULL,
  `latitud` DOUBLE NULL DEFAULT NULL,
  `longitud` DOUBLE NULL DEFAULT NULL,
  `nombre` VARCHAR(255) NULL DEFAULT NULL,
  `categorias_id` INT NOT NULL,
  `ciudades_id` INT NOT NULL,
  PRIMARY KEY (`id`, `categorias_id`, `ciudades_id`),
  INDEX `fk_productos_categorias_idx` (`categorias_id` ASC),
  INDEX `fk_productos_ciudades1_idx` (`ciudades_id` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `remodigitalbookingprod`.`imagenes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `remodigitalbookingprod`.`imagenes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(255) NULL DEFAULT NULL,
  `url` VARCHAR(255) NULL DEFAULT NULL,
  `productos_id` INT NOT NULL,
  PRIMARY KEY (`id`, `productos_id`),
  INDEX `fk_imagenes_productos1_idx` (`productos_id` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `remodigitalbookingprod`.`politicas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `remodigitalbookingprod`.`politicas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(255) NULL DEFAULT NULL,
  `tipo` INT NULL DEFAULT NULL,
  `productos_id` INT NOT NULL,
  PRIMARY KEY (`id`, `productos_id`),
  INDEX `fk_politicas_productos1_idx` (`productos_id` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `remodigitalbookingprod`.`productos_caracteristicas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `remodigitalbookingprod`.`productos_caracteristicas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `productos_id` INT NOT NULL,
  `caracteristicas_id` INT NOT NULL,
  PRIMARY KEY (`id`, `productos_id`, `caracteristicas_id`),
  INDEX `fk_productos_caracteristicas_productos1_idx` (`productos_id` ASC),
  INDEX `fk_productos_caracteristicas_caracteristicas1_idx` (`caracteristicas_id` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `remodigitalbookingprod`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `remodigitalbookingprod`.`roles` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `remodigitalbookingprod`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `remodigitalbookingprod`.`usuarios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `apellido` VARCHAR(255) NULL DEFAULT NULL,
  `ciudad_usuario` VARCHAR(255) NULL DEFAULT NULL,
  `email` VARCHAR(255) NULL DEFAULT NULL,
  `nombre` VARCHAR(255) NULL DEFAULT NULL,
  `password` VARCHAR(255) NULL DEFAULT NULL,
  `username` VARCHAR(255) NULL DEFAULT NULL,
  `roles_id` INT NOT NULL,
  PRIMARY KEY (`id`, `roles_id`),
  INDEX `fk_usuarios_roles1_idx` (`roles_id` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `remodigitalbookingprod`.`reservas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `remodigitalbookingprod`.`reservas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fecha_final` DATE NULL DEFAULT NULL,
  `fecha_inicial` DATE NULL DEFAULT NULL,
  `hora` TIME NULL DEFAULT NULL,
  `productos_id` INT NOT NULL,
  `usuarios_id` INT NOT NULL,
  PRIMARY KEY (`id`, `productos_id`, `usuarios_id`),
  INDEX `fk_reservas_productos1_idx` (`productos_id` ASC),
  INDEX `fk_reservas_usuarios1_idx` (`usuarios_id` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8mb4;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
