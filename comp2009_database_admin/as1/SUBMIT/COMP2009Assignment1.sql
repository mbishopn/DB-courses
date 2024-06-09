
-- MySQL Workbench Forward Engineering
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
-- -----------------------------------------------------
-- Schema comp2009assignment1
-- -----------------------------------------------------
DROP DATABASE IF EXISTS `comp2009assignment1`;
CREATE SCHEMA IF NOT EXISTS `comp2009assignment1` DEFAULT CHARACTER SET utf8mb4 ;
USE `comp2009assignment1` ;
-- -----------------------------------------------------
-- Table `comp2009assignment1`.`manufacturer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `comp2009assignment1`.`manufacturer` (
  `code` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `address` VARCHAR(60) NULL DEFAULT NULL,
  `phone` VARCHAR(45) NULL DEFAULT NULL,
  `acc_number` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`code`),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COMMENT = '		';
-- -----------------------------------------------------
-- Table `comp2009assignment1`.`quality`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `comp2009assignment1`.`quality` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;
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
DEFAULT CHARACTER SET = utf8mb4;
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
DEFAULT CHARACTER SET = utf8mb4;
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
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

/*************************************************************************************
					Step 2 - Insert data into the tables
*************************************************************************************/
INSERT INTO manufacturer (name,address,phone,acc_number)
VALUES
("RENAULT-NISSAN-MITSUBISHI ALLIANCE","2605 Brookdale Ave, Cornwall, ON","(613)933-7555","111-654615-546"),
("HYUNDAI","2655 Brookdale Ave, Cornwall, ON","(613)937-3433","222-654615-546"),
("HONDA","2660 Brookdale Ave, Cornwall, ON","+1 800-933-7555","333-654615-546"),
("FORD","744 Pitt St, Cornwall, ON","(613)932-2584","444-654615-546"),
("VOLKSWAGEN","632 Pitt St, Cornwall","(613)933-3483","555-654615-546"),
("STELLANTIS","2205 Vincent Massey Dr, Cornwall, ON","(613)938-0934","666-654615-546"),
("GENERAL MOTORS","2695 Brookdale Ave, Cornwall, ON","+1 855-933-3559","777-654615-546"),
("BMW GROUP","1040 Ogilvie Rd, Gloucester, ON","(613)749-7700","888-654615-546"),
("TOYOTA","1875 Brookdale Ave, Cornwall, ON","(613)932-1106","999-654615-546"),
("DAIMLER","2680 Matheson Blvd East, Suite 500 Mississauga, ON","(613)749-7700","101-654615-546"),
("ASTON MARTIN","8225 Décarie, Montreal, Quebec","1-833-906-1405 ","111-654615-546");

INSERT INTO quality (description)
VALUES ("Economy"),("Premium"),("Luxury");

INSERT INTO brand (brand_name,quality_id,manufacturer)
VALUES
("VW",1,5),
("BENTLEY",3,5),
("PORSCHE",3,5),
("LAMBORGHINI",3,5),
("AUDI",2,5),
("BMW",2,8),
("MINI",2,8),
("ROLLS ROYCE",2,8),
("CHRYSLER",1,6),
("DODGE",1,6),
("ALFA ROMEO",2,6),
("JEEP",1,6),
("FIAT",2,6),
("LINCOLN",2,4),
("FORD",1,4),
("HONDA",1,3),
("ACURA",2,3),
("NISSAN",1,1),
("MITSUBISHI",1,1),
("INFINITY",2,1),
("TOYOTA",1,9),
("LEXUS",2,9),
("HYUNDAI",1,2),
("KIA",1,2),
("GENESIS",2,2),
("CHEVROLET",1,7),
("GMC",1,7),
("CADILLAC",2,7),
("MERCEDES",3,10),
("ASTON MARTIN",3,11);

INSERT INTO model (model_name,brand,manufacture_date,price_suggested,price_store)
VALUES
("JETTA TSI TRENDLINE","VW","2024-01-01",26160,23544),
("JETTA 2.0 GLI 40TH ANNIV EDITION","VW","2024-01-01",27560,24804),
("GOLF GTI","VW","2024-01-01",37360,33624),
("TIGUAN","VW","2024-01-01",37210,33489),
("ID.4 S","VW","2024-01-01",51210,46089),
("CONTINENTAL GT A","BENTLEY","2024-01-01",352500,387750),
("BENTAYGA V8","BENTLEY","2024-01-01",245900,270490),
("BENTAYGA HYBRID","BENTLEY","2024-01-01",245900,270490),
("CAYENNE","PORSCHE","2024-01-01",89800,98780),
("CAYENNE HYBRID","PORSCHE","2024-01-01",104800,115280),
("TAYCAN TURBO S CROSS TURISMO","PORSCHE","2024-01-01",229500,252450),
("HURACAN EVO COUPE","LAMBORGHINI","2023-01-01",250150,275165),
("Q5 KOMFORT S TRONIC","AUDI","2024-01-01",50465,55511.5),
("A5 PROGRESSIV S TRONIC","AUDI","2022-01-01",55850,61435),
("230I XDRIVE COUPE","BMW","2020-01-01",43750,48125),
("X3 XDRIVE30i","BMW","2023-01-01",55200,60720),
("COUNTRYMAN S ALL4","MINI","2025-01-01",45990,50589),
("JOHN COOPER WORKS CONVERTIBLE","MINI","2024-01-01",47890,52679),
("PHANTOM EWB","ROLLS ROYCE","2023-01-01",676150,743765),
("DBS COUPE","ASTON MARTIN","2023-01-01",391600,430760),
("TONALE VELOCE AWD","ALFA ROMEO","2024-01-01",47995,52794.5),
("CHALLENGER SXT","DODGE","2022-01-01",38665,42531.5),
("CIVIC TOURING CVT","HONDA","2024-01-01",34500,32775),
("HR-V LX AWD","HONDA","2023-01-01",31030,29478.5),
("ILX PREMIUM A-SPEC","ACURA","2022-01-01",35400,38940),
("VERSA S MT","NISSAN","2022-01-01",16898,16898),
("LEAF S PLUS","NISSAN","2022-01-01",40098,40098),
("MIRAGE ES 5MT","MITSUBISHI","2023-01-01",14298,12868.2),
("Q50 PURE","INFINITY","2024-01-01",46395,46395),
("COROLLA L","TOYOTA","2024-01-01",23490,22315.5),
("UX 250h","LEXUS","2024-01-01",42300,44415),
("MAYBACH S 680","MERCEDES","2023-01-01",301500,286425),
("ELANTRA ESSENTIAL","HYUNDAI","2024-01-01",21999,20899.05),
("RIO LX","KIA","2022-01-01",17395,16525.25),
("G90 e-SC","GENESIS","2023-01-01",115000,109250),
("SPARK LS","CHEVROLET","2022-01-01",10398,9878.1),
("BOLT EV","CHEVROLET","2023-01-01",38943,38943),
("TRANSIT CONNECT WAGON XL","FORD","2022-01-01",34615,32884),
("OUTLANDER ES","MITSUBISHI","2023-01-01",32698,31063);

INSERT INTO model_specs (model_id,cylinders,hp,fuel_tank_cap,seats,transmission,power_source)
VALUES
(1,4,158,50,5,"MT","GASOLINE"),
(2,4,184,50,5,"AT","GASOLINE"),
(3,4,241,50,5,"AT","GASOLINE"),
(4,4,184,60,5,"AT","GASOLINE"),
(5,0,201,0,5,"E","ELECTRIC"),
(6,8,542,90,4,"AT/MT","PETROL"),
(7,8,542,85,5,"AT","GASOLINE"),
(8,6,449,75,5,"AT","HYBRID"),
(9,6,348,90,5,"AT","GASOLINE"),
(10,6,463,75,5,"AT","HYBRID"),
(11,0,751,0,4,"AT","ELECTRIC"),
(12,10,602,83,2,"AT/MT","GASOLINE"),
(13,4,201,70,5,"AT","HYBRID"),
(14,4,261,58,4,"AT","HYBRID"),
(15,4,248,52,4,"AT","GASOLINE"),
(16,4,248,65,5,"AT","GASOLINE"),
(17,4,241,61,5,"AT","GASOLINE"),
(18,4,228,44,4,"AT","GASOLINE"),
(19,12,563,90,5,"AT/MT","GASOLINE"),
(20,12,715,78,4,"AT/MT","GASOLINE"),
(21,4,280,55,5,"AT","GASOLINE"),
(22,6,303,70,5,"AT","GASOLINE"),
(23,4,180,47,5,"AT","GASOLINE"),
(24,4,158,53,5,"AT","GASOLINE"),
(25,4,201,50,5,"AT","GASOLINE"),
(26,4,122,41,5,"MT","GASOLINE"),
(27,0,214,0,5,"AT","ELECTRIC"),
(28,3,78,35,5,"MT","GASOLINE"),
(29,6,300,76,5,"AT/MT","GASOLINE"),
(30,4,169,47,5,"AT","GASOLINE"),
(31,4,181,40,5,"AT","HYBRID"),
(32,12,621,76,5,"AT/MT","GASOLINE"),
(33,4,147,47,5,"AT","GASOLINE"),
(34,4,120,45,5,"MT","GASOLINE"),
(35,6,409,73,5,"AT/MT","HYBRID"),
(36,4,98,35,4,"MT","GASOLINE"),
(37,0,200,0,5,"AT","ELECTRIC"),
(38,4,162,60,6,"AT","GASOLINE"),
(39,4,181,55,7,"AT","GASOLINE");

/*******************************************************************************
                  Step 3  - Create queries and views

1. Create a view to list all large-capacity vehicles that can seat 5 or more
   people. Display brand name, model number, retail price, and seating capacity
********************************************************************************/
CREATE VIEW five_seat_plus_cars AS
SELECT 
	m.model_id AS ID,
	b.brand_name AS Brand,
    m.model_name AS Model,
    m.price_store AS "Retail price",
    ms.seats AS Seats
FROM model m, brand b, model_specs ms
WHERE
	m.brand = b.brand_name AND
    m.model_id = ms.model_id AND
    ms.seats>=5;
    
/*******************************************************************************
 2. Create a view to hybrid cars and their retail price
********************************************************************************/
CREATE VIEW hybrid_cars AS
SELECT
	m.model_name AS Model,
    m.price_store AS "Retail price" 
FROM model m, model_specs ms
WHERE
	m.model_id=ms.model_id AND
    ms.power_source = 'hybrid';
    
/*******************************************************************************
 3. Generate a list of manufacturers and the number of brands each have
********************************************************************************/
SELECT 
m.name AS Manufacturer,
count(b.brand_name) as "Number of brands"
FROM brand b, manufacturer m
WHERE b.manufacturer=m.code
GROUP BY manufacturer;

/*******************************************************************************
 4. Generate a list of manufacturers (company name), their brand names, and brand
    model names, and power source. Sort alphabetically by company name, brand  --
    name, and model name
********************************************************************************/
SELECT
	man.name AS Manufacturer,
    m.brand AS Brand,
    m.model_name AS Model,
    ms.power_source AS "Power Source"
FROM
	model m, brand b, manufacturer man, model_specs ms
WHERE
	m.brand=b.brand_name AND
    b.manufacturer=man.code AND
    m.model_id=ms.model_id
ORDER BY
	man.name, m.brand, m.model_name;

/*******************************************************************************
 5. Create a view to display model number, retail price and the store's actual -
    retail price for models that are $35,000 or less.
********************************************************************************/  
CREATE VIEW cheap_cars AS
SELECT
	m.model_id AS ID,
    m.model_name AS Model,
    m.price_suggested AS "Suggested retail price",
	m.price_store AS "Store retail price"
FROM model m
WHERE m.price_store<35000;

/*******************************************************************************
 6. Update retail prices of cars that are $35,000 or less. Due to shortages in -
    manufacturer’s shipping routes, retail price will increase by 20% for all --
    retail prices $35,000 or less. Use the view you created in previous step.
********************************************************************************/
UPDATE model a
INNER JOIN (SELECT ID from cheap_cars) b 
ON A.MODEL_ID=B.ID
SET a.price_store = a.price_store*1.2;
