-- -----------------------------------------------------
-- Schema NesterManDB
-- -----------------------------------------------------
CREATE ROLE mspr WITH LOGIN PASSWORD 'MSPR';
CREATE SCHEMA IF NOT EXISTS "NesterManDB" AUTHORIZATION mspr;

-- -----------------------------------------------------
-- Table instance
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS "NesterManDB"."instance" (
  idAll_Instance SERIAL PRIMARY KEY,
  hostname VARCHAR(45) NOT NULL
);

-- -----------------------------------------------------
-- Table harvester
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS "NesterManDB"."harvester" (
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
-- Table nester_server
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS "NesterManDB"."nester_server" (
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