-- Revert catalog_registry:users_and_orgs from pg

BEGIN;

   DROP TABLE catalog_registry.users_organizations_join_supp CASCADE;
   DROP TABLE catalog_registry.users CASCADE;
   DROP TABLE catalog_registry.organizations CASCADE;

   ALTER TABLE catalog_registry.catalog_harvests DROP COLUMN user_id;
   ALTER TABLE catalog_registry.catalog_harvests DROP COLUMN organization_id;

COMMIT;
