-- Deploy catalog_registry:remove_harvest_cols to pg
BEGIN; 
    -- set default harvest interval to 1 day
    ALTER TABLE catalog_registry.catalog_harvests
        ALTER COLUMN harvest_interval
        SET DEFAULT '1 day';

    ALTER TABLE catalog_registry.catalog_harvests
        DROP COLUMN provider;

    ALTER TABLE catalog_registry.catalog_harvests
        DROP COLUMN email;
        
COMMIT;
