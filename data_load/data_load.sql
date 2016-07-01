SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET search_path = catalog_registry, pg_catalog;

INSERT INTO catalog_registry.organizations (name) VALUES
                                        ('PacIOOS'), ('SCCOOS'), ('NDBC'),
                                        ('GLOS'), ('GCOOS'), ('Unidata'),
                                        ('NANOOS'), ('CariCOOS'), ('CDIP'),
                                        ('HFradar_DAC'), ('MARACOOS'),
                                        ('USACE'), ('CO-OPS'), ('NERACOOS'),
                                        ('Other'), ('Navy'), ('Glider_DAC'),
                                        ('CeNCOOS'), ('AOOS'), ('OceanSITES'),
                                        ('SECOORA'), ('USGS'),
                                        ('Modeling_Testbed');

INSERT INTO catalog_registry.catalog_harvests (organization_id, url)
         SELECT o.id, v.url FROM 
        (VALUES
        ( 'PacIOOS', 'http://oos.soest.hawaii.edu/pacioos/metadata/iso/' ),
        ( 'NDBC', 'http://sdf.ndbc.noaa.gov/sos/server.php?service=SOS&request=GetCapabilities' ),
        ( 'GLOS', 'http://oos.soest.hawaii.edu/pacioos/metadata/iso/' ),
        ( 'GCOOS', 'http://barataria.tamu.edu/iso/' ),
        ( 'Unidata', 'http://thredds.axiomalaska.com/iso/unidata/' ),
        ( 'NANOOS', 'http://data.nanoos.org/metadata/coastwatcherded/osuclm/' ),
        ( 'CariCOOS', 'http://blue2.caricoos.org/capella/WAF/iso/' ),
        ( 'MARACOOS', 'http://tds.maracoos.org/iso/' ),
        ( 'MARACOOS', 'http://sos.maracoos.org/maracoos-iso/' ),
        ( 'NERACOOS', 'http://www.neracoos.org/WAF/UMaine/iso/' ),
        ( 'Glider_DAC', 'http://data.ioos.us/gliders/metadata/' ),
        ( 'CeNCOOS', 'http://thredds.axiomdatascience.com/iso/cencoos/' ),
        ( 'AOOS', 'http://thredds.axiomalaska.com/iso/aoos/' ),
        ( 'SECOORA', 'http://neptune.baruch.sc.edu/xenia/waf/ncsu_meas/' ),
        ( 'SECOORA', 'http://neptune.baruch.sc.edu/xenia/waf/uf/' ),
        ( 'SECOORA', 'http://neptune.baruch.sc.edu/xenia/waf/usc/' ),
        ( 'SECOORA', 'http://neptune.baruch.sc.edu/xenia/waf/usf/' ),
        ( 'SECOORA', 'http://neptune.baruch.sc.edu/xenia/waf/usc/hfradar/' ),
        ( 'SECOORA', 'http://neptune.baruch.sc.edu/xenia/waf/usc/platforms/' ),
        ( 'SECOORA', 'http://neptune.baruch.sc.edu/xenia/waf/ncsu_cfdl/' )) v(name, url)
        JOIN organizations o ON o.name = v.name; 
