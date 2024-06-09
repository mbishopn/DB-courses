-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema comp2009assignment1
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema comp2009assignment1
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `comp2009assignment1` DEFAULT CHARACTER SET utf8mb3 ;
USE `comp2009assignment1` ;

-- -----------------------------------------------------
-- Table `comp2009assignment1`.`manufacturer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `comp2009assignment1`.`manufacturer` (
  `code` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `address` VARCHAR(45) NULL DEFAULT NULL,
  `phone` VARCHAR(45) NULL DEFAULT NULL,
  `acc_number` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`code`),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3
COMMENT = '		';


-- -----------------------------------------------------
-- Table `comp2009assignment1`.`quality`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `comp2009assignment1`.`quality` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `comp2009assignment1`.`brand`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `comp2009assignment1`.`brand` (
  `brand_name` VARCHAR(45) NOT NULL,
  `quality_id` INT NOT NULL,
  `manufacturer` INT NOT NULL,
  PRIMARY KEY (`brand_name`),
  INDEX `manufacturer_idx` (`manufacturer` ASC) VISIBLE,
  INDEX `fk_brand_quality1_idx` (`quality_id` ASC) VISIBLE,
  CONSTRAINT `manufacturer`
    FOREIGN KEY (`manufacturer`)
    REFERENCES `comp2009assignment1`.`manufacturer` (`code`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `quality`
    FOREIGN KEY (`quality_id`)
    REFERENCES `comp2009assignment1`.`quality` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `comp2009assignment1`.`model`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `comp2009assignment1`.`model` (
  `model_id` INT NOT NULL AUTO_INCREMENT,
  `model_name` VARCHAR(45) NULL,
  `brand` VARCHAR(45) NOT NULL,
  `manufacture_date` DATE NULL,
  `price_suggested` DECIMAL(9,2) NULL DEFAULT NULL,
  `price_store` DECIMAL(9,2) NULL DEFAULT NULL,
  PRIMARY KEY (`model_id`),
  INDEX `brand_idx` (`brand` ASC) VISIBLE,
  CONSTRAINT `brand`
    FOREIGN KEY (`brand`)
    REFERENCES `comp2009assignment1`.`brand` (`brand_name`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `comp2009assignment1`.`model_specs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `comp2009assignment1`.`model_specs` (
  `model_id` INT NOT NULL,
  `cylinders` INT NULL DEFAULT NULL,
  `hp` INT NULL DEFAULT NULL,
  `fuel_tank_cap` INT NULL DEFAULT NULL,
  `seats` INT NULL DEFAULT NULL,
  `transmission` VARCHAR(45) NULL DEFAULT NULL,
  `power_source` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`model_id`),
  CONSTRAINT `fk_model_specs_model1`
    FOREIGN KEY (`model_id`)
    REFERENCES `comp2009assignment1`.`model` (`model_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
