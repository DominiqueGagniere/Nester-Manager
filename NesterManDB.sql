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
  FOREIGN KEY (id_client) REFERENCES nester_man_db.client(id_client),
  FOREIGN KEY (id_instance) REFERENCES nester_man_db.instances(id_instance)
);

-- -----------------------------------------------------
-- Table state_instance 
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS NesterManDB.state_instance (
  id_instance INT NOT NULL,
  state VARCHAR(45) NOT NULL,
  PRIMARY KEY (id_instance),
  FOREIGN KEY (id_instance) REFERENCES nester_man_db.instances(id_instance)
);
-- -----------------------------------------------------
-- Table licence
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS NesterManDB.licence (
  id_instance INT NOT NULL,
  `key` VARCHAR(8) NOT NULL,
  PRIMARY KEY (id_instance),
  FOREIGN KEY (id_instance) REFERENCES nester_man_db.instances(id_instance)
);