
---------------------------------
-- audit_event_types
---------------------------------
DROP TABLE IF EXISTS audit_event_types CASCADE;
CREATE TABLE audit_event_types (
                                   id 				int PRIMARY KEY,
                                   name			varchar(255) NOT NULL,
                                   description 	varchar(4000) NULL
);

INSERT INTO audit_event_types(id, name, description)
VALUES
(100, N'Log In', N'A user has logged into Precision Hub. Additional Information: User Role'),
(101, N'Log Out', N'A user has logged out of Precision Hub.'),
(102, N'Create Custom Rule', N'A user has made a request to create a custom automation rule. Additional Information: Custom Rule ID'),
(103, N'Delete Custom Rule', N'A user has made a request to delete a custom automation rule. Additional Information: Custom Rule ID'),
(104, N'Notifications On', N'A user has made notifications available for all users.'),
(105, N'Notifications Off', N'A user has made notifications unavailable for all users.'),
(106, N'Application Startup', N'Precision Hub has started up.'),
(107, N'Application Shutdown', N'Precision Hub is shutting down.'),
(108, N'Change Normal Day Start', N'A user has made a request to change the start time of Normal Day. Additional Information: Start Time'),
(109, N'Change Normal Night Start', N'A user has made a request to change the start time of Normal Night. Additional Information: Start Time'),
(110, N'Run Manual System Rule', N'A user has made a request to run a Manual System Automation Rule. Additional Information: System Rule enum'),
(111, N'Log In to Portfolio View', N'A user has logged into the Portfolio View. Additional Information: User Role'),
(112, N'Log Out of Portfolio View', N'A user has logged out of the Portfolio View. Additional Information: User Role'),
(113, N'Launch PrecisionHub/Building', N'A user launched PrecisionHub/building. Additional Information: PrecisionHub/building'),
(114, N'Trigger Emergency Notification', N'A user has triggered an Emergency Notification.');

---------------------------------
-- audit_events
---------------------------------
DROP TABLE IF EXISTS audit_events;
CREATE TABLE audit_events (
                              id 						SERIAL PRIMARY KEY,
                              "timestamp" 			timestamptz(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
                              type					smallint REFERENCES audit_event_types("id") ON DELETE CASCADE,
                              location				varchar(255),
                              "user"	 				varchar(255) NOT NULL,
                              additional_information 	varchar(255) NOT NULL
);

---------------------------------
-- automation_rule_templates
---------------------------------
DROP TABLE IF EXISTS automation_rule_templates;
CREATE TABLE automation_rule_templates (
                                           id						varchar(255) NOT NULL,
                                           location				varchar(255) NOT NULL,
                                           repeats					boolean,
                                           state					varchar(255),
                                           name					varchar(255),
                                           initiator				varchar(255),
                                           start_date				date NOT NULL,
                                           custom_period			varchar(255),
                                           day_of_week				varchar(255),
                                           start_time				int,
                                           is_am					boolean,
                                           duration				int,
                                           zone_list				varchar(65535),
                                           status					varchar(255),
                                           PRIMARY KEY (id, location)
);

---------------------------------
-- bookable_spaces
---------------------------------
DROP TABLE IF EXISTS bookable_spaces;
CREATE TABLE bookable_spaces (
                                 id 							varchar(255) NOT NULL,
                                 location					varchar(255) NOT NULL,
                                 zone						varchar(255) NOT NULL UNIQUE,
                                 name 						varchar(255) NOT NULL,
                                 type		 				varchar(255) NOT NULL,
                                 maximum_attendee_capacity	int NOT NULL,
                                 calendar					varchar(255) NOT NULL,
                                 PRIMARY KEY (id, location)
);


---------------------------------
-- booking config
---------------------------------
DROP TABLE IF EXISTS booking_config CASCADE;
CREATE TABLE booking_config (
                                location	varchar(255) PRIMARY KEY,
                                space_types	text[] NOT NULL,
                                max_capacity	int,
                                provider	varchar(255) NOT NULL,
                                connection_string	text NOT NULL
);

---------------------------------
-- clusters
---------------------------------
DROP TABLE IF EXISTS clusters CASCADE;
CREATE TABLE clusters (
                          id 			varchar(255) NOT NULL,
                          location	varchar(255) NOT NULL,
                          name 		varchar(255) NOT NULL,
                          type 		varchar(255) NOT NULL,
                          subsystem 	varchar(255) NOT NULL,
                          zone 		varchar(255) NOT NULL,
                          floor 		varchar(255) NOT NULL,
                          PRIMARY KEY (id, location)
);

---------------------------------
-- cluster_to_zone
---------------------------------
DROP TABLE IF EXISTS cluster_to_zone CASCADE;
CREATE TABLE cluster_to_zone (
                                 cluster 	varchar(255) NOT NULL,
                                 location	varchar(255) NOT NULL,
                                 zone 		varchar(255) NOT NULL
);

---------------------------------
-- devices
---------------------------------
DROP TABLE IF EXISTS devices;
CREATE TABLE devices (
                         id 			varchar(255) NOT NULL,
                         location	varchar(255) NOT NULL,
                         subsystem	varchar(255) NOT NULL,
                         name 		varchar(255) NOT NULL,
                         vlan 		varchar(255) NOT NULL,
                         switch_name varchar(255) NOT NULL,
                         floor 		varchar(255) NOT NULL,
                         PRIMARY KEY (id, location)
);

---------------------------------
-- device_properties
---------------------------------
DROP TABLE IF EXISTS device_properties;
CREATE TABLE device_properties (
                                   id 			varchar(255) NOT NULL,
                                   location	varchar(255) NOT NULL,
                                   name 		varchar(255) NOT NULL,
                                   position	int NOT NULL,
                                   PRIMARY KEY (id, location)
);

---------------------------------
-- device_to_cluster
---------------------------------
DROP TABLE IF EXISTS device_to_cluster;
CREATE TABLE device_to_cluster (
                                   location	varchar(255) NOT NULL,
                                   device 		varchar(255) NOT NULL,
                                   cluster 	varchar(255) NOT NULL
);

---------------------------------
-- features
---------------------------------
DROP TABLE IF EXISTS features;
CREATE TABLE features (
                          id 			varchar(255) NOT NULL,
                          location	varchar(255) NOT NULL,
                          subsystem	varchar(255) NOT NULL,
                          floor 		varchar(255) NOT NULL,
                          path 		varchar(255) NOT NULL,
                          label 		varchar(255) NOT NULL,
                          x_pos 		smallint NOT NULL,
                          y_pos 		smallint NOT NULL,
                          zoom_min	smallint NOT NULL,
                          zoom_max	smallint NOT NULL,
                          x_offset	smallint NOT NULL,
                          y_offset	smallint NOT NULL,
                          z_index		smallint NOT NULL,
                          PRIMARY KEY (id, location)
);

---------------------------------
-- global_parameters
---------------------------------
DROP TABLE IF EXISTS global_parameters CASCADE;
CREATE TABLE global_parameters (
                                   property 	varchar(255) NOT NULL,
                                   value 		varchar(255) NOT NULL,
                                   description	varchar(255) NOT NULL
);

---------------------------------
-- group_to_location
---------------------------------
DROP TABLE IF EXISTS group_to_location;
CREATE TABLE group_to_location (
                                   "group"		varchar(255) NOT NULL,
                                   location	varchar(255) NOT NULL
);


---------------------------------
-- layers
---------------------------------
DROP TABLE IF EXISTS layers;
CREATE TABLE layers (
                        id 			varchar(255) NOT NULL,
                        location	varchar(255) NOT NULL,
                        type 		varchar(255) NOT NULL,
                        operation	varchar(255) NOT NULL,
                        path 		varchar(255) NOT NULL,
                        represents	varchar(255) NOT NULL,
                        x_pos 		smallint NOT NULL,
                        y_pos 		smallint NOT NULL,
                        width		smallint NOT NULL,
                        height		smallint NOT NULL,
                        z_index		smallint NOT NULL,
                        PRIMARY KEY (id, location)
);

---------------------------------
-- locations
---------------------------------
DROP TABLE IF EXISTS locations CASCADE;
CREATE TABLE locations (
                           id					varchar(255) PRIMARY KEY,
                           name				varchar(255) NOT NULL DEFAULT '',
                           street_address		varchar(255) NOT NULL DEFAULT '',
                           address_locality	varchar(255) NOT NULL DEFAULT '',
                           telephone			varchar(255) NOT NULL DEFAULT '',
                           complex				varchar(255) NOT NULL DEFAULT '',
                           contact_name		varchar(255) NOT NULL DEFAULT '',
                           image				varchar(255) NOT NULL DEFAULT '',
                           timezone			varchar(255) NOT NULL DEFAULT '',
                           root_zone			varchar(255) NOT NULL DEFAULT ''
);

---------------------------------
-- map_floor_maps
---------------------------------
DROP TABLE IF EXISTS map_floor_maps;
CREATE TABLE map_floor_maps (
                                id 			varchar(255) NOT NULL,
                                location	varchar(255) NOT NULL,
                                map			varchar(255) NOT NULL,
                                PRIMARY KEY (id, location)
);

---------------------------------
-- map_location_names
---------------------------------
DROP TABLE IF EXISTS map_location_names;
CREATE TABLE map_location_names (
                                    id 			varchar(255) NOT NULL,
                                    location	varchar(255) NOT NULL,
                                    name		varchar(255) NOT NULL,
                                    PRIMARY KEY (id, location)
);

---------------------------------
-- metrics
---------------------------------
DROP TABLE IF EXISTS metrics CASCADE;
CREATE TABLE metrics (
                         id			varchar(255) NOT NULL,
                         location	varchar(255) NOT NULL,
                         cluster		varchar(255) NOT NULL,
                         value		double precision NOT NULL,
                         timestamp	timestamptz(3) NOT NULL,
                         PRIMARY KEY (id, location, cluster, timestamp)
);
SELECT create_hypertable('metrics', 'timestamp');

---------------------------------
-- metric_definitions
---------------------------------
DROP TABLE IF EXISTS metric_definitions CASCADE;
CREATE TABLE metric_definitions (
                                    id					varchar(255) NOT NULL,
                                    location 			varchar(255) NOT NULL,
                                    name 				varchar(255) NOT NULL,
                                    description			varchar(255) NOT NULL,
                                    system 				varchar(255) NOT NULL,
                                    subsystem 			varchar(255) NOT NULL,
                                    unit 				varchar(255) NOT NULL,
                                    unit_label 			varchar(255) NOT NULL,
                                    unit_enum			smallint NOT NULL,
                                    status_enum			smallint NOT NULL,
                                    aggregation_rule 	varchar(255) NOT NULL,
                                    position			smallint NOT NULL,
                                    plottable			boolean NOT NULL,
                                    value_map 			varchar(255),
                                    value_map_type 		varchar(255),
                                    source				varchar(255),
                                    source_map_type 	varchar(255),
                                    PRIMARY KEY (id, location)
);

---------------------------------
-- metrics_live
---------------------------------
DROP TABLE IF EXISTS metrics_live;
CREATE TABLE metrics_live (
                              id			varchar(255) NOT NULL,
                              location	varchar(255) NOT NULL,
                              cluster		varchar(255) NOT NULL,
                              value		double precision NOT NULL,
                              timestamp	timestamptz(3) NOT NULL,
                              PRIMARY KEY (id, location, cluster)
);

---------------------------------
-- metric_synthetic_map
---------------------------------
DROP TABLE IF EXISTS metric_synthetic_map CASCADE;
CREATE TABLE metric_synthetic_map (
                                      metric		varchar(255) NOT NULL,
                                      location	varchar(255) NOT NULL,
                                      low 		double precision,
                                      high 		double precision,
                                      value 		double precision
);

---------------------------------
-- metric_values_map
---------------------------------
DROP TABLE IF EXISTS metric_values_map CASCADE;
CREATE TABLE metric_values_map (
                                   mapping		varchar(255) NOT NULL,
                                   location	varchar(255) NOT NULL,
                                   low 		double precision,
                                   high 		double precision,
                                   value 		varchar(255)
);

---------------------------------
-- notifications
---------------------------------
DROP TABLE IF EXISTS notifications;
CREATE TABLE notifications (
                               id	 		SERIAL PRIMARY KEY,
                               location	varchar(255) NOT NULL,
                               source		varchar(255) NOT NULL,
                               type		varchar(255) NOT NULL,
                               message		varchar(255) NOT NULL,
                               status		varchar(255) NOT NULL,
                               timestamp	timestamptz(3) NOT NULL
);

CREATE UNIQUE INDEX notifications_uniq_idx_location_source_type_message ON notifications(location, source, type, message);

---------------------------------
-- parameters
---------------------------------
DROP TABLE IF EXISTS parameters CASCADE;
CREATE TABLE parameters (
                            location	varchar(255) NOT NULL,
                            property 	varchar(255) NOT NULL,
                            value 		varchar(255) NOT NULL,
                            description	varchar(255) NOT NULL
);

---------------------------------
-- polygons
---------------------------------
DROP TABLE IF EXISTS polygons;
CREATE TABLE polygons (
                          id					varchar(255) NOT NULL,
                          location 			varchar(255) NOT NULL,
                          operation 			varchar(255) NOT NULL,
                          coordinate_system	varchar(255) NOT NULL,
                          coordinates 		varchar(255) NOT NULL,
                          represents 			varchar(255) NOT NULL,
                          state 				varchar(255) NOT NULL,
                          PRIMARY KEY (id, location)
);

---------------------------------
-- subsystems
---------------------------------
DROP TABLE IF EXISTS subsystems;
CREATE TABLE subsystems (
                            id 							varchar(255) NOT NULL,
                            location					varchar(255) NOT NULL,
                            name 						varchar(255) NOT NULL,
                            description		 			varchar(255) NOT NULL,
                            enum						smallint NOT NULL,
                            total_alerts_high			smallint NOT NULL,
                            floor_alerts_high			smallint NOT NULL,
                            position					smallint NOT NULL,
                            default_property_to_plot	varchar(255) NOT NULL,
                            PRIMARY KEY (id, location)
);

---------------------------------
-- subsystem_layers
---------------------------------
DROP TABLE IF EXISTS subsystem_layers;
CREATE TABLE subsystem_layers (
                                  id 			varchar(255) NOT NULL,
                                  location	varchar(255) NOT NULL,
                                  zone 		varchar(255) NOT NULL,
                                  type 		varchar(255) NOT NULL,
                                  operation	varchar(255) NOT NULL,
                                  path 		varchar(255) NOT NULL,
                                  represents	varchar(255) NOT NULL,
                                  x_pos 		smallint NOT NULL,
                                  y_pos 		smallint NOT NULL,
                                  width		smallint NOT NULL,
                                  height		smallint NOT NULL,
                                  z_index		smallint NOT NULL,
                                  PRIMARY KEY (id, location)
);

---------------------------------
-- user_locations
---------------------------------
DROP TABLE IF EXISTS user_locations;
CREATE TABLE user_locations (
                                "user"		varchar(255) NOT NULL,
                                location	varchar(255) NOT NULL
);

---------------------------------
-- user_to_group
---------------------------------
DROP TABLE IF EXISTS user_to_group;
CREATE TABLE user_to_group (
                               "user"		varchar(255) NOT NULL,
                               "group"		varchar(255) NOT NULL
);

---------------------------------
-- zones
---------------------------------
DROP TABLE IF EXISTS zones;
CREATE TABLE zones (
                       id					varchar(255) NOT NULL,
                       location			varchar(255) NOT NULL,
                       name				varchar(255) NOT NULL,
                       type				varchar(255) NOT NULL,
                       position			int NOT NULL DEFAULT 0,
                       story				int NOT NULL DEFAULT 0,
                       has_automations		boolean NOT NULL,
                       PRIMARY KEY (id, location)
);

---------------------------------
-- zone_relationships
---------------------------------
DROP TABLE IF EXISTS zone_relationships;
CREATE TABLE zone_relationships (
                                    zone			varchar(255) NOT NULL,
                                    location		varchar(255) NOT NULL,
                                    relationship	int NOT NULL
);

---------------------------------
-- zone_connections
---------------------------------
DROP TABLE IF EXISTS zone_connections;
CREATE TABLE zone_connections (
                                  zone		varchar(255) NOT NULL,
                                  location	varchar(255) NOT NULL,
                                  connects	varchar(255) NOT NULL
);

---------------------------------
-- zone_nesting
---------------------------------
DROP TABLE IF EXISTS zone_nesting;
CREATE TABLE zone_nesting (
                              zone				varchar(255) NOT NULL,
                              location			varchar(255) NOT NULL,
                              contained_in_place	varchar(255) NOT NULL
);

DROP VIEW IF EXISTS latest_metrics_with_synthetics CASCADE;
CREATE VIEW latest_metrics_with_synthetics AS
SELECT m.location, cluster, mdef.id, m.timestamp, mdef.aggregation_rule, mdef.value_map, mdef.value_map_type,
       CASE mdef.source_map_type
           WHEN 'Range' THEN
               COALESCE((SELECT DISTINCT value FROM metric_synthetic_map WHERE metric = mdef.id AND location = mdef.location AND low <= m.value AND high > m.value), 0.0)
           WHEN 'Map'   THEN
               (SELECT DISTINCT value FROM metric_synthetic_map WHERE metric = mdef.id AND location = mdef.location AND low = m.value)
           ELSE m.value
           END AS value
FROM metric_definitions AS mdef
         INNER JOIN metrics_live AS m
                    ON m.id=mdef.source AND m.location=mdef.location;

DROP VIEW IF EXISTS latest_zone_metrics_unmapped;
CREATE VIEW latest_zone_metrics_unmapped AS
SELECT location, zone, id, MAX(timestamp) AS timestamp, value_map, value_map_type,
       CASE aggregation_rule
           WHEN 'Sum'     THEN SUM(value)
           WHEN 'Average' THEN AVG(value)
           ELSE null
           END
                                          AS value
FROM latest_metrics_with_synthetics
         INNER JOIN cluster_to_zone
                    USING (cluster, location)
GROUP BY location, zone, id, value_map, value_map_type, aggregation_rule;

DROP VIEW IF EXISTS latest_zone_metrics;
CREATE VIEW latest_zone_metrics AS
SELECT location, zone, id, timestamp,
       CASE value_map_type
           WHEN 'Range' THEN
               CAST((SELECT value FROM metric_values_map WHERE mapping = value_map AND location = m.location AND low <= m.value AND high > m.value) AS VARCHAR)
           WHEN 'Map'   THEN
               CAST((SELECT value FROM metric_values_map WHERE mapping = value_map AND location = m.location AND low = m.value) AS VARCHAR)
           WHEN 'Scale' THEN
               CAST(m.value * (SELECT low FROM metric_values_map WHERE mapping = value_map AND location = m.location) AS VARCHAR)
           ELSE CAST(m.value AS VARCHAR)
           END AS value
FROM latest_zone_metrics_unmapped as m
WHERE value IS NOT NULL;

DELETE FROM locations;
INSERT INTO locations (id,name,street_address,address_locality,telephone,complex,contact_name,image,timezone,root_zone)
VALUES
('DFBRO450CI','Dana-Farber Cancer Institute','450 Brookline Ave','Boston','978-701-5324','Dana-Farber','Christopher Roberts','location-v1.0.png','America/Toronto','DFBRO450CI-BUILDING');


DELETE FROM cluster_to_zone;
INSERT INTO cluster_to_zone (cluster,location,zone)
VALUES
('/Server_1/Smith_Building/Room_308/HVAC','DFBRO450CI','DFBRO450CI-308'),
('/Server_1/Smith_Building/Room_308/HVAC','DFBRO450CI','DFBRO450CI-BUILDING'),
('/Server_1/Smith_Building/Room_308/HVAC','DFBRO450CI','DFBRO450CI-CONF-ROOM'),
('/Server_1/Smith_Building/Room_308/HVAC','DFBRO450CI','DFBRO450CI-FLOOR3'),
('/Server_1/Smith_Building/Room_308/HVAC','DFBRO450CI','DFBRO450CI-TENANT'),
('/Server_1/Smith_Building/Room_308/Lighting','DFBRO450CI','DFBRO450CI-308'),
('/Server_1/Smith_Building/Room_308/Lighting','DFBRO450CI','DFBRO450CI-BUILDING'),
('/Server_1/Smith_Building/Room_308/Lighting','DFBRO450CI','DFBRO450CI-CONF-ROOM'),
('/Server_1/Smith_Building/Room_308/Lighting','DFBRO450CI','DFBRO450CI-FLOOR3'),
('/Server_1/Smith_Building/Room_308/Lighting','DFBRO450CI','DFBRO450CI-TENANT'),
('/Server_1/Smith_Building/Room_308/Occupancy','DFBRO450CI','DFBRO450CI-308'),
('/Server_1/Smith_Building/Room_308/Occupancy','DFBRO450CI','DFBRO450CI-BUILDING'),
('/Server_1/Smith_Building/Room_308/Occupancy','DFBRO450CI','DFBRO450CI-CONF-ROOM'),
('/Server_1/Smith_Building/Room_308/Occupancy','DFBRO450CI','DFBRO450CI-FLOOR3'),
('/Server_1/Smith_Building/Room_308/Occupancy','DFBRO450CI','DFBRO450CI-TENANT'),
('/Server_1/Smith_Building/Room_309/HVAC','DFBRO450CI','DFBRO450CI-309'),
('/Server_1/Smith_Building/Room_309/HVAC','DFBRO450CI','DFBRO450CI-BUILDING'),
('/Server_1/Smith_Building/Room_309/HVAC','DFBRO450CI','DFBRO450CI-CONF-ROOM'),
('/Server_1/Smith_Building/Room_309/HVAC','DFBRO450CI','DFBRO450CI-FLOOR3'),
('/Server_1/Smith_Building/Room_309/HVAC','DFBRO450CI','DFBRO450CI-TENANT'),
('/Server_1/Smith_Building/Room_309/Lighting','DFBRO450CI','DFBRO450CI-309'),
('/Server_1/Smith_Building/Room_309/Lighting','DFBRO450CI','DFBRO450CI-BUILDING'),
('/Server_1/Smith_Building/Room_309/Lighting','DFBRO450CI','DFBRO450CI-CONF-ROOM'),
('/Server_1/Smith_Building/Room_309/Lighting','DFBRO450CI','DFBRO450CI-FLOOR3'),
('/Server_1/Smith_Building/Room_309/Lighting','DFBRO450CI','DFBRO450CI-TENANT'),
('/Server_1/Smith_Building/Room_309/Occupancy','DFBRO450CI','DFBRO450CI-309'),
('/Server_1/Smith_Building/Room_309/Occupancy','DFBRO450CI','DFBRO450CI-BUILDING'),
('/Server_1/Smith_Building/Room_309/Occupancy','DFBRO450CI','DFBRO450CI-CONF-ROOM'),
('/Server_1/Smith_Building/Room_309/Occupancy','DFBRO450CI','DFBRO450CI-FLOOR3'),
('/Server_1/Smith_Building/Room_309/Occupancy','DFBRO450CI','DFBRO450CI-TENANT'),
('/Server_1/Smith_Building/Room_Setup','DFBRO450CI','DFBRO450CI-BUILDING'),
('/Server_1/Smith_Building/Room_Setup','DFBRO450CI','DFBRO450CI-CONF-ROOM'),
('/Server_1/Smith_Building/Room_Setup','DFBRO450CI','DFBRO450CI-FLOOR3'),
('/Server_1/Smith_Building/Room_Setup','DFBRO450CI','DFBRO450CI-TENANT'),
('/Server_1/Smith_Building/Smith_Conference_Room','DFBRO450CI','DFBRO450CI-BUILDING'),
('/Server_1/Smith_Building/Smith_Conference_Room','DFBRO450CI','DFBRO450CI-CONF-ROOM'),
('/Server_1/Smith_Building/Smith_Conference_Room','DFBRO450CI','DFBRO450CI-FLOOR3'),
('/Server_1/Smith_Building/Smith_Conference_Room','DFBRO450CI','DFBRO450CI-TENANT'),
('/Smith_Building/Building/spc_705517230862893950','DFBRO450CI','DFBRO450CI-BUILDING'),
('/Smith_Building/Conference_Room/spc_705517355375001733','DFBRO450CI','DFBRO450CI-FLOOR3'),
('/Smith_Building/Conference_Room/spc_705517355375001733','DFBRO450CI','DFBRO450CI-CONF-ROOM'),
('/Smith_Building/Room_308/spc_783357534101570271','DFBRO450CI','DFBRO450CI-308'),
('/Smith_Building/Room_309/spc_783344136064336410','DFBRO450CI','DFBRO450CI-309'),
('/Smith_Building/Tenant/spc_705517138202329793','DFBRO450CI','DFBRO450CI-TENANT');


DELETE FROM clusters;
INSERT INTO clusters (id,location,name,type,subsystem,zone,floor)
VALUES
('/Server_1/Smith_Building/Room_308/HVAC','DFBRO450CI','00/Server 1/Smith Building/Room 308/HVAC','vav','hvac','DFBRO450CI-308','DFBRO450CI-FLOOR3'),
('/Server_1/Smith_Building/Room_308/Lighting','DFBRO450CI','00/Server 1/Smith Building/Room 308/Lighting','fixture','lighting','DFBRO450CI-308','DFBRO450CI-FLOOR3'),
('/Server_1/Smith_Building/Room_308/Occupancy','DFBRO450CI','00/Server 1/Smith Building/Room 308/Occupany','sensor','occupancy','DFBRO450CI-308','DFBRO450CI-FLOOR3'),
('/Server_1/Smith_Building/Room_309/HVAC','DFBRO450CI','00/Server 1/Smith Building/Room 309/HVAC','vav','hvac','DFBRO450CI-309','DFBRO450CI-FLOOR3'),
('/Server_1/Smith_Building/Room_309/Lighting','DFBRO450CI','00/Server 1/Smith Building/Room 309/Lighting','fixture','lighting','DFBRO450CI-309','DFBRO450CI-FLOOR3'),
('/Server_1/Smith_Building/Room_309/Occupancy','DFBRO450CI','00/Server 1/Smith Building/Room 309/Occupancy','sensor','occupancy','DFBRO450CI-309','DFBRO450CI-FLOOR3'),
('/Server_1/Smith_Building/Room_Setup','DFBRO450CI','00/Server 1/Smith Building/Room Setup','fixture','zoneConfig','DFBRO450CI-CONF-ROOM','DFBRO450CI-FLOOR3'),
('/Server_1/Smith_Building/Smith_Conference_Room','DFBRO450CI','','sensor','','DFBRO450CI-CONF-ROOM','DFBRO450CI-FLOOR3'),
('/Smith_Building/Room_308/spc_783357534101570271','DFBRO450CI','spc_783357534101570271','density-sensor','occupancy','DFBRO450CI-308','DFBRO450CI-FLOOR3'),
('/Smith_Building/Room_309/spc_783344136064336410','DFBRO450CI','spc_783344136064336410','density-sensor','occupancy','DFBRO450CI-309','DFBRO450CI-FLOOR3'),
('/Smith_Building/Building/spc_705517230862893950','DFBRO450CI','spc_705517230862893950','density-sensor','occupancy','DFBRO450CI-BUILDING',''),
('/Smith_Building/Tenant/spc_705517138202329793','DFBRO450CI','spc_705517138202329793','density-sensor','occupancy','DFBRO450CI-TENANT',''),
('/Smith_Building/Conference_Room/spc_705517355375001733','DFBRO450CI','spc_705517355375001733','density-sensor','occupancy','DFBRO450CI-CONF-ROOM','DFBRO450CI-FLOOR3');


DELETE FROM device_properties;
INSERT INTO device_properties (id,location,name,position)
VALUES
('id','DFBRO450CI','Name',1),
('name','DFBRO450CI','Description',2),
('BACnetAddress','DFBRO450CI','BACnet Address',3),
('VLAN','DFBRO450CI','VLAN Name',4),
('VLANNumber','DFBRO450CI','VLAN Number',5),
('IPAddress','DFBRO450CI','IP Address',6),
('IPSubnet','DFBRO450CI','IP Subnet',7),
('cableNumber','DFBRO450CI','Cable Number',8),
('portNumber','DFBRO450CI','Port Number',9),
('switchName','DFBRO450CI','Switch Name',10),
('floor','DFBRO450CI','Floor',11),
('serialNumber','DFBRO450CI','Serial Number',12);


DELETE FROM device_to_cluster;
INSERT INTO device_to_cluster (location,device,cluster)
VALUES
('DFBRO450CI','/Server_1/Smith_Building/Room_308/HVAC/RmTempSetpoint','/Server_1/Smith_Building/Room_308/HVAC'),
('DFBRO450CI','/Server_1/Smith_Building/Room_308/HVAC/RmTemperature','/Server_1/Smith_Building/Room_308/HVAC'),
('DFBRO450CI','/Server_1/Smith_Building/Room_308/HVAC/RmC02','/Server_1/Smith_Building/Room_308/HVAC'),
('DFBRO450CI','/Server_1/Smith_Building/Room_308/HVAC/RmHumidity','/Server_1/Smith_Building/Room_308/HVAC'),
('DFBRO450CI','/Server_1/Smith_Building/Room_308/HVAC/RmAirFlow','/Server_1/Smith_Building/Room_308/HVAC'),
('DFBRO450CI','/Server_1/Smith_Building/Room_308/HVAC/RmTempSetpoint_Req','/Server_1/Smith_Building/Room_308/HVAC'),
('DFBRO450CI','/Server_1/Smith_Building/Room_308/Lighting/RmLightLevel_LUX','/Server_1/Smith_Building/Room_308/Lighting'),
('DFBRO450CI','/Server_1/Smith_Building/Room_308/Lighting/RmLightStatus','/Server_1/Smith_Building/Room_308/Lighting'),
('DFBRO450CI','/Server_1/Smith_Building/Room_308/Lighting/RmShadePosition','/Server_1/Smith_Building/Room_308/Lighting'),
('DFBRO450CI','/Server_1/Smith_Building/Room_308/Lighting/RmShadePosition_Req','/Server_1/Smith_Building/Room_308/Lighting'),
('DFBRO450CI','/Server_1/Smith_Building/Room_308/Lighting/RmLightIntenstity_Req','/Server_1/Smith_Building/Room_308/Lighting'),
('DFBRO450CI','/Server_1/Smith_Building/Room_308/Lighting/RmLightStatus_Req','/Server_1/Smith_Building/Room_308/Lighting'),
('DFBRO450CI','/Server_1/Smith_Building/Room_308/Lighting/RmOccupancy','/Server_1/Smith_Building/Room_308/Lighting'),
('DFBRO450CI','/Server_1/Smith_Building/Room_308/Occupany/CurrentCount','/Server_1/Smith_Building/Room_308/Occupancy'),
('DFBRO450CI','/Server_1/Smith_Building/Room_308/Occupany/OutCount','/Server_1/Smith_Building/Room_308/Occupancy'),
('DFBRO450CI','/Server_1/Smith_Building/Room_308/Occupany/InCount','/Server_1/Smith_Building/Room_308/Occupancy'),
('DFBRO450CI','/Server_1/Smith_Building/Room_309/HVAC/RmTempSetpoint','/Server_1/Smith_Building/Room_309/HVAC'),
('DFBRO450CI','/Server_1/Smith_Building/Room_309/HVAC/RmTemperature','/Server_1/Smith_Building/Room_309/HVAC'),
('DFBRO450CI','/Server_1/Smith_Building/Room_309/HVAC/RmC02','/Server_1/Smith_Building/Room_309/HVAC'),
('DFBRO450CI','/Server_1/Smith_Building/Room_309/HVAC/RmHumidity','/Server_1/Smith_Building/Room_309/HVAC'),
('DFBRO450CI','/Server_1/Smith_Building/Room_309/HVAC/RmAirFlow','/Server_1/Smith_Building/Room_309/HVAC'),
('DFBRO450CI','/Server_1/Smith_Building/Room_309/HVAC/RmTempSetpoint_Req','/Server_1/Smith_Building/Room_309/HVAC'),
('DFBRO450CI','/Server_1/Smith_Building/Room_309/Lighting/RmLightLevel_LUX','/Server_1/Smith_Building/Room_309/Lighting'),
('DFBRO450CI','/Server_1/Smith_Building/Room_309/Lighting/RmLightStatus','/Server_1/Smith_Building/Room_309/Lighting'),
('DFBRO450CI','/Server_1/Smith_Building/Room_309/Lighting/RmShadePosition','/Server_1/Smith_Building/Room_309/Lighting'),
('DFBRO450CI','/Server_1/Smith_Building/Room_309/Lighting/RmShadePosition_Req','/Server_1/Smith_Building/Room_309/Lighting'),
('DFBRO450CI','/Server_1/Smith_Building/Room_309/Lighting/RmLightIntenstity_Req','/Server_1/Smith_Building/Room_309/Lighting'),
('DFBRO450CI','/Server_1/Smith_Building/Room_309/Lighting/RmLightStatus_Req','/Server_1/Smith_Building/Room_309/Lighting'),
('DFBRO450CI','/Server_1/Smith_Building/Room_309/Lighting/RmOccupancy','/Server_1/Smith_Building/Room_309/Lighting'),
('DFBRO450CI','/Server_1/Smith_Building/Room_309/Occupany/CurrentCount','/Server_1/Smith_Building/Room_309/Occupancy'),
('DFBRO450CI','/Server_1/Smith_Building/Room_309/Occupany/OutCount','/Server_1/Smith_Building/Room_309/Occupancy'),
('DFBRO450CI','/Server_1/Smith_Building/Room_309/Occupany/InCount','/Server_1/Smith_Building/Room_309/Occupancy'),
('DFBRO450CI','/Smith_Building/Conference_Room/spc_705517355375001733/Occupancy','/Smith_Building/Conference_Room/spc_705517355375001733'),
('DFBRO450CI','/Smith_Building/Room_308/spc_783357534101570271/Occupancy','/Smith_Building/Room_308/spc_783357534101570271'),
('DFBRO450CI','/Smith_Building/Room_309/spc_783344136064336410/Occupancy','/Smith_Building/Room_309/spc_783344136064336410'),
('DFBRO450CI','/Smith_Building/Building/spc_705517230862893950/Occupancy','/Smith_Building/Building/spc_705517230862893950'),
('DFBRO450CI','/Smith_Building/Tenant/spc_705517138202329793/Occupancy','/Smith_Building/Tenant/spc_705517138202329793');


DELETE FROM devices;
INSERT INTO devices (id,location,subsystem,name,vlan,switch_name,floor)
VALUES
('Room_308/HVAC','DFBRO450CI','hvac','Room 308 HVAC','','n/a','DFBRO450CI-FLOOR3'),
('Room_309/HVAC','DFBRO450CI','hvac','Room 309 HVAC','','n/a','DFBRO450CI-FLOOR3'),
('Room_308/Lighting','DFBRO450CI','lighting','Room 308 Lighting','','n/a','DFBRO450CI-FLOOR3'),
('Room_309/Lighting','DFBRO450CI','lighting','Room 309 Lighting','','n/a','DFBRO450CI-FLOOR3'),
('Room_308/Occupany','DFBRO450CI','occupancy','Room 308 Occupancy','','n/a','DFBRO450CI-FLOOR3'),
('Room_309/Occupany','DFBRO450CI','occupancy','Room 309 Occupancy','','n/a','DFBRO450CI-FLOOR3'),
('/Server_1/Smith_Building/Room_308/HVAC/RmTempSetpoint','DFBRO450CI','hvac','Room 308 Room Temperature Setpoint','','n/a','DFBRO450CI-FLOOR3'),
('/Server_1/Smith_Building/Room_308/HVAC/RmTemperature','DFBRO450CI','hvac','Room 308 Room Temperature Readpoint','','n/a','DFBRO450CI-FLOOR3'),
('/Server_1/Smith_Building/Room_308/HVAC/RmC02','DFBRO450CI','hvac','Room 308 CO2','','n/a','DFBRO450CI-FLOOR3'),
('/Server_1/Smith_Building/Room_308/HVAC/RmHumidity','DFBRO450CI','hvac','Room 308 Humidity','','n/a','DFBRO450CI-FLOOR3'),
('/Server_1/Smith_Building/Room_308/HVAC/RmAirFlow','DFBRO450CI','hvac','Room 308 Air Flow','','n/a','DFBRO450CI-FLOOR3'),
('/Server_1/Smith_Building/Room_308/HVAC/RmTempSetpoint_Req','DFBRO450CI','hvac','Room 308 Room Temperature Setpoint','','n/a','DFBRO450CI-FLOOR3'),
('/Server_1/Smith_Building/Room_308/Lighting/RmLightLevel_LUX','DFBRO450CI','lighting','Room 308 Brightness Level','','n/a','DFBRO450CI-FLOOR3'),
('/Server_1/Smith_Building/Room_308/Lighting/RmLightStatus','DFBRO450CI','lighting','Room 308 Light Status','','n/a','DFBRO450CI-FLOOR3'),
('/Server_1/Smith_Building/Room_308/Lighting/RmShadePosition','DFBRO450CI','lighting','Room 308 Shade Position','','n/a','DFBRO450CI-FLOOR3'),
('/Server_1/Smith_Building/Room_308/Lighting/RmShadePosition_Req','DFBRO450CI','lighting','Room 308 Shade Position Setpoint','','n/a','DFBRO450CI-FLOOR3'),
('/Server_1/Smith_Building/Room_308/Lighting/RmLightIntenstity_Req','DFBRO450CI','lighting','Room 308 Brightness Level Setpoint','','n/a','DFBRO450CI-FLOOR3'),
('/Server_1/Smith_Building/Room_308/Lighting/RmLightStatus_Req','DFBRO450CI','lighting','Room 308 Light Status Setpoint','','n/a','DFBRO450CI-FLOOR3'),
('/Server_1/Smith_Building/Room_308/Lighting/RmOccupancy','DFBRO450CI','lighting','Room 308 Occupany Light','','n/a','DFBRO450CI-FLOOR3'),
('/Server_1/Smith_Building/Room_308/Occupany/CurrentCount','DFBRO450CI','occupancy','Room 308 Current Occupancy','','n/a','DFBRO450CI-FLOOR3'),
('/Server_1/Smith_Building/Room_308/Occupany/OutCount','DFBRO450CI','occupancy','Room 308 Count of occupants leaving the room','','n/a','DFBRO450CI-FLOOR3'),
('/Server_1/Smith_Building/Room_308/Occupany/InCount','DFBRO450CI','occupancy','Room 308 Count of occupants entering the room','','n/a','DFBRO450CI-FLOOR3'),
('/Server_1/Smith_Building/Room_309/HVAC/RmTempSetpoint','DFBRO450CI','hvac','Room 309 Room Temperature Setpoint','','n/a','DFBRO450CI-FLOOR3'),
('/Server_1/Smith_Building/Room_309/HVAC/RmTemperature','DFBRO450CI','hvac','Room 309 Room Temperature Readpoint','','n/a','DFBRO450CI-FLOOR3'),
('/Server_1/Smith_Building/Room_309/HVAC/RmC02','DFBRO450CI','hvac','Room 309 CO2','','n/a','DFBRO450CI-FLOOR3'),
('/Server_1/Smith_Building/Room_309/HVAC/RmHumidity','DFBRO450CI','hvac','Room 309 Humidity','','n/a','DFBRO450CI-FLOOR3'),
('/Server_1/Smith_Building/Room_309/HVAC/RmAirFlow','DFBRO450CI','hvac','Room 309 Air Flow','','n/a','DFBRO450CI-FLOOR3'),
('/Server_1/Smith_Building/Room_309/HVAC/RmTempSetpoint_Req','DFBRO450CI','hvac','Room 309 Room Temperature Setpoint','','n/a','DFBRO450CI-FLOOR3'),
('/Server_1/Smith_Building/Room_309/Lighting/RmLightLevel_LUX','DFBRO450CI','lighting','Room 309 Brightness Level','','n/a','DFBRO450CI-FLOOR3'),
('/Server_1/Smith_Building/Room_309/Lighting/RmLightStatus','DFBRO450CI','lighting','Room 309 Light Status','','n/a','DFBRO450CI-FLOOR3'),
('/Server_1/Smith_Building/Room_309/Lighting/RmShadePosition','DFBRO450CI','lighting','Room 309 Shade Position','','n/a','DFBRO450CI-FLOOR3'),
('/Server_1/Smith_Building/Room_309/Lighting/RmShadePosition_Req','DFBRO450CI','lighting','Room 309 Shade Position Setpoint','','n/a','DFBRO450CI-FLOOR3'),
('/Server_1/Smith_Building/Room_309/Lighting/RmLightIntenstity_Req','DFBRO450CI','lighting','Room 309 Brightness Level Setpoint','','n/a','DFBRO450CI-FLOOR3'),
('/Server_1/Smith_Building/Room_309/Lighting/RmLightStatus_Req','DFBRO450CI','lighting','Room 309 Light Status Setpoint','','n/a','DFBRO450CI-FLOOR3'),
('/Server_1/Smith_Building/Room_309/Lighting/RmOccupancy','DFBRO450CI','lighting','Room 309 Occupany Light','','n/a','DFBRO450CI-FLOOR3'),
('/Server_1/Smith_Building/Room_309/Occupany/CurrentCount','DFBRO450CI','occupancy','Room 309 Current Occupancy','','n/a','DFBRO450CI-FLOOR3'),
('/Server_1/Smith_Building/Room_309/Occupany/OutCount','DFBRO450CI','occupancy','Room 309 Count of occupants leaving the room','','n/a','DFBRO450CI-FLOOR3'),
('/Server_1/Smith_Building/Room_309/Occupany/InCount','DFBRO450CI','occupancy','Room 309 Count of occupants entering the room','','n/a','DFBRO450CI-FLOOR3'),
('/Smith_Building/Conference_Room/spc_705517355375001733/Occupancy','DFBRO450CI','occupancy','Density Sensor','','n/a','DFBRO450CI-FLOOR3'),
('/Smith_Building/Room_308/spc_783357534101570271/Occupancy','DFBRO450CI','occupancy','Density Sensor','','n/a','DFBRO450CI-FLOOR3'),
('/Smith_Building/Room_309/spc_783344136064336410/Occupancy','DFBRO450CI','occupancy','Density Sensor','','n/a','DFBRO450CI-FLOOR3'),
('/Smith_Building/Tenant/spc_705517138202329793/Occupancy','DFBRO450CI','occupancy','Density Sensor','','n/a','DFBRO450CI-FLOOR3'),
('/Smith_Building/Building/spc_705517230862893950/Occupancy','DFBRO450CI','occupancy','Density Sensor','','n/a','DFBRO450CI-FLOOR3');


DELETE FROM features;
INSERT INTO features (id,location,subsystem,floor,path,label,x_pos,y_pos,zoom_min,zoom_max,x_offset,y_offset,z_index)
VALUES
('Room_308/HVAC','DFBRO450CI','hvac','DFBRO450CI-FLOOR3','images/ph/feature-hvac.png','',1225,1750,1,64,0,0,10),
('Room_309/HVAC','DFBRO450CI','hvac','DFBRO450CI-FLOOR3','images/ph/feature-hvac.png','',700,1750,1,64,0,0,10),
('Room_308/Lighting','DFBRO450CI','lighting','DFBRO450CI-FLOOR3','images/ph/feature-lighting.png','',1225,1875,1,64,0,0,10),
('Room_309/Lighting','DFBRO450CI','lighting','DFBRO450CI-FLOOR3','images/ph/feature-lighting.png','',700,1874,1,64,0,0,10),
('Room_308/Occupany','DFBRO450CI','occupancy','DFBRO450CI-FLOOR3','images/ph/feature-occupancy.png','',1225,2000,1,64,0,0,10),
('Room_309/Occupany','DFBRO450CI','occupancy','DFBRO450CI-FLOOR3','images/ph/feature-occupancy.png','',700,2000,1,64,0,0,10),
('Room_Setup','DFBRO450CI','zoneConfig','DFBRO450CI-FLOOR3','images/ph/feature-occupancy.png','',630,260,1,64,0,0,10);


DELETE FROM global_parameters;
INSERT INTO global_parameters (property,value,description)
VALUES
('role_securityManager','ROLE_SECURITYMANAGER','Building Security Manager role'),
('role_supervisor','ROLE_SUPERVISOR','Building Supervisor role'),
('role_supervisor','ROLE_TWADMIN','Building Supervisor role'),
('role_manager','ROLE_BUILDINGMANAGER','Building Manager role'),
('role_manager','ROLE_TWADMIN','Building Manager role'),
('email_extendedHours','thoughtwiredemo@gmail.com','Email for extended hours message'),
('email_extendedHoursDeleted','thoughtwiredemo@gmail.com','Email for extended hours rule deletion message'),
('email_facilityManager','thoughtwiredemo@gmail.com','Email for Facility Manager'),
('email_buildingManager','thoughtwiredemo@gmail.com','Email for Building Manager'),
('email_automationRules','thoughtwiredemo@gmail.com','Email for automation rules change'),
('auto_automationRulesEnabled','true','Are automation rules enabled'),
('default_subsystem','hvac','Default subsystem to show in subsystems page'),
('metric_properties_small_up','1.05','Minimum ratio of new metric value to old considered to be a small increase'),
('metric_properties_big_up','1.1','Minimum ratio of new metric value to old considered to be a large increase'),
('metric_properties_small_down','.95','Minimum ratio of new metric value to old considered to be a small decrease'),
('metric_properties_big_down','.9','Minimum ratio of new metric value to old considered to be a large decrease'),
('periodic_heartbeat','60','Period of heartbeat used for all polling (in seconds)'),
('expiry_time_announcements','60','Cache expiry time (in seconds) for announcements'),
('expiry_time_notifications','60','Cache expiry time (in seconds) for notifications'),
('expiry_time_metrics','300','Cache expiry time (in seconds) for metrics'),
('elevation_floor_alerts_high','2','Minimum number of alerts needed to style an elevation view floor as high-alert'),
('elevation_floor_alerts_high_style','alert1','Style to apply to an elevation view floor considered high-alert'),
('elevation_floor_filled_style','filledFloor','Style to apply to an elevation view floor, not high-alert, which is filled'),
('elevation_floor_empty_style','emptyFloor','Style to apply to an elevation view floor, not high-alert, which is empty'),
('stack_notif_none_style','level0','Style to apply to a subsystem cell in a stack view floor if there are no alerts'),
('stack_notif_low_style','level1','Style to apply to a subsystem cell in a stack view floor if there is a low number of alerts'),
('stack_notif_high_style','level5','Style to apply to a subsystem cell in a stack view floor if there is a high number of alerts'),
('alerts_ok_style','allok','Style to apply in subsystem page if there are no alerts for that subsystem'),
('alerts_caution_style','caution','Style to apply in subsystem page if there is a low number of alerts for that subsystem'),
('alerts_attention_style','attention','Style to apply in subsystem page if there is a high number of alerts for that subsystem'),
('notifications_enabled','true','Are notifications enabled at start'),
('notification_style_alert','alert3','Style to apply to an alert notification'),
('notification_button_alert','Accept','Button to include in an alert notification'),
('kpi1','kwhTotal','Metric to show for KPI #1'),
('kpi1_label','Energy Consumption','Long label to show for KPI #1'),
('kpi1_short_label','Energy','Short label to show for KPI #1'),
('kpi2','lightsDef','Metric to show for KPI #2'),
('kpi2_label','Fixtures Defined','Long label to show for KPI #2'),
('kpi2_short_label','Fixtures','Short label to show for KPI #2'),
('kpi3','wattageAvailableForRecovery','Metric to show for KPI #3'),
('kpi3_label','Wattage Available For Recovery','Long label to show for KPI #3'),
('kpi3_short_label','Wattage','Short label to show for KPI #3'),
('disable_automation_rules','false','Disable access to automation rules'),
('disable_notifications','false','Disable access to notifications'),
('disable_subsystems','false','Disable access to subsystems'),
('disable_elevation_view','false','Disable access to the elevation view'),
('disable_notifications_on_off','false','Disable access to turning notifications on or off'),
('disable_emergency_notifications','false','Disable access to emergency notifications');


DELETE FROM group_to_location;
INSERT INTO group_to_location ("group",location)
VALUES
('G-ALL','DFBRO450CI');


DELETE FROM layers;
INSERT INTO layers (id,location,type,operation,path,represents,x_pos,y_pos,width,height,z_index)
VALUES
('default','DFBRO450CI','default','svg','default-layout.svg','default',0,0,0,0,0),
('DFBRO450CI-FLOOR3','DFBRO450CI','floor','svg','floor-3-layout.svg','DFBRO450CI-FLOOR3',0,0,2520,1692,0),
('baseElevation','DFBRO450CI','elevation','svg','elevationBase-v4.0.svg','',0,0,480,1100,0);


DELETE FROM map_floor_maps;
INSERT INTO map_floor_maps (id,location,map)
VALUES
('DFBRO450CI-FLOOR3','DFBRO450CI','L3');


DELETE FROM metric_definitions;
INSERT INTO metric_definitions (id,location,name,description,system,subsystem,unit,unit_label,unit_enum,status_enum,aggregation_rule,position,plottable,value_map,value_map_type,source,source_map_type)
VALUES
('temp','DFBRO450CI','Area Temperature','Average temperature','Schneider BMS','hvac','Float','Fahrenheit',25,0,'Average',42,false,null,null,'temp',null),
('tempSp','DFBRO450CI','Area Temperature Setting','Temperature setting','Schneider BMS','hvac','Float','Fahrenheit',25,0,'Average',43,false,null,null,'tempSp',null),
('co2Level','DFBRO450CI','Area CO2 Level','Area CO2 Level','Schneider BMS','hvac','ppm','ppm',519,0,'Average',45,false,null,null,'co2Level',null),
('airFlow','DFBRO450CI','Area Air Flow Reading','Airflow readings from the VAV','Schneider BMS','hvac','cfm','cfm',578.91515938,0,'Average',46,false,null,null,'airFlow',null),
('humidity','DFBRO450CI','Area Humidity','Area Humidity','Schneider BMS','hvac','%RH','%RH',32.59999847,0,'Average',47,false,null,null,'humidity',null),
('occCount','DFBRO450CI','Current Occupants','Current Occupants','Schneider BMS','occupancy','None','Occupants',0,0,'Sum',48,false,null,null,'occCount',null),
('lightsFull','DFBRO450CI','Fixtures On at Full Power','Number of fixtures at 100% illumination','Schneider BMS','lighting','None','Fixtures',3,0,'Sum',33,false,null,null,'lumSp','Range'),
('lightsSlightlyDim','DFBRO450CI','Fixtures in Slightly Dimmed State','Number of fixtures at 76% to 99% illumination','Schneider BMS','lighting','None','Fixtures',3,0,'Sum',34,false,null,null,'lumSp','Range'),
('lightsModeratelyDim','DFBRO450CI','Fixtures in Moderate Dimmed State','Number of fixtures at 36% to 75% illumination','Schneider BMS','lighting','None','Fixtures',3,0,'Sum',35,false,null,null,'lumSp','Range'),
('lightsVeryDim','DFBRO450CI','Fixtures in Very Dimmed State','Number of fixtures at 1% to 35% illumination','Schneider BMS','lighting','None','Fixtures',3,0,'Sum',36,false,null,null,'lumSp','Range'),
('lightsOn','DFBRO450CI','Fixtures On at Any Power Level','Number of fixtures currently illuminating','Schneider BMS','lighting','None','Fixtures',3,0,'Sum',37,false,null,null,'lumSp','Range'),
('lightsOffStandby','DFBRO450CI','Fixtures Off In Standby Mode','Number of fixtures at 0% illumination','Schneider BMS','lighting','None','Fixtures',3,0,'Sum',38,false,null,null,'lumSp','Range'),
('shadePos','DFBRO450CI','Current Shade Position','Current Shade Position','Schneider BMS','lighting','None','Percent',0,0,'Average',39,false,null,null,'shadePos',null),
('zoneConfig','DFBRO450CI','Current Room Configuration','Current Room Configuration','Schneider BMS','zoneConfig','None','Position',0,0,'Average',41,false,null,null,'zoneConfig',null),
('density','DFBRO450CI','Current Density','Current Density','Density BMS','occupancy','None','Occupants',0,0,'Sum',49,false,null,null,'density',null);


DELETE FROM metric_synthetic_map;
INSERT INTO metric_synthetic_map (metric,location,low,high,value)
VALUES
('lightsFull','DFBRO450CI',100,101,1),
('lightsSlightlyDim','DFBRO450CI',70,100,1),
('lightsModeratelyDim','DFBRO450CI',40,70,1),
('lightsVeryDim','DFBRO450CI',1,40,1),
('lightsOffStandby','DFBRO450CI',0,1,1),
('lightsOn','DFBRO450CI',1,101,1);


DELETE FROM metric_values_map;
INSERT INTO metric_values_map (mapping,location,low,high,value)
VALUES
('','DFBRO450CI',null,null,null);


DELETE FROM parameters;
INSERT INTO parameters (location,property,value,description)
VALUES
('DFBRO450CI','mappedin_client_id','5b59ca7cfc2bae000f229602',''),
('DFBRO450CI','mappedin_client_secret','39ciaQ9p1Ixfo1QQGxjCM8X9XTewPZeDkHQPKWCEfXk0ZqjJ',''),
('DFBRO450CI','mappedin_anchorx','0',''),
('DFBRO450CI','mappedin_anchory','0',''),
('DFBRO450CI','mappedin_rotation','.5',''),
('DFBRO450CI','mappedin_tilt','.6',''),
('DFBRO450CI','mappedin_zoom','4000',''),
('DFBRO450CI','mappedin_min_zoom','10',''),
('DFBRO450CI','mappedin_max_zoom','10000',''),
('DFBRO450CI','mappedin_zoom_factor','.2',''),
('DFBRO450CI','mappedin_editable','true',''),
('DFBRO450CI','mappedin_enablePan','true',''),
('DFBRO450CI','mappedin_enablePedestal','true',''),
('DFBRO450CI','mappedin_enableRotate','true',''),
('DFBRO450CI','mappedin_enableZoom','true',''),
('DFBRO450CI','mappedin_venue','dana-farber','');


DELETE FROM subsystems;
INSERT INTO subsystems (id,location,name,description,enum,total_alerts_high,floor_alerts_high,position,default_property_to_plot)
VALUES
('hvac','DFBRO450CI','HVAC','HVAC',1,4,4,1,''),
('lighting','DFBRO450CI','Lighting','Lighting',2,4,4,2,''),
('occupancy','DFBRO450CI','Occupancy','Occupancy',4,4,4,4,''),
('zoneConfig','DFBRO450CI','Room Setup','Partition Position',3,4,4,4,'');


DELETE FROM user_locations;
INSERT INTO user_locations ("user",location)
VALUES
('Jason','DFBRO450CI'),
('chris_roberts','DFBRO450CI'),
('devpat','DFBRO450CI'),
('gurpreet','DFBRO450CI'),
('jason','DFBRO450CI'),
('patrick','DFBRO450CI'),
('tw-admin','DFBRO450CI'),
('tw-system-phub-prod01-1','DFBRO450CI'),
('tw-system-phub-prod01-aio-1','DFBRO450CI'),
('tw-system-phub-upplift-1','DFBRO450CI'),
('tw-system-vbox','DFBRO450CI');


DELETE FROM user_to_group;
INSERT INTO user_to_group ("user","group")
VALUES
('tw-admin','G-ALL'),
('Jason','G-ALL'),
('patrick','G-ALL'),
('devpat','G-ALL'),
('gurpreet','G-ALL'),
('jason','G-ALL'),
('tw-system-vbox','G-ALL'),
('tw-system-phub-upplift-1','G-ALL'),
('tw-system-phub-prod01-aio-1','G-ALL'),
('tw-system-phub-prod01-1','G-ALL'),
('chris_roberts','G-ALL');


DELETE FROM zone_connections;
INSERT INTO zone_connections (zone,location,connects)
VALUES
('none','DFBRO450CI','none');


DELETE FROM zone_nesting;
INSERT INTO zone_nesting (zone,location,contained_in_place)
VALUES
('DFBRO450CI-TENANT','DFBRO450CI','DFBRO450CI-BUILDING'),
('DFBRO450CI-FLOOR3','DFBRO450CI','DFBRO450CI-BUILDING'),
('DFBRO450CI-FLOOR3','DFBRO450CI','DFBRO450CI-TENANT'),
('DFBRO450CI-308','DFBRO450CI','DFBRO450CI-BUILDING'),
('DFBRO450CI-308','DFBRO450CI','DFBRO450CI-TENANT'),
('DFBRO450CI-308','DFBRO450CI','DFBRO450CI-FLOOR3'),
('DFBRO450CI-308','DFBRO450CI','DFBRO450CI-CONF-ROOM'),
('DFBRO450CI-309','DFBRO450CI','DFBRO450CI-BUILDING'),
('DFBRO450CI-309','DFBRO450CI','DFBRO450CI-TENANT'),
('DFBRO450CI-309','DFBRO450CI','DFBRO450CI-FLOOR3'),
('DFBRO450CI-309','DFBRO450CI','DFBRO450CI-CONF-ROOM'),
('DFBRO450CI-CONF-ROOM','DFBRO450CI','DFBRO450CI-BUILDING'),
('DFBRO450CI-CONF-ROOM','DFBRO450CI','DFBRO450CI-TENANT'),
('DFBRO450CI-CONF-ROOM','DFBRO450CI','DFBRO450CI-FLOOR3');


DELETE FROM zones;
INSERT INTO zones (id,location,name,type,position,story,has_automations)
VALUES
('DFBRO450CI-BUILDING','DFBRO450CI','Building','Building',10000,3,false),
('DFBRO450CI-TENANT','DFBRO450CI','Dana Farber','Tenant',20001,3,false),
('DFBRO450CI-FLOOR3','DFBRO450CI','Floor 3','Floor',20002,3,false),
('DFBRO450CI-308','DFBRO450CI','Room 308','Room',30001,3,false),
('DFBRO450CI-309','DFBRO450CI','Room 309','Room',30002,3,false),
('DFBRO450CI-CONF-ROOM','DFBRO450CI','Smith Conference Room','Room',30000,3,false);


