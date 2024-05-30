-- -----------------------------------------------------
-- Schema NesterManDB
-- -----------------------------------------------------
CREATE ROLE mspr WITH LOGIN PASSWORD 'MSPR';
CREATE SCHEMA IF NOT EXISTS `NesterManDB` AUTHORIZATION mspr;
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

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
