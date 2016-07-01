-- Verify catalog_registry:add_tables_and_fields on pg

BEGIN;

    SELECT id, url, provider, email, harvest_interval, enabled
          FROM catalog_registry.catalog_harvests
          WHERE FALSE;

ROLLBACK;
