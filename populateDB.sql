-- Switch to the NesterManDB schema
SET search_path TO "NesterManDB";

-- Inserting test entries into Nester_server
DO $$
BEGIN
    FOR i IN 1..10 LOOP
        INSERT INTO "Nester_server" (server_name, server_ip, server_location)
        VALUES (
            'Server' || i, 
            '192.168.1.' || i, 
            'Location' || i
        );
    END LOOP;
END $$;

-- Inserting test entries into harvester
DO $$
BEGIN
    FOR i IN 1..10 LOOP
        INSERT INTO "harvester" (
            hostname, mac_addr, ip_lan, ip_wan, serialnum, cpu_name, ram_size_gb, 
            disk_type, disk_size_gb, os_version, harvester_version, instance_idAll_Instance
        ) VALUES (
            'Host' || i,
            '00:1B:44:11:3A:B' || LPAD(i::text, 2, '0'),
            '10.0.0.' || i,
            '172.16.0.' || i,
            i,
            'CPU' || i,
            8 + i,  -- varying RAM sizes
            'SSD',
            256 + i * 10,  -- varying disk sizes
            'v1.0',
            'v1.0',
            1  -- assuming instance_idAll_Instance exists
        );
    END LOOP;
END $$;

-- Inserting test clients into client
INSERT INTO "client" (client_name) VALUES ('NFL'), ('Zero Soft');

-- Inserting test intervention types into intervention_type
INSERT INTO "intervention_type" (type_name) 
VALUES ('Installation'), ('Mise à jour'), ('Maintenance'), ('Incident'), ('Demande');

-- Inserting test techs into tech
INSERT INTO "tech" (tech_name) 
VALUES ('Dominique Gagnière'), ('Evan Michon'), ('Romain Templier'), ('Samuelle Mccalla');

-- Inserting test interventions into intervention
INSERT INTO "intervention" (client_id, intervention_type_id, tech_id, start_time, end_time, status)
VALUES
    ((SELECT client_id FROM "client" WHERE client_name = 'NFL'), 
     (SELECT intervention_type_id FROM intervention_type WHERE type_name = 'Installation'), 
     (SELECT tech_id FROM tech ORDER BY RANDOM() LIMIT 1),
     NOW() - INTERVAL '1 day', NOW(), 'Resolved'),
    ((SELECT client_id FROM "client" WHERE client_name = 'Zero Soft'), 
     (SELECT intervention_type_id FROM intervention_type WHERE type_name = 'Maintenance'), 
     (SELECT tech_id FROM tech ORDER BY RANDOM() LIMIT 1),
     NOW() - INTERVAL '2 days', NOW() - INTERVAL '1 day', 'Unresolved');
