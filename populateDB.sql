-- Ajout de données dans les tables harvester et server
DO $$
DECLARE
    i INT;
BEGIN
    FOR i IN 1..10 LOOP
        INSERT INTO "NesterManDB"."harvester" 
            (hostname, mac_addr, ip_lan, ip_wan, serialnum, cpu_name, ram_size_gb, disk_type, disk_size_gb, os_version, harvester_version, id_instance)
        VALUES
            (format('host_harvester_%s', i), format('00:1A:2B:3C:4D:%02s', i), format('192.168.0.%s', i), format('10.0.0.%s', i), i, 'Intel i7', 16, 'SSD', 512, 'Ubuntu 20.04', '1.0', i);
        
        INSERT INTO "NesterManDB"."nester_server" 
            (hostname, mac_addr, ip_lan, ip_wan, serialnum, cpu_name, ram_size_gb, disk_type, disk_size_gb, os_version, nester_version, id_instance)
        VALUES
            (format('host_server_%s', i), format('00:1A:2B:3C:4D:%02s', i), format('192.168.1.%s', i), format('10.0.1.%s', i), i + 10, 'Intel Xeon', 32, 'HDD', 1024, 'CentOS 7', '2.0', i + 10);
    END LOOP;
END $$;

-- INSERT INTO "NesterManDB"."harvester" 
-- (hostname, mac_addr, ip_lan, ip_wan, serialnum, cpu_name, ram_size_gb, disk_type, disk_size_gb, os_version, harvester_version)
-- VALUES 
-- ('host_harvester_1', '00:1A:2B:3C:4D:03', '192.168.0.1', '10.0.0.1', '1', 'Intel i7', 16, 'SSD', 512, 'Ubuntu 20.04', '1.0');

-- INSERT INTO "NesterManDB"."nester_server" 
-- (hostname, mac_addr, ip_lan, ip_wan, serialnum, cpu_name, ram_size_gb, disk_type, disk_size_gb, os_version, nester_version)
-- VALUES 
-- ('Nester_1', '00:1A:2B:3C:4D:03', '192.168.0.1', '10.0.0.1', '1', 'Intel i7', 16, 'SSD', 512, 'Ubuntu 20.04', '1.0');


-- -- Ajout des clients
-- INSERT INTO "NesterManDB"."client" (id_client, company_name, company_address, responsible, responsible_email, responsible_phone)
-- VALUES (1, 'NFL', '345 Park Avenue New York', 'Jeff Crandall', 'jrc2h@virginia.edu', '434-296-7288'),
--        (2, 'ARESIA Inc', '3498-3414 13th St NW Washington', 'Alain Thevenot', 'at@alesia.net', '+12124567890');


/* -- Association des licences aux clients 
DO $$
DECLARE
    i INT;
BEGIN
    FOR i IN 1..10 LOOP
        INSERT INTO "NesterManDB"."instance_affectation" 
            (id_client, id_instance)
        VALUES
            (1, i);
    END LOOP;
    FOR i IN 11..20 LOOP
        INSERT INTO "NesterManDB"."instance_affectation" 
            (id_client, id_instance)
        VALUES
            (2, i);
    END LOOP;
END $$;
 */
-- INSERT INTO "NesterManDB"."instance_affectation" (id_client, id_instance)
-- VALUES (1,1),
--        (1,2);
    



-- -- -----------------------------------------------------
-- -- Insertion des données initiales
-- -- -----------------------------------------------------
-- INSERT INTO NesterManDB.instance (hostname, mac_addr, ip_lan, ip_wan, serialnum, cpu_name, ram_size_gb, disk_type, disk_size_gb, os_version, harvester_version, nester_version)
-- VALUES 
-- ('host_harvester_1', '00:1A:2B:3C:4D:03', '192.168.0.1', '10.0.0.1', 1, 'Intel i7', 16, 'SSD', 512, 'Ubuntu 20.04', '1.0', NULL),
-- ('Nester_1', '00:1A:2B:3C:4D:04', '192.168.0.2', '10.0.0.2', 2, 'Intel i7', 16, 'SSD', 512, 'Ubuntu 20.04', NULL, '1.0');

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
