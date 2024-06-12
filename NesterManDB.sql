-- Schema NesterManDB
-- -----------------------------------------------------
CREATE ROLE mspr WITH LOGIN PASSWORD 'MSPR';
CREATE SCHEMA IF NOT EXISTS NesterManDB AUTHORIZATION mspr;
-- -----------------------------------------------------
-- Table instance
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS NesterManDB.instance (
  id_instance SERIAL PRIMARY KEY,
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
  harvester_version VARCHAR(15),
  nester_version VARCHAR(15)
);

CREATE TABLE IF NOT EXISTS NesterManDB.client (
  id_client INT PRIMARY KEY,
  company_name VARCHAR(45) NOT NULL,
  company_address VARCHAR(45) NOT NULL,
  responsible VARCHAR(45) NOT NULL,
  responsible_email VARCHAR(45) NOT NULL,
  responsible_phone VARCHAR(45) NOT NULL
);

-- -----------------------------------------------------
-- Table instance_affectation
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS NesterManDB.instance_affectation (
  id_client INT NOT NULL,
  id_instance INT NOT NULL,
  PRIMARY KEY (id_client, id_instance),
  FOREIGN KEY (id_client) REFERENCES NesterManDB.client(id_client),
  FOREIGN KEY (id_instance) REFERENCES NesterManDB.instance(id_instance)
);

-- -----------------------------------------------------
-- Table state_instance 
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS NesterManDB.state_instance (
  id_instance INT NOT NULL,
  state VARCHAR(45) NOT NULL,
  PRIMARY KEY (id_instance),
  FOREIGN KEY (id_instance) REFERENCES NesterManDB.instance(id_instance)
);
-- -----------------------------------------------------
-- Table licence
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS NesterManDB.licence (
  id_instance INT NOT NULL,
  key VARCHAR(8) NOT NULL,
  PRIMARY KEY (id_instance),
  FOREIGN KEY (id_instance) REFERENCES NesterManDB.instance(id_instance)
);

-- -----------------------------------------------------
-- Table intervention_type
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS NesterManDB.intervention_type (
  type VARCHAR(20) NOT NULL,
  PRIMARY KEY (type),
);

-- -----------------------------------------------------
-- Table tech
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS NesterManDB.tech (
  id_tech INT SERIAL,
  Name VARCHAR(30) NOT NULL,
  Lastname VARCHAR(45) NOT NULL,
  Email VARCHAR(30) NOT NULL,
  Phone VARCHAR(45) NOT NULL,
  Service VARCHAR(20) NOT NULL,
  PRIMARY KEY (id_tech),
)

-- -----------------------------------------------------
-- Table installer
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS NesterManDB.installer (
  id_installer SERIAL INT,
  company_name VARCHAR(30) NOT NULL,
  company_hq_address VARCHAR(55) NOT NULL,
  contact_name VARCHAR(30) NOT NULL,
  duns VARCHAR(8) NOT NULL,
  PRIMARY KEY (id_installer),
)

-- -----------------------------------------------------
-- Table intervention
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS NesterManDB.intervention (
  id_intervention SERIAL INT,
  type VARCHAR(20) NOT NULL,
  status VARCHAR(20) NOT NULL,
  id_tech INT NOT NULL,
  id_installer INT,
  PRIMARY KEY (id_intervention),
  FOREIGN KEY (type) REFERENCES NesterManDB.intervention_type(type),
  FOREIGN KEY (status) REFERENCES NesterManDB.intervention_status(status),
  FOREIGN KEY (id_tech) REFERENCES NesterManDB.tech(id_tech),
  

  `customer_affectation_All_Instance_idAll_Instance` INT NOT NULL,
  `reason` VARCHAR(70) NOT NULL,
  `intervention_status_Status` TINYINT NOT NULL,
  PRIMARY KEY (`id`, `intervention_type_type`, `intervention_status_idIntervention`, `Tech_ID_idTech_ID`, `installer_idinstaller`, `customer_affectation_All_Instance_idAll_Instance`, `intervention_status_Status`),
  INDEX `fk_intervention_intervention_type1_idx` (`intervention_type_type` ASC) VISIBLE,
  INDEX `fk_intervention_Tech_ID1_idx` (`Tech_ID_idTech_ID` ASC) VISIBLE,
  INDEX `fk_intervention_installer1_idx` (`installer_idinstaller` ASC) VISIBLE,
  INDEX `fk_intervention_customer_affectation1_idx` (`customer_affectation_All_Instance_idAll_Instance` ASC) VISIBLE,
  INDEX `fk_intervention_intervention_status1_idx` (`intervention_status_Status` ASC) VISIBLE,
  CONSTRAINT `fk_intervention_intervention_type1`
    FOREIGN KEY (`intervention_type_type`)
    REFERENCES `NesterManDB`.`intervention_type` (`type`)
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
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_intervention_intervention_status1`
    FOREIGN KEY (`intervention_status_Status`)
    REFERENCES `NesterManDB`.`intervention_status` (`Status`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)