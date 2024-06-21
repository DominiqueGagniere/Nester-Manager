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
  company_name VARCHAR(25) NOT NULL,
  company_address VARCHAR(65) NOT NULL,
  responsible VARCHAR(45) NOT NULL,
  responsible_email VARCHAR(45) NOT NULL,
  responsible_phone VARCHAR(13) NOT NULL
);

-- -----------------------------------------------------
-- Table instance_status  
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS NesterManDB.instance_status (
  id_instance INT NOT NULL,
  status VARCHAR(25) NOT NULL,
  PRIMARY KEY (id_instance),
  FOREIGN KEY (id_instance) REFERENCES NesterManDB.instance(id_instance)
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
  PRIMARY KEY (type)
);

-- -----------------------------------------------------
-- Table tech
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS NesterManDB.tech (
  id_tech SERIAL,
  name VARCHAR(30) NOT NULL,
  last_name VARCHAR(45) NOT NULL,
  email VARCHAR(30) NOT NULL,
  phone VARCHAR(45) NOT NULL,
  service VARCHAR(20) NOT NULL,
  PRIMARY KEY (id_tech)
);

-- -----------------------------------------------------
-- Table installer
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS NesterManDB.installer (
  id_installer SERIAL,
  company_name VARCHAR(30) NOT NULL,
  company_hq_address VARCHAR(55) NOT NULL,
  contact_name VARCHAR(30) NOT NULL,
  duns VARCHAR(8) NOT NULL,
  PRIMARY KEY (id_installer)
);
-- -----------------------------------------------------
-- Table intervention_status
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS NesterManDB.intervention_status (
  status VARCHAR(30) NOT NULL,
  PRIMARY KEY (status)
);


-- -----------------------------------------------------
-- Table intervention
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS NesterManDB.intervention (
  id_intervention SERIAL,
  id_instance INT NOT NULL,
  type VARCHAR(20) NOT NULL,
  status VARCHAR(20) NOT NULL,
  id_tech INT,
  id_installer INT,
  reason VARCHAR(100) NOT NULL,
  PRIMARY KEY (id_intervention),
  FOREIGN KEY (type) REFERENCES NesterManDB.intervention_type(type),
  FOREIGN KEY (status) REFERENCES NesterManDB.intervention_status(status),
  FOREIGN KEY (id_tech) REFERENCES NesterManDB.tech(id_tech),
  FOREIGN KEY (id_instance) REFERENCES NesterManDB.instance(id_instance)
);