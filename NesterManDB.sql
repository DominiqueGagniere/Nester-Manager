-- -----------------------------------------------------
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

-- -----------------------------------------------------
-- Table harvester
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS NesterManDB.harvester (
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
) INHERITS (NesterManDB.instance);

-- -----------------------------------------------------
-- Table nester_server
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS NesterManDB.nester_server (
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
  nester_version VARCHAR(15) NOT NULL
) INHERITS (NesterManDB.instance);

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
  CONSTRAINT fk_instance_affectation_instance1_idx
    FOREIGN KEY (id_instance)
    REFERENCES NesterManDB.instance (id_instance)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_instance_affectation_client1
    FOREIGN KEY (id_client)
    REFERENCES NesterManDB.client (id_client)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);