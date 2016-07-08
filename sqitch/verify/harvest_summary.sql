-- Verify catalog_registry:harvest_summary on pg

BEGIN;

    SELECT id, url, harvest_interval, enabled, organization_name FROM catalog_registry.harvest_summary WHERE FALSE;

ROLLBACK;
