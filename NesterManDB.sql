-- Create schema
CREATE ROLE mspr WITH LOGIN PASSWORD 'MSPR';
CREATE SCHEMA IF NOT EXISTS "NesterManDB" AUTHORIZATION mspr;
SET search_path TO "NesterManDB";

-- Table All_Instance
CREATE TABLE IF NOT EXISTS "All_Instance" (
  "idAll_Instance" SERIAL PRIMARY KEY
);

-- Table List_Harvester
CREATE TABLE IF NOT EXISTS "List_Harvester" (
  "Hostname" VARCHAR(45) NOT NULL,
  "All_Instance_idAll_Instance" INT NOT NULL,
  "LAN_IP" VARCHAR(45) NOT NULL,
  PRIMARY KEY ("All_Instance_idAll_Instance"),
  CONSTRAINT "fk_List_Harvester_All_Instance1"
    FOREIGN KEY ("All_Instance_idAll_Instance")
    REFERENCES "All_Instance" ("idAll_Instance")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

-- Table State_Instance
CREATE TABLE IF NOT EXISTS "State_Instance" (
  "idState_Instance" INT NOT NULL,
  "state" VARCHAR(45) NOT NULL,
  "List_Harvester_idList_Harvester" INT NOT NULL,
  "All_Instance_idAll_Instance" INT NOT NULL,
  PRIMARY KEY ("idState_Instance", "All_Instance_idAll_Instance"),
  CONSTRAINT "fk_State_Instance_All_Instance1"
    FOREIGN KEY ("All_Instance_idAll_Instance")
    REFERENCES "All_Instance" ("idAll_Instance")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

-- Table Customer_Affectation
CREATE TABLE IF NOT EXISTS "Customer_Affectation" (
  "idCustomer_Affectation" INT NOT NULL,
  "Company_name" VARCHAR(45) NOT NULL,
  "Adress" VARCHAR(45) NOT NULL,
  "Responsible" VARCHAR(45) NOT NULL,
  "Responsible_email" VARCHAR(45) NOT NULL,
  "Responsible_phone" VARCHAR(45) NOT NULL,
  "All_Instance_idAll_Instance" INT NOT NULL,
  PRIMARY KEY ("idCustomer_Affectation", "All_Instance_idAll_Instance"),
  CONSTRAINT "fk_Customer_Affectation_All_Instance1"
    FOREIGN KEY ("All_Instance_idAll_Instance")
    REFERENCES "All_Instance" ("idAll_Instance")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

-- Table NesterServer_TechInfo
CREATE TABLE IF NOT EXISTS "NesterServer_TechInfo" (
  "Hostname" VARCHAR(45) NOT NULL,
  "LAN_IP" VARCHAR(45) NOT NULL,
  "MAC" VARCHAR(17) NOT NULL,
  "WAN_IP" VARCHAR(45) NOT NULL,
  "SerialNum" INT NOT NULL,
  "All_Instance_idAll_Instance" INT NOT NULL,
  PRIMARY KEY ("All_Instance_idAll_Instance"),
  CONSTRAINT "fk_NesterServer_TechInfo_All_Instance1"
    FOREIGN KEY ("All_Instance_idAll_Instance")
    REFERENCES "All_Instance" ("idAll_Instance")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

-- Table Tech_ID
CREATE TABLE IF NOT EXISTS "Tech_ID" (
  "idTech_ID" SERIAL PRIMARY KEY,
  "Name" VARCHAR(45) NOT NULL,
  "Lastname" VARCHAR(45) NOT NULL,
  "Email" VARCHAR(45) NOT NULL,
  "Phone" VARCHAR(45) NOT NULL
);

-- Table Intervention
CREATE TABLE IF NOT EXISTS "Intervention" (
  "idIntervention" SERIAL NOT NULL,
  "DateTime" TIMESTAMP NOT NULL,
  "Status" SMALLINT NOT NULL,
  "Tech_ID_idTech_ID" INT NOT NULL,
  "All_Instance_idAll_Instance" INT NOT NULL,
  PRIMARY KEY ("idIntervention", "Tech_ID_idTech_ID", "All_Instance_idAll_Instance"),
  CONSTRAINT "fk_Intervention_Tech_ID1"
    FOREIGN KEY ("Tech_ID_idTech_ID")
    REFERENCES "Tech_ID" ("idTech_ID")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT "fk_Intervention_All_Instance1"
    FOREIGN KEY ("All_Instance_idAll_Instance")
    REFERENCES "All_Instance" ("idAll_Instance")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

-- Table Licence_Key
CREATE TABLE IF NOT EXISTS "Licence_Key" (
  "idLicence_Key" SERIAL NOT NULL,
  "Licence_Keycol" VARCHAR(45) NOT NULL,
  "All_Instance_idAll_Instance" INT NOT NULL,
  PRIMARY KEY ("idLicence_Key", "All_Instance_idAll_Instance"),
  CONSTRAINT "fk_Licence_Key_All_Instance1"
    FOREIGN KEY ("All_Instance_idAll_Instance")
    REFERENCES "All_Instance" ("idAll_Instance")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);
