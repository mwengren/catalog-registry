-- Verify catalog_registry:catalog_registry on pg

BEGIN;

    SELECT pg_catalog.has_schema_privilege('catalog_registry', 'usage');

ROLLBACK;
