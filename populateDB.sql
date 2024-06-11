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
    FOR i IN 1..20 LOOP
        INSERT INTO NesterManDB.state_instance (id_instance, state)
        VALUES (i * 2 - 1, 'OK'),  -- Utiliser une séquence pour éviter les doublons
               (i * 2, 'KO');      -- Utiliser une séquence pour éviter les doublons
    END LOOP;
END $$;
