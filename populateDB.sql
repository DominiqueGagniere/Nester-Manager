-- Use the NesterManDB schema
USE NesterManDB;

-- Insert data into All_Instance table (10 instances total)
INSERT INTO All_Instance () VALUES ();
INSERT INTO All_Instance () VALUES ();
INSERT INTO All_Instance () VALUES ();
INSERT INTO All_Instance () VALUES ();
INSERT INTO All_Instance () VALUES ();
INSERT INTO All_Instance () VALUES ();
INSERT INTO All_Instance () VALUES ();
INSERT INTO All_Instance () VALUES ();
INSERT INTO All_Instance () VALUES ();
INSERT INTO All_Instance () VALUES ();

-- Insert data into List_Harvester table (1 harvester per client final)
INSERT INTO List_Harvester (Hostname, All_Instance_idAll_Instance, LAN_IP) VALUES ('Harvester1', 1, '192.168.1.1');
INSERT INTO List_Harvester (Hostname, All_Instance_idAll_Instance, LAN_IP) VALUES ('Harvester2', 2, '192.168.1.2');
INSERT INTO List_Harvester (Hostname, All_Instance_idAll_Instance, LAN_IP) VALUES ('Harvester3', 3, '192.168.1.3');
INSERT INTO List_Harvester (Hostname, All_Instance_idAll_Instance, LAN_IP) VALUES ('Harvester4', 4, '192.168.1.4');
INSERT INTO List_Harvester (Hostname, All_Instance_idAll_Instance, LAN_IP) VALUES ('Harvester5', 5, '192.168.1.5');
INSERT INTO List_Harvester (Hostname, All_Instance_idAll_Instance, LAN_IP) VALUES ('Harvester6', 6, '192.168.1.6');
INSERT INTO List_Harvester (Hostname, All_Instance_idAll_Instance, LAN_IP) VALUES ('Harvester7', 7, '192.168.1.7');
INSERT INTO List_Harvester (Hostname, All_Instance_idAll_Instance, LAN_IP) VALUES ('Harvester8', 8, '192.168.1.8');
INSERT INTO List_Harvester (Hostname, All_Instance_idAll_Instance, LAN_IP) VALUES ('Harvester9', 9, '192.168.1.9');
INSERT INTO List_Harvester (Hostname, All_Instance_idAll_Instance, LAN_IP) VALUES ('Harvester10', 10, '192.168.1.10');

-- Insert data into Customer_Affectation table (5 clients, each with 2 client finals, making 10 client finals total)
INSERT INTO Customer_Affectation (idCustomer_Affectation, Company_name, Adress, Responsible, Responsible_email, Responsible_phone, All_Instance_idAll_Instance) VALUES 
(1, 'Presta1_Client1', 'Address1', 'Resp1', 'resp1@company1.com', '1234567890', 1),
(2, 'Presta1_Client2', 'Address2', 'Resp2', 'resp2@company2.com', '1234567891', 2),
(3, 'Presta2_Client1', 'Address3', 'Resp3', 'resp3@company3.com', '1234567892', 3),
(4, 'Presta2_Client2', 'Address4', 'Resp4', 'resp4@company4.com', '1234567893', 4),
(5, 'Presta3_Client1', 'Address5', 'Resp5', 'resp5@company5.com', '1234567894', 5),
(6, 'Presta3_Client2', 'Address6', 'Resp6', 'resp6@company6.com', '1234567895', 6),
(7, 'Presta4_Client1', 'Address7', 'Resp7', 'resp7@company7.com', '1234567896', 7),
(8, 'Presta4_Client2', 'Address8', 'Resp8', 'resp8@company8.com', '1234567897', 8),
(9, 'Presta5_Client1', 'Address9', 'Resp9', 'resp9@company9.com', '1234567898', 9),
(10, 'Presta5_Client2', 'Address10', 'Resp10', 'resp10@company10.com', '1234567899', 10);

-- Insert data into Tech_ID table (2 different technicians)
INSERT INTO Tech_ID (Name, Lastname, Email, Phone) VALUES ('Tech1', 'Lastname1', 'tech1@example.com', '9876543210');
INSERT INTO Tech_ID (Name, Lastname, Email, Phone) VALUES ('Tech2', 'Lastname2', 'tech2@example.com', '9876543211');

-- Insert data into Intervention table (2 instances with incidents)
INSERT INTO Intervention (DateTime, Status, Tech_ID_idTech_ID, All_Instance_idAll_Instance) VALUES 
('2023-01-01 10:00:00', 1, 1, 1),
('2023-01-02 11:00:00', 1, 2, 2);

-- Insert data into State_Instance table (1 instance with material to be recovered)
INSERT INTO State_Instance (idState_Instance, state, List_Harvester_idList_Harvester, All_Instance_idAll_Instance) VALUES 
(1, 'material to be recovered', 1, 1);

-- Insert data into NesterServer_TechInfo table (Assuming all instances have corresponding server tech info)
INSERT INTO NesterServer_TechInfo (Hostname, LAN_IP, MAC, WAN_IP, SerialNum, All_Instance_idAll_Instance) VALUES 
('NesterServer1', '192.168.0.1', '00:14:22:01:23:45', '10.0.0.1', 1001, 1),
('NesterServer2', '192.168.0.2', '00:14:22:01:23:46', '10.0.0.2', 1002, 2),
('NesterServer3', '192.168.0.3', '00:14:22:01:23:47', '10.0.0.3', 1003, 3),
('NesterServer4', '192.168.0.4', '00:14:22:01:23:48', '10.0.0.4', 1004, 4),
('NesterServer5', '192.168.0.5', '00:14:22:01:23:49', '10.0.0.5', 1005, 5),
('NesterServer6', '192.168.0.6', '00:14:22:01:23:50', '10.0.0.6', 1006, 6),
('NesterServer7', '192.168.0.7', '00:14:22:01:23:51', '10.0.0.7', 1007, 7),
('NesterServer8', '192.168.0.8', '00:14:22:01:23:52', '10.0.0.8', 1008, 8),
('NesterServer9', '192.168.0.9', '00:14:22:01:23:53', '10.0.0.9', 1009, 9),
('NesterServer10', '192.168.0.10', '00:14:22:01:23:54', '10.0.0.10', 1010, 10);

-- Insert data into Licence_Key table
INSERT INTO Licence_Key (Licence_Keycol, All_Instance_idAll_Instance) VALUES ('LIC1234567890', 1);
INSERT INTO Licence_Key (Licence_Keycol, All_Instance_idAll_Instance) VALUES ('LIC1234567891', 2);
INSERT INTO Licence_Key (Licence_Keycol, All_Instance_idAll_Instance) VALUES ('LIC1234567892', 3);
INSERT INTO Licence_Key (Licence_Keycol, All_Instance_idAll_Instance) VALUES ('LIC1234567893', 4);
INSERT INTO Licence_Key (Licence_Keycol, All_Instance_idAll_Instance) VALUES ('LIC1234567894', 5);
INSERT INTO Licence_Key (Licence_Keycol, All_Instance_idAll_Instance) VALUES ('LIC1234567895', 6);
INSERT INTO Licence_Key (Licence_Keycol, All_Instance_idAll_Instance) VALUES ('LIC1234567896', 7);
INSERT INTO Licence_Key (Licence_Keycol, All_Instance_idAll_Instance) VALUES ('LIC1234567897', 8);
INSERT INTO Licence_Key (Licence_Keycol, All_Instance_idAll_Instance) VALUES ('LIC1234567898', 9);
INSERT INTO Licence_Key (Licence_Keycol, All_Instance_idAll_Instance) VALUES ('LIC1234567899', 10);
