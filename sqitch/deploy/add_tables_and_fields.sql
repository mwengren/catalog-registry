-- Deploy catalog_registry:add_tables_and_fields to pg

BEGIN;

    CREATE TABLE catalog_registry.catalog_harvests (id bigserial PRIMARY KEY, url text NOT NULL,
                                   provider text NOT NULL, email text,
                                   harvest_interval interval, 
                                   enabled boolean NOT NULL DEFAULT TRUE);

COMMIT;
