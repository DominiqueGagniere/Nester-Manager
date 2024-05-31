-- Create role
CREATE ROLE mspr WITH LOGIN PASSWORD 'MSPR';

-- Create schema
CREATE SCHEMA IF NOT EXISTS "NesterManDB" AUTHORIZATION mspr;

-- Create client table
CREATE TABLE IF NOT EXISTS "NesterManDB"."client" (
    id_client INT PRIMARY KEY,
    company_name VARCHAR(100),
    company_address VARCHAR(255),
    responsible VARCHAR(100),
    responsible_email VARCHAR(100),
    responsible_phone VARCHAR(20)
);

-- Create instance table
CREATE TABLE IF NOT EXISTS "NesterManDB"."instance" (
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

-- Create harvester table
CREATE TABLE IF NOT EXISTS "NesterManDB"."harvester" (
    harvester_version VARCHAR(15) NOT NULL
) INHERITS ("NesterManDB"."instance");

-- Create nester_server table
CREATE TABLE IF NOT EXISTS "NesterManDB"."nester_server" (
    nester_version VARCHAR(15) NOT NULL
) INHERITS ("NesterManDB"."instance");

-- Create instance_affectation table
CREATE TABLE IF NOT EXISTS "NesterManDB"."instance_affectation" (
    id_client INT NOT NULL,
    id_instance INT NOT NULL,
    CONSTRAINT fk_client
        FOREIGN KEY (id_client) REFERENCES "NesterManDB"."client"(id_client),
    CONSTRAINT fk_instance
        FOREIGN KEY (id_instance) REFERENCES "NesterManDB"."instance"(id_instance)
);

-- Populate client table
INSERT INTO "NesterManDB"."client" (id_client, company_name, company_address, responsible, responsible_email, responsible_phone)
VALUES 
    (1, 'NFL', '345 Park Avenue New York', 'Jeff Crandall', 'jrc2h@virginia.edu', '434-296-7288'),
    (2, 'ARESIA Inc', '3498-3414 13th St NW Washington', 'Alain Thevenot', 'at@alesia.com', '+12124567890');

-- Ensure instance table is populated
INSERT INTO "NesterManDB"."instance" (hostname, mac_addr, ip_lan, ip_wan, serialnum, cpu_name, ram_size_gb, disk_type, disk_size_gb, os_version, harvester_version, nester_version)
VALUES
    ('host_harvester_1', '00:1A:2B:3C:4D:01', '192.168.0.1', '10.0.0.1', 1, 'Intel i7', 16, 'SSD', 512, 'Ubuntu 20.04', '1.0', NULL),
    ('host_harvester_2', '00:1A:2B:3C:4D:02', '192.168.0.2', '10.0.0.2', 2, 'Intel i7', 16, 'SSD', 512, 'Ubuntu 20.04', '1.0', NULL),
    ('host_harvester_3', '00:1A:2B:3C:4D:03', '192.168.0.3', '10.0.0.3', 3, 'Intel i7', 16, 'SSD', 512, 'Ubuntu 20.04', '1.0', NULL),
    ('host_harvester_4', '00:1A:2B:3C:4D:04', '192.168.0.4', '10.0.0.4', 4, 'Intel i7', 16, 'SSD', 512, 'Ubuntu 20.04', '1.0', NULL),
    ('host_harvester_5', '00:1A:2B:3C:4D:05', '192.168.0.5', '10.0.0.5', 5, 'Intel i7', 16, 'SSD', 512, 'Ubuntu 20.04', '1.0', NULL),
    ('host_harvester_6', '00:1A:2B:3C:4D:06', '192.168.0.6', '10.0.0.6', 6, 'Intel i7', 16, 'SSD', 512, 'Ubuntu 20.04', '1.0', NULL),
    ('host_harvester_7', '00:1A:2B:3C:4D:07', '192.168.0.7', '10.0.0.7', 7, 'Intel i7', 16, 'SSD', 512, 'Ubuntu 20.04', '1.0', NULL),
    ('host_harvester_8', '00:1A:2B:3C:4D:08', '192.168.0.8', '10.0.0.8', 8, 'Intel i7', 16, 'SSD', 512, 'Ubuntu 20.04', '1.0', NULL);

-- Ensure harvester and nester_server tables are populated
DO $$
DECLARE
    i INT;
BEGIN
    FOR i IN 1..8 LOOP
        INSERT INTO "NesterManDB"."harvester" 
            (id_instance, hostname, mac_addr, ip_lan, ip_wan, serialnum, cpu_name, ram_size_gb, disk_type, disk_size_gb, os_version, harvester_version)
        VALUES
            (i, format('host_harvester_%s', i), format('00:1A:2B:3C:4D:%02s', i), format('192.168.0.%s', i), format('10.0.0.%s', i), i, 'Intel i7', 16, 'SSD', 512, 'Ubuntu 20.04', '1.0');
    END LOOP;

    FOR i IN 9..16 LOOP
        INSERT INTO "NesterManDB"."nester_server" 
            (id_instance, hostname, mac_addr, ip_lan, ip_wan, serialnum, cpu_name, ram_size_gb, disk_type, disk_size_gb, os_version, nester_version)
        VALUES
            (i, format('host_server_%s', i-8), format('00:1A:2B:3C:4D:%02s', i-8), format('192.168.1.%s', i-8), format('10.0.1.%s', i-8), i, 'Intel Xeon', 32, 'HDD', 1024, 'CentOS 7', '2.0');
    END LOOP;
END $$;

-- Populate instance_affectation table
DO $$
DECLARE
    i INT;
BEGIN
    FOR i IN 1..8 LOOP
        INSERT INTO "NesterManDB"."instance_affectation" 
            (id_client, id_instance)
        VALUES
            (1, i);
    END LOOP;

    FOR i IN 9..16 LOOP
        INSERT INTO "NesterManDB"."instance_affectation" 
            (id_client, id_instance)
        VALUES
            (2, i);
    END LOOP;
END $$;
