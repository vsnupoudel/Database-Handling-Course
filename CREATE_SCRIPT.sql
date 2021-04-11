-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema WESH
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `WESH` ;

-- -----------------------------------------------------
-- Schema WESH
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `WESH` DEFAULT CHARACTER SET utf8 ;
USE `WESH` ;

-- -----------------------------------------------------
-- Table `WESH`.`operators_details`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `WESH`.`operators_details` ;

CREATE TABLE IF NOT EXISTS `WESH`.`operators_details` (
  `OperatorID` INT NOT NULL AUTO_INCREMENT,
  `operator_name` VARCHAR(100) NULL,
  `operator_role` VARCHAR(45) NULL,
  PRIMARY KEY (`OperatorID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WESH`.`test_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `WESH`.`test_group` ;

CREATE TABLE IF NOT EXISTS `WESH`.`test_group` (
  `test_group_ID` INT NOT NULL AUTO_INCREMENT,
  `test_group_name` VARCHAR(100) NULL,
  PRIMARY KEY (`test_group_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WESH`.`test_description`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `WESH`.`test_description` ;

CREATE TABLE IF NOT EXISTS `WESH`.`test_description` (
  `test_id` INT NOT NULL AUTO_INCREMENT,
  `test_group_test_group_ID` INT NOT NULL,
  `test_name` VARCHAR(22) NULL DEFAULT NULL,
  `test_description` VARCHAR(649) NULL DEFAULT NULL,
  PRIMARY KEY (`test_id`, `test_group_test_group_ID`),
  CONSTRAINT `fk_test_groups_test_group1`
    FOREIGN KEY (`test_group_test_group_ID`)
    REFERENCES `WESH`.`test_group` (`test_group_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `WESH`.`samples_taken`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `WESH`.`samples_taken` ;

CREATE TABLE IF NOT EXISTS `WESH`.`samples_taken` (
  `sample_ID` BIGINT NOT NULL  AUTO_INCREMENT,
  `test_group_test_group_ID` INT NOT NULL,
  `operators_details_OperatorID` INT NULL,
  `sample time` VARCHAR(19) NULL DEFAULT NULL,
  PRIMARY KEY (`sample_ID`),
  CONSTRAINT `fk_samples_taken_operators_details`
    FOREIGN KEY (`operators_details_OperatorID`)
    REFERENCES `WESH`.`operators_details` (`OperatorID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_samples_taken_test_group1`
    FOREIGN KEY (`test_group_test_group_ID`)
    REFERENCES `WESH`.`test_group` (`test_group_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_samples_taken_test_group1_idx` ON `WESH`.`samples_taken` (`test_group_test_group_ID` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `WESH`.`analysis_done`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `WESH`.`analysis_done` ;

CREATE TABLE IF NOT EXISTS `WESH`.`analysis_done` (
  `analysis_id` INT(2) NOT NULL AUTO_INCREMENT,
  `operators_details_OperatorID` INT NOT NULL,
  `test_description_test_id` INT(1) NOT NULL,
  `samples_taken_sample_ID` BIGINT NOT NULL,
  `analysis_result` DECIMAL(4,1) NULL DEFAULT NULL,
  `analysis_time` DATETIME NULL,
  PRIMARY KEY (`analysis_id`),
  CONSTRAINT `fk_analysis_done_operators_details1`
    FOREIGN KEY (`operators_details_OperatorID`)
    REFERENCES `WESH`.`operators_details` (`OperatorID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_analysis_done_test_description2`
    FOREIGN KEY (`test_description_test_id`)
    REFERENCES `WESH`.`test_description` (`test_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_analysis_done_samples_taken1`
    FOREIGN KEY (`samples_taken_sample_ID`)
    REFERENCES `WESH`.`samples_taken` (`sample_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_analysis_done_operators_details1_idx` ON `WESH`.`analysis_done` (`operators_details_OperatorID` ASC) VISIBLE;

CREATE INDEX `fk_analysis_done_test_description2_idx` ON `WESH`.`analysis_done` (`test_description_test_id` ASC) VISIBLE;

CREATE INDEX `fk_analysis_done_samples_taken1_idx` ON `WESH`.`analysis_done` (`samples_taken_sample_ID` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `WESH`.`BarCode_Gen`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `WESH`.`BarCode_Gen` ;

CREATE TABLE IF NOT EXISTS `WESH`.`BarCode_Gen` (
  `Sample_Bar_Code` BIGINT NOT NULL AUTO_INCREMENT,
  `samples_taken_sample_ID` BIGINT NOT NULL,
  PRIMARY KEY (`Sample_Bar_Code`, `samples_taken_sample_ID`),
  CONSTRAINT `fk_BarCode_Gen_samples_taken1`
    FOREIGN KEY (`samples_taken_sample_ID`)
    REFERENCES `WESH`.`samples_taken` (`sample_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE INDEX `fk_BarCode_Gen_samples_taken1_idx` ON `WESH`.`BarCode_Gen` (`samples_taken_sample_ID` ASC) VISIBLE;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
