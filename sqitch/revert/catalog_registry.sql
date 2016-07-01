-- Revert catalog_registry:catalog_registry from pg

BEGIN;

    DROP SCHEMA catalog_registry;

COMMIT;
