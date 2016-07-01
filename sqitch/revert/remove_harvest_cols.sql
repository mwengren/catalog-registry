-- Revert catalog_registry:remove_harvest_cols from pg
BEGIN;

    ALTER TABLE catalog_registry.catalog_harvests
        ALTER COLUMN harvest_interval
        DROP DEFAULT;

    ALTER TABLE catalog_registry.catalog_harvests
        ADD COLUMN provider text;

    ALTER TABLE catalog_registry.catalog_harvests
        ADD COLUMN email text;

COMMIT;
