-- Deploy catalog_registry:harvest_summary to pg

BEGIN;

    SET search_path TO catalog_registry;
    CREATE VIEW harvest_summary AS
        SELECT h.id, h.url, h.harvest_interval, h.enabled, o.name organization_name FROM catalog_harvests h
        JOIN organizations o ON h.organization_id=o.id;

COMMIT;
