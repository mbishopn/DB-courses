-- MySQL Script generated by MySQL Workbench
-- Wed Jan 10 17:47:18 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema comp2009_lab1
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `comp2009_lab1` ;

-- -----------------------------------------------------
-- Schema comp2009_lab1
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `comp2009_lab1` DEFAULT CHARACTER SET utf8 ;
USE `comp2009_lab1` ;

-- -----------------------------------------------------
-- Table `comp2009_lab1`.`shopping_cart`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `comp2009_lab1`.`shopping_cart` ;

CREATE TABLE IF NOT EXISTS `comp2009_lab1`.`shopping_cart` (
  `id` INT NOT NULL,
  `user_id` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '		';


-- -----------------------------------------------------
-- Table `comp2009_lab1`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `comp2009_lab1`.`users` ;

CREATE TABLE IF NOT EXISTS `comp2009_lab1`.`users` (
  `id` INT NOT NULL,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `username` VARCHAR(45) NULL,
  `password` VARCHAR(45) NULL,
  `email_address` VARCHAR(45) NULL,
  `registration_date` DATE NULL,
  `user_status` VARCHAR(45) NULL,
  `shopping_cart_id` INT NOT NULL,
  PRIMARY KEY (`id`, `shopping_cart_id`),
  INDEX `fk_users_shopping_cart1_idx` (`shopping_cart_id` ASC) VISIBLE,
  CONSTRAINT `fk_users_shopping_cart1`
    FOREIGN KEY (`shopping_cart_id`)
    REFERENCES `comp2009_lab1`.`shopping_cart` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '						';


-- -----------------------------------------------------
-- Table `comp2009_lab1`.`categories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `comp2009_lab1`.`categories` ;

CREATE TABLE IF NOT EXISTS `comp2009_lab1`.`categories` (
  `id` INT NOT NULL,
  `category_name` VARCHAR(45) NULL,
  `date_added` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '			';


-- -----------------------------------------------------
-- Table `comp2009_lab1`.`products`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `comp2009_lab1`.`products` ;

CREATE TABLE IF NOT EXISTS `comp2009_lab1`.`products` (
  `id` INT NOT NULL,
  `product_name` VARCHAR(45) NULL,
  `price` VARCHAR(45) NULL,
  `date_added` DATE NULL,
  `categories_id` INT NOT NULL,
  PRIMARY KEY (`id`, `categories_id`),
  INDEX `fk_products_categories1_idx` (`categories_id` ASC) VISIBLE,
  CONSTRAINT `fk_products_categories1`
    FOREIGN KEY (`categories_id`)
    REFERENCES `comp2009_lab1`.`categories` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '			';


-- -----------------------------------------------------
-- Table `comp2009_lab1`.`cart_content`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `comp2009_lab1`.`cart_content` ;

CREATE TABLE IF NOT EXISTS `comp2009_lab1`.`cart_content` (
  `id` INT NOT NULL,
  `cart_id` INT NULL,
  `product_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cart_content_shopping_cart1_idx` (`cart_id` ASC) VISIBLE,
  CONSTRAINT `fk_cart_content_shopping_cart1`
    FOREIGN KEY (`cart_id`)
    REFERENCES `comp2009_lab1`.`shopping_cart` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
