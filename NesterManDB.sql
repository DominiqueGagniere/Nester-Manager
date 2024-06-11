-- -----------------------------------------------------
-- Schema NesterManDB
-- -----------------------------------------------------
CREATE ROLE mspr WITH LOGIN PASSWORD 'MSPR';
CREATE SCHEMA IF NOT EXISTS NesterManDB AUTHORIZATION mspr;

-- -----------------------------------------------------
-- Table instance
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS nester_man_db.instances (
  id_instance SERIAL PRIMARY KEY,
  id_harvester INT,
  id_nester_server INT,
  FOREIGN KEY (id_harvester) REFERENCES nester_man_db.harvester(id_harvester),
  FOREIGN KEY (id_nester_server) REFERENCES nester_man_db.nester_server(id_nester_server)
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
CREATE TABLE IF NOT EXISTS nester_man_db.instance_affectation (
  id_client INT NOT NULL,
  id_instance INT NOT NULL,
  PRIMARY KEY (id_client, id_instance),
  FOREIGN KEY (id_client) REFERENCES nester_man_db.client(id_client),
  FOREIGN KEY (id_instance) REFERENCES nester_man_db.instances(id_instance)
);