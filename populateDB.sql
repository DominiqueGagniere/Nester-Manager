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

INSERT INTO NesterManDB.client (id_client, company_name, company_address, responsible, responsible_email, responsible_phone, contract_expiration)
VALUES 
(1, 'NFL', '345 Park Avenue New York', 'Jeff Crandall', 'jrc2h@virginia.edu', '434-296-7288', CURRENT_DATE),
(2, 'Dallas Cowboys', '1 Cowboys Way, Frisco, TX', 'Jerry Jones', 'j.jones@dallascowboys.com', '+12146892000', CURRENT_DATE),
(3, 'New England Patriots', '1 Patriot Place, Foxborough, MA', 'Robert Kraft', 'r.kraft@patriots.com', '+15083501000', CURRENT_DATE),
(4, 'San Francisco 49ers', '4900 Marie P DeBartolo Way, Santa Clara, CA', 'John York', 'j.york@49ers.com', '+14086494000', CURRENT_DATE),
(5, 'Green Bay Packers', '1265 Lombardi Ave, Green Bay, WI', 'Mark Murphy', 'm.murphy@packers.com', '+19204496790', CURRENT_DATE),
(6, 'Kansas City Chiefs', '1 Arrowhead Dr, Kansas City, MO', 'Clark Hunt', 'c.hunt@chiefs.com', '+18163402100', (CURRENT_DATE - INTERVAL '1 day')::date);

-- -----------------------------------------------------
-- Insertion dans instance_affectation
-- -----------------------------------------------------

DO $$
DECLARE
    client_id INT;
    instance_id INT;
BEGIN
    FOR client_id IN 1..6 LOOP
        FOR instance_id IN 1..2 LOOP
            INSERT INTO NesterManDB.instance_affectation (id_client, id_instance)
            VALUES (client_id, (client_id - 1) * 2 + instance_id);
        END LOOP;
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
('ManReboot'),
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
(20, 'Installation', 'Done', 1, 2, 'Installation successfully done');

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

-----------------------------------------------------
-- Trigger Maintenance 
-- -----------------------------------------------------
CREATE OR REPLACE FUNCTION check_manual_restarts()
RETURNS TRIGGER AS $$
DECLARE
    restart_count INT;
    existing_maintenance INT;
BEGIN
    -- Compter les redémarrages manuels au cours de la dernière année
    SELECT COUNT(*)
    INTO restart_count
    FROM NesterManDB.intervention
    WHERE id_instance = NEW.id_instance
      AND type = 'ManReboot'
      AND date >= NOW() - INTERVAL '1 year';

    -- Vérifier s'il y a déjà une intervention de type Maintenance au cours de la dernière année
    SELECT COUNT(*)
    INTO existing_maintenance
    FROM NesterManDB.intervention
    WHERE id_instance = NEW.id_instance
      AND type = 'Maintenance'
      AND reason = 'Instance has been manually restarted more than 5 times in the past year, please check.'
      AND date >= NOW() - INTERVAL '1 year';

    -- Si le nombre de redémarrages manuels est supérieur ou égal à 5 et qu'aucune intervention de type Maintenance n'existe encore
    IF restart_count >= 5 AND existing_maintenance = 0 THEN
        INSERT INTO NesterManDB.intervention (date, id_instance, type, status, reason)
        VALUES (NOW(), NEW.id_instance, 'Maintenance', 'Planned', 'Instance has been manually restarted more than 5 times in the past year, please check.');
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Recréer le déclencheur
DROP TRIGGER IF EXISTS manual_restart_trigger ON NesterManDB.intervention;

CREATE TRIGGER manual_restart_trigger
AFTER INSERT ON NesterManDB.intervention
FOR EACH ROW
WHEN (NEW.type = 'ManReboot')
EXECUTE FUNCTION check_manual_restarts();

