CREATE EXTENSION pgcrypto;
DO $$
DECLARE
    i INT;
BEGIN
    FOR i IN 1..10 LOOP
        INSERT INTO NesterManDB.instance 
            (hostname, mac_addr, ip_lan, ip_wan, serialnum, cpu_name, ram_size_gb, disk_type, disk_size_gb, os_version, harvester_version)
        VALUES
            (format('host_harvester_%s', i), format('00:1A:2B:3C:4D:%02s', i), format('192.168.0.%s', i), format('10.0.0.%s', i), i, 'Intel i7', 16, 'SSD', 512, 'Ubuntu 20.04', '1.0');
        
        INSERT INTO NesterManDB.instance 
            (hostname, mac_addr, ip_lan, ip_wan, serialnum, cpu_name, ram_size_gb, disk_type, disk_size_gb, os_version, nester_version)
        VALUES
            (format('host_server_%s', i), format('00:1A:2B:3C:4D:%02s', i), format('192.168.1.%s', i), format('10.0.1.%s', i), i + 10, 'Intel Xeon', 32, 'HDD', 1024, 'CentOS 7', '2.0');
    END LOOP;
END $$;

INSERT INTO NesterManDB.client (id_client, company_name, company_address, responsible, responsible_email, responsible_phone)
VALUES 
(1, 'NFL', '345 Park Avenue New York', 'Jeff Crandall', 'jrc2h@virginia.edu', '434-296-7288'),
(2, 'ARESIA Inc', '3498-3414 13th St NW Washington', 'Alain Thevenot', 'at@alesia.net', '+12124567890');

-- -----------------------------------------------------
-- Insertion dans instance_affectation
-- -----------------------------------------------------
INSERT INTO NesterManDB.instance_affectation (id_client, id_instance)
VALUES 
(1, 1),
(1, 2),
(2, 2);

-- -----------------------------------------------------
-- Insertion dans instance_affectation
-- -----------------------------------------------------

DO $$
DECLARE
    i INT;
BEGIN
    FOR i IN 1..10 LOOP
        INSERT INTO NesterManDB.state_instance (id_instance, state)
        VALUES (i * 2 - 1, 'OK'),  -- Utiliser une séquence pour éviter les doublons
               (i * 2, 'KO');      -- Utiliser une séquence pour éviter les doublons
    END LOOP;
END $$;


-- -----------------------------------------------------
-- Insertion dans intervention_type
-- -----------------------------------------------------
INSERT INTO NesterManDB.intervention_type (type)
VALUES 
('Maintenance'),
('Incident'),
('Request'),
('Installation'), 
('Update');

-- -----------------------------------------------------
-- Insertion dans intervention_status
-- -----------------------------------------------------
INSERT INTO NesterManDB.intervention_status (status)
VALUES 
('Cancel'),
('Planned'),
('Postponed'),
('Done'), 
('Fail');

-- -----------------------------------------------------
-- Insertion dans tech
-- -----------------------------------------------------

INSERT INTO NesterManDB.tech (name, last_name, email, phone, service)
VALUES 
('Romain', 'Templier', 'rt@nfl.us', '+12124567890', 'Engineering'),
('Dominique', 'Gagniere', 'dg@nfl.us', '+12124567890', 'Maintenance');

-- -----------------------------------------------------
-- Insertion dans installer
-- -----------------------------------------------------

INSERT INTO NesterManDB.installer (company_name, company_hq_address, contact_name, duns)
VALUES 
('NFL', '345 Park Avenue, 5th Floor, New York, NY 10154', 'Roger Stokoe Goodell', 15048378),
('Zero Install', '12, Rue de la Paix, 75002 Paris', 'Maximilien Perrin', 15048378);

-- -----------------------------------------------------
-- Insertion dans intervention
-- -----------------------------------------------------

INSERT INTO NesterManDB.intervention (id_instance, type, status, id_tech, id_installer, reason)
VALUES
(7, 'Maintenance', 'Postponed', 2, 1, 'No documentation for the error, need to contact the developers'),
(20, 'Installation', 'Done', 1, 2, 'Installation successfully done')

-----------------------------------------------------
-- Insertion dans licence
-- -----------------------------------------------------

DO $$
DECLARE
    i INT;
    random_key TEXT;
BEGIN
    FOR i IN 1..20 LOOP
        random_key := substring(md5(random()::text), 1, 8);
        INSERT INTO NesterManDB.licence (id_instance, key)
        VALUES (i, random_key);
    END LOOP;
END $$;

