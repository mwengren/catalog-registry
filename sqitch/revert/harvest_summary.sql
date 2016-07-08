-- Revert catalog_registry:harvest_summary from pg

BEGIN;

    DROP VIEW catalog_registry.harvest_summary;

COMMIT;
