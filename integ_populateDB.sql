-- Ajout de données dans les tables harvester et server
DO $$
DECLARE
    i INT;
BEGIN
    FOR i IN 1..10 LOOP
        INSERT INTO "NesterManDB"."harvester" 
            (hostname, mac_addr, ip_lan, ip_wan, serialnum, cpu_name, ram_size_gb, disk_type, disk_size_gb, os_version, harvester_version, instance_idAll_Instance)
        VALUES
            (format('host_harvester_%s', i), format('00:1A:2B:3C:4D:%02s', i), format('192.168.0.%s', i), format('10.0.0.%s', i), i, 'Intel i7', 16, 'SSD', 512, 'Ubuntu 20.04', '1.0', i);
        
        INSERT INTO "NesterManDB"."nester_server" 
            (hostname, mac_addr, ip_lan, ip_wan, serialnum, cpu_name, ram_size_gb, disk_type, disk_size_gb, os_version, harvester_version, instance_idAll_Instance)
        VALUES
            (format('host_server_%s', i), format('00:1A:2B:3C:4D:%02s', i), format('192.168.1.%s', i), format('10.0.1.%s', i), i + 10, 'Intel Xeon', 32, 'HDD', 1024, 'CentOS 7', '2.0', i + 10);
    END LOOP;
END $$;


-- Ajout de données dans la table state_instance
INSERT INTO "NesterManDB"."state_instance" (All_Instance_idAll_Instance, state) VALUES
(1, 'ok'),
(2, 'nok'),
(3, 'decommissioning'),
(4, 'stop'),
(5, 'ok'),
(6, 'nok'),
(7, 'decommissioning'),
(8, 'stop'),
(9, 'ok'),
(10, 'nok'),
(11, 'stop'),
(12, 'stop'),
(13, 'stop'),
(14, 'stop'),
(15, 'ok'),
(16, 'stop'),
(17, 'ok'),
(18, 'decommissioning'),
(19, 'ok'),
(20, 'ok');

-- Ajout de données dans la table client
INSERT INTO "NesterManDB"."client" (name) VALUES
('NFL'),
('Zero Software');

-- Ajout de données dans la table intervention_status
INSERT INTO "NesterManDB"."intervention_status" (status, date, outcome) VALUES
('Echec', CURRENT_DATE - INTERVAL '1 day', 'Failure'),
('Successful', CURRENT_DATE, 'Success');

-- Ajout de données dans la table tech
INSERT INTO "NesterManDB"."tech" (name, expertise) VALUES
('Tech1', 'Hardware'),
('Tech2', 'Software');

-- Ajout de données dans la table license
INSERT INTO "NesterManDB"."license" (license_key) VALUES
('12345678');

-- Ajout de données dans la table intervention_type
INSERT INTO "NesterManDB"."intervention_type" (type) VALUES
('Installation'),
('Update'),
('Maintenance'),
('Incident'),
('Request');

-- Ajout de données dans la table installer
INSERT INTO "NesterManDB"."installer" (name) VALUES
('Installer 1'),
('InstallerPro');

-- Ajout de données dans les tables harvester et server
DO $$
DECLARE
    i INT;
BEGIN
    FOR i IN 1..10 LOOP
        INSERT INTO "NesterManDB"."harvester" 
            (hostname, mac_addr, ip_lan, ip_wan, serialnum, cpu_name, ram_size_gb, disk_type, disk_size_gb, os_version, harvester_version, instance_idAll_Instance)
        VALUES
            (format('host_harvester_%s', i), format('00:1A:2B:3C:4D:%02s', i), format('192.168.0.%s', i), format('10.0.0.%s', i), i, 'Intel i7', 16, 'SSD', 512, 'Ubuntu 20.04', '1.0', i);
        
        INSERT INTO "NesterManDB"."server" 
            (hostname, mac_addr, ip_lan, ip_wan, serialnum, cpu_name, ram_size_gb, disk_type, disk_size_gb, os_version, harvester_version, instance_idAll_Instance)
        VALUES
            (format('host_server_%s', i), format('00:1A:2B:3C:4D:%02s', i), format('192.168.1.%s', i), format('10.0.1.%s', i), i + 10, 'Intel Xeon', 32, 'HDD', 1024, 'CentOS 7', '2.0', i + 10);
    END LOOP;
END $$;

-- Ajout de données dans la table intervention
INSERT INTO "NesterManDB"."intervention" 
    (reason, date, intervention_status_id, intervention_type_id, installer_id, instance_idAll_Instance)
VALUES
    ('Routine check', CURRENT_DATE - INTERVAL '1 day', 1, 1, 1, 1),
    ('Software upgrade', CURRENT_DATE, 2, 2, 2, 2);
