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
-- Table `NesterManDB`.`instance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NesterManDB`.`instance` (
  `idAll_Instance` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idAll_Instance`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NesterManDB`.`harvester`
-- -----------------------------------------------------
CREATE TABLE "NesterManDB"."harvester" (
    hostname VARCHAR(45) NOT NULL,
    mac_addr VARCHAR(17) NOT NULL,
    ip_lan VARCHAR(45) NOT NULL,
    ip_wan VARCHAR(45) NOT NULL,
    serialnum INT NOT NULL,
    cpu_name VARCHAR(45) NOT NULL,
    ram_size_gb INT NOT NULL,
    disk_type VARCHAR(45) NOT NULL,
    disk_size_gb INT NOT NULL,
    os_version VARCHAR(15) NOT NULL,
    harvester_version VARCHAR(15) NOT NULL
) INHERITS ("NesterManDB"."instance");

-- -----------------------------------------------------
-- Table `NesterManDB`.`nester_server`
-- -----------------------------------------------------
CREATE TABLE "NesterManDB"."nester_server" (
    hostname VARCHAR(45) NOT NULL,
    mac_addr VARCHAR(17) NOT NULL,
    ip_lan VARCHAR(45) NOT NULL,
    ip_wan VARCHAR(45) NOT NULL,
    serialnum INT NOT NULL,
    cpu_name VARCHAR(45) NOT NULL,
    ram_size_gb INT NOT NULL,
    disk_type VARCHAR(45) NOT NULL,
    disk_size_gb INT NOT NULL,
    os_version VARCHAR(15) NOT NULL,
    harvester_version VARCHAR(15) NOT NULL
) INHERITS ("NesterManDB"."instance");

-- -----------------------------------------------------
-- Table `NesterManDB`.`state_instance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NesterManDB`.`state_instance` (
  `All_Instance_idAll_Instance` INT NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`All_Instance_idAll_Instance`),
  INDEX `fk_State_Instance_All_Instance1_idx` (`All_Instance_idAll_Instance` ASC) VISIBLE,
  CONSTRAINT `fk_State_Instance_All_Instance1`
    FOREIGN KEY (`All_Instance_idAll_Instance`)
    REFERENCES `NesterManDB`.`instance` (`idAll_Instance`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NesterManDB`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NesterManDB`.`client` (
  `All_Instance_idAll_Instance` INT NOT NULL,
  `company_name` VARCHAR(45) NOT NULL,
  `company_address` VARCHAR(45) NOT NULL,
  `responsible` VARCHAR(45) NOT NULL,
  `responsible_email` VARCHAR(45) NOT NULL,
  `responsible_phone` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`All_Instance_idAll_Instance`))
ENGINE = InnoDB;





-- -----------------------------------------------------
-- Table `NesterManDB`.`intervention_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NesterManDB`.`intervention_status` (
  `idIntervention` INT NOT NULL AUTO_INCREMENT,
  `DateTime` DATETIME(50) NOT NULL,
  `Status` TINYINT NOT NULL,
  PRIMARY KEY (`idIntervention`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NesterManDB`.`tech`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NesterManDB`.`tech` (
  `idTech_ID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(30) NOT NULL,
  `Lastname` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(30) NOT NULL,
  `Phone` VARCHAR(45) NOT NULL,
  `Service` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`idTech_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NesterManDB`.`licence`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NesterManDB`.`licence` (
  `All_Instance_idAll_Instance` INT NOT NULL,
  `key` VARCHAR(8) NOT NULL,
  PRIMARY KEY (`All_Instance_idAll_Instance`),
  INDEX `fk_Licence_Key_All_Instance1_idx` (`All_Instance_idAll_Instance` ASC) VISIBLE,
  CONSTRAINT `fk_Licence_Key_All_Instance1`
    FOREIGN KEY (`All_Instance_idAll_Instance`)
    REFERENCES `NesterManDB`.`instance` (`idAll_Instance`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NesterManDB`.`intervention_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NesterManDB`.`intervention_type` (
  `type` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`type`),
  UNIQUE INDEX `type_UNIQUE` (`type` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NesterManDB`.`installer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NesterManDB`.`installer` (
  `idinstaller` INT NOT NULL AUTO_INCREMENT,
  `company_name` VARCHAR(45) NOT NULL,
  `company_ho_address` VARCHAR(45) NOT NULL,
  `contact_name` VARCHAR(45) NOT NULL,
  `siret` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`idinstaller`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NesterManDB`.`intervention`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NesterManDB`.`intervention` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `intervention_type_type` VARCHAR(20) NOT NULL,
  `intervention_status_idIntervention` INT NOT NULL,
  `Tech_ID_idTech_ID` INT NULL,
  `installer_idinstaller` INT NULL,
  `customer_affectation_All_Instance_idAll_Instance` INT NULL,
  `reason` VARCHAR(70) NOT NULL,
  PRIMARY KEY (`id`, `intervention_type_type`, `intervention_status_idIntervention`, `Tech_ID_idTech_ID`, `installer_idinstaller`, `customer_affectation_All_Instance_idAll_Instance`),
  INDEX `fk_intervention_intervention_type1_idx` (`intervention_type_type` ASC) VISIBLE,
  INDEX `fk_intervention_intervention_status1_idx` (`intervention_status_idIntervention` ASC) VISIBLE,
  INDEX `fk_intervention_Tech_ID1_idx` (`Tech_ID_idTech_ID` ASC) VISIBLE,
  INDEX `fk_intervention_installer1_idx` (`installer_idinstaller` ASC) VISIBLE,
  INDEX `fk_intervention_customer_affectation1_idx` (`customer_affectation_All_Instance_idAll_Instance` ASC) VISIBLE,
  CONSTRAINT `fk_intervention_intervention_type1`
    FOREIGN KEY (`intervention_type_type`)
    REFERENCES `NesterManDB`.`intervention_type` (`type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_intervention_intervention_status1`
    FOREIGN KEY (`intervention_status_idIntervention`)
    REFERENCES `NesterManDB`.`intervention_status` (`idIntervention`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_intervention_Tech_ID1`
    FOREIGN KEY (`Tech_ID_idTech_ID`)
    REFERENCES `NesterManDB`.`tech` (`idTech_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_intervention_installer1`
    FOREIGN KEY (`installer_idinstaller`)
    REFERENCES `NesterManDB`.`installer` (`idinstaller`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_intervention_customer_affectation1`
    FOREIGN KEY (`customer_affectation_All_Instance_idAll_Instance`)
    REFERENCES `NesterManDB`.`client` (`All_Instance_idAll_Instance`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NesterManDB`.`instance_affectation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NesterManDB`.`instance_affectation` (
  `client_All_Instance_idAll_Instance` INT NOT NULL,
  `instance_idAll_Instance` INT NOT NULL,
  PRIMARY KEY (`client_All_Instance_idAll_Instance`, `instance_idAll_Instance`),
  INDEX `fk_instance_affectation_instance1_idx` (`instance_idAll_Instance` ASC) VISIBLE,
  CONSTRAINT `fk_instance_affectation_client1`
    FOREIGN KEY (`client_All_Instance_idAll_Instance`)
    REFERENCES `NesterManDB`.`client` (`All_Instance_idAll_Instance`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_instance_affectation_instance1`
    FOREIGN KEY (`instance_idAll_Instance`)
    REFERENCES `NesterManDB`.`instance` (`idAll_Instance`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
