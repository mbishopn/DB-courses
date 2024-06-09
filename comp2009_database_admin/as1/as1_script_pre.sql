-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema COMP2009Assignment1
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema COMP2009Assignment1
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `COMP2009Assignment1` DEFAULT CHARACTER SET utf8 ;
USE `COMP2009Assignment1` ;

-- -----------------------------------------------------
-- Table `COMP2009Assignment1`.`manufacturer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `COMP2009Assignment1`.`manufacturer` (
  `code` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `address` VARCHAR(45) NULL,
  `phone` VARCHAR(45) NULL,
  `acc_number` VARCHAR(45) NULL,
  PRIMARY KEY (`code`),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC) VISIBLE)
ENGINE = InnoDB
COMMENT = '		';


-- -----------------------------------------------------
-- Table `COMP2009Assignment1`.`brand`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `COMP2009Assignment1`.`brand` (
  `brand_name` VARCHAR(45) NOT NULL,
  `quality` INT NOT NULL,
  `manufacturer` INT NOT NULL,
  PRIMARY KEY (`brand_name`, `quality`),
  INDEX `manufacturer_idx` (`manufacturer` ASC) VISIBLE,
  CONSTRAINT `manufacturer`
    FOREIGN KEY (`manufacturer`)
    REFERENCES `COMP2009Assignment1`.`manufacturer` (`code`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `COMP2009Assignment1`.`model`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `COMP2009Assignment1`.`model` (
  `model_id` INT NOT NULL,
  `cylinders` VARCHAR(45) NULL,
  `hp` INT NULL,
  `price_suggested` DECIMAL(5,2) NULL,
  `price_store` DECIMAL(5,2) NULL,
  `fuel_tank_cap` INT NULL,
  `seats` INT NULL,
  `manufacture_date` DATETIME NULL,
  `transmission` VARCHAR(45) NULL,
  `power_source` VARCHAR(45) NULL,
  `brand` VARCHAR(45) NULL,
  `brand` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`model_id`),
  INDEX `brand_idx` (`brand` ASC) VISIBLE,
  CONSTRAINT `brand`
    FOREIGN KEY (`brand`)
    REFERENCES `COMP2009Assignment1`.`brand` (`brand_name`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `COMP2009Assignment1`.`quality`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `COMP2009Assignment1`.`quality` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `desc` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
