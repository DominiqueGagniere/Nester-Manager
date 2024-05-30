-- Ajout de données dans les tables harvester et server
DO $$
DECLARE
    i INT;
BEGIN
    FOR i IN 1..10 LOOP
        INSERT INTO "NesterManDB"."harvester" 
            (hostname, mac_addr, ip_lan, ip_wan, serialnum, cpu_name, ram_size_gb, disk_type, disk_size_gb, os_version, harvester_version, idAll_Instance)
        VALUES
            (format('host_harvester_%s', i), format('00:1A:2B:3C:4D:%02s', i), format('192.168.0.%s', i), format('10.0.0.%s', i), i, 'Intel i7', 16, 'SSD', 512, 'Ubuntu 20.04', '1.0', i);
        
        INSERT INTO "NesterManDB"."nester_server" 
            (hostname, mac_addr, ip_lan, ip_wan, serialnum, cpu_name, ram_size_gb, disk_type, disk_size_gb, os_version, harvester_version, idAll_Instance)
        VALUES
            (format('host_server_%s', i), format('00:1A:2B:3C:4D:%02s', i), format('192.168.1.%s', i), format('10.0.1.%s', i), i + 10, 'Intel Xeon', 32, 'HDD', 1024, 'CentOS 7', '2.0', i + 10);
    END LOOP;
END $$;