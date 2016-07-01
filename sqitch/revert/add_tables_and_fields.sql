-- Revert catalog_registry:add_tables_and_fields from pg

BEGIN;

    DROP TABLE catalog_registry.catalog_harvests;

COMMIT;
