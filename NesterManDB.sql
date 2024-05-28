-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema NesterManDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema NesterManDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `NesterManDB` DEFAULT CHARACTER SET utf8 ;
USE `NesterManDB` ;

-- -----------------------------------------------------
-- Table `NesterManDB`.`All_Instance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NesterManDB`.`All_Instance` (
  `idAll_Instance` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idAll_Instance`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NesterManDB`.`List_Harvester`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NesterManDB`.`List_Harvester` (
  `Hostname` VARCHAR(45) NOT NULL,
  `All_Instance_idAll_Instance` INT NOT NULL,
  `LAN_IP` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`All_Instance_idAll_Instance`),
  INDEX `fk_List_Harvester_All_Instance1_idx` (`All_Instance_idAll_Instance` ASC) VISIBLE,
  CONSTRAINT `fk_List_Harvester_All_Instance1`
    FOREIGN KEY (`All_Instance_idAll_Instance`)
    REFERENCES `NesterManDB`.`All_Instance` (`idAll_Instance`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NesterManDB`.`State_Instance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NesterManDB`.`State_Instance` (
  `idState_Instance` INT NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `List_Harvester_idList_Harvester` INT NOT NULL,
  `All_Instance_idAll_Instance` INT NOT NULL,
  PRIMARY KEY (`idState_Instance`, `All_Instance_idAll_Instance`),
  INDEX `fk_State_Instance_All_Instance1_idx` (`All_Instance_idAll_Instance` ASC) VISIBLE,
  CONSTRAINT `fk_State_Instance_All_Instance1`
    FOREIGN KEY (`All_Instance_idAll_Instance`)
    REFERENCES `NesterManDB`.`All_Instance` (`idAll_Instance`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NesterManDB`.`Customer_Affectation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NesterManDB`.`Customer_Affectation` (
  `idCustomer_Affectation` INT NOT NULL,
  `Company_name` VARCHAR(45) NOT NULL,
  `Adress` VARCHAR(45) NOT NULL,
  `Responsible` VARCHAR(45) NOT NULL,
  `Responsible_email` VARCHAR(45) NOT NULL,
  `Responsible_phone` VARCHAR(45) NOT NULL,
  `All_Instance_idAll_Instance` INT NOT NULL,
  PRIMARY KEY (`idCustomer_Affectation`, `All_Instance_idAll_Instance`),
  INDEX `fk_Customer_Affectation_All_Instance1_idx` (`All_Instance_idAll_Instance` ASC) VISIBLE,
  CONSTRAINT `fk_Customer_Affectation_All_Instance1`
    FOREIGN KEY (`All_Instance_idAll_Instance`)
    REFERENCES `NesterManDB`.`All_Instance` (`idAll_Instance`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NesterManDB`.`NesterServer_TechInfo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NesterManDB`.`NesterServer_TechInfo` (
  `Hostname` VARCHAR(45) NOT NULL,
  `LAN_IP` VARCHAR(45) NOT NULL,
  `MAC` VARCHAR(17) NOT NULL,
  `WAN_IP` VARCHAR(45) NOT NULL,
  `SerialNum` INT NOT NULL,
  `All_Instance_idAll_Instance` INT NOT NULL,
  PRIMARY KEY (`All_Instance_idAll_Instance`),
  INDEX `fk_NesterServer_TechInfo_All_Instance1_idx` (`All_Instance_idAll_Instance` ASC) VISIBLE,
  CONSTRAINT `fk_NesterServer_TechInfo_All_Instance1`
    FOREIGN KEY (`All_Instance_idAll_Instance`)
    REFERENCES `NesterManDB`.`All_Instance` (`idAll_Instance`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NesterManDB`.`Tech_ID`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NesterManDB`.`Tech_ID` (
  `idTech_ID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Lastname` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `Phone` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTech_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NesterManDB`.`Intervention`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NesterManDB`.`Intervention` (
  `idIntervention` INT NOT NULL AUTO_INCREMENT,
  `DateTime` DATETIME(50) NOT NULL,
  `Status` TINYINT NOT NULL,
  `Tech_ID_idTech_ID` INT NOT NULL,
  `All_Instance_idAll_Instance` INT NOT NULL,
  PRIMARY KEY (`idIntervention`, `Tech_ID_idTech_ID`, `All_Instance_idAll_Instance`),
  INDEX `fk_Intervention_Tech_ID1_idx` (`Tech_ID_idTech_ID` ASC) VISIBLE,
  INDEX `fk_Intervention_All_Instance1_idx` (`All_Instance_idAll_Instance` ASC) VISIBLE,
  CONSTRAINT `fk_Intervention_Tech_ID1`
    FOREIGN KEY (`Tech_ID_idTech_ID`)
    REFERENCES `NesterManDB`.`Tech_ID` (`idTech_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Intervention_All_Instance1`
    FOREIGN KEY (`All_Instance_idAll_Instance`)
    REFERENCES `NesterManDB`.`All_Instance` (`idAll_Instance`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NesterManDB`.`Licence_Key`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NesterManDB`.`Licence_Key` (
  `idLicence_Key` INT NOT NULL AUTO_INCREMENT,
  `Licence_Keycol` VARCHAR(45) NOT NULL,
  `All_Instance_idAll_Instance` INT NOT NULL,
  PRIMARY KEY (`idLicence_Key`, `All_Instance_idAll_Instance`),
  INDEX `fk_Licence_Key_All_Instance1_idx` (`All_Instance_idAll_Instance` ASC) VISIBLE,
  CONSTRAINT `fk_Licence_Key_All_Instance1`
    FOREIGN KEY (`All_Instance_idAll_Instance`)
    REFERENCES `NesterManDB`.`All_Instance` (`idAll_Instance`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
