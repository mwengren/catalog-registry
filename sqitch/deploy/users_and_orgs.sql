-- Deploy catalog_registry:users_and_orgs to pg 
BEGIN;
    SET search_path TO catalog_registry;

    CREATE TABLE catalog_registry.users (id bigserial PRIMARY KEY,
                        first_name text NOT NULL,
                        last_name text NOT NULL,
                        email text NOT NULL UNIQUE,
                        password text NOT NULL,
                        last_login timestamptz,
                        perms text NOT NULL DEFAULT 'r');

    CREATE TABLE catalog_registry.organizations (id bigserial PRIMARY KEY,
                                name text NOT NULL UNIQUE,
                                description text,
                                contact_url text
                               );

    /* associate harvests with users/orgs.  If both are null, only an admin
       can run the harvest */
    ALTER TABLE catalog_registry.catalog_harvests ADD COLUMN user_id integer;
    ALTER TABLE catalog_registry.catalog_harvests ADD CONSTRAINT user_fk FOREIGN KEY (user_id)
                REFERENCES catalog_registry.users (id);
    ALTER TABLE catalog_registry.catalog_harvests ADD COLUMN organization_id integer;
    ALTER TABLE catalog_registry.catalog_harvests ADD CONSTRAINT organization_fk FOREIGN KEY (organization_id)
                REFERENCES catalog_registry.organizations (id);

    CREATE TABLE catalog_registry.users_organizations_join_supp (id bigserial PRIMARY KEY,
                                                user_id integer REFERENCES users (id),
                                                organization_id integer REFERENCES organizations (id) );

    CREATE VIEW catalog_registry.users_organizations_view 
       AS SELECT u.email, o.name organization_name
         FROM users_organizations_join_supp j
             JOIN users u ON u.id = j.user_id
             JOIN organizations o ON o.id = j.organization_id;
                             
    -- allow view of join support to be affected by DML statements
    CREATE OR REPLACE FUNCTION catalog_registry.users_organizations_view_dml() RETURNS TRIGGER
    LANGUAGE plpgsql
    AS $function$
       BEGIN
         IF TG_OP = 'INSERT' THEN
            INSERT INTO catalog_registry.users_organizations_join_supp (user_id, organization_id)
            SELECT u.id, o.id FROM catalog_registry.users u, catalog_registry.organizations o
                WHERE o.name = NEW.organization_name AND u.email = new.email;
            RETURN NEW;
         ELSIF TG_OP = 'DELETE' THEN
            DELETE FROM catalog_registry.users_organizations_join_supp j
                USING catalog_registry.users u, catalog_registry.organizations o
                WHERE u.id = j.user_id AND o.id = j.organization_id
                                       AND o.name = OLD.organization_name
                                       AND u.email = OLD.email;
            RETURN OLD;
         ELSIF TG_OP = 'UPDATE' THEN
            UPDATE catalog_registry.users_organizations_join_supp j
                  SET user_id = (SELECT id FROM catalog_registry.users WHERE email = NEW.email),
                      organization_id = (SELECT id FROM catalog_registry.organizations WHERE
                                                    name = NEW.organization_name)
                  FROM catalog_registry.users u, catalog_registry.organizations o 
                  WHERE u.id = j.user_id AND o.id = j.organization_id
                                       AND o.name = OLD.organization_name
                                       AND u.email = OLD.email;
            RETURN NEW;
         END IF;
       END;
   $function$;

   CREATE TRIGGER users_organizations_modify
    INSTEAD OF INSERT OR UPDATE OR DELETE ON catalog_registry.users_organizations_view
       FOR EACH ROW EXECUTE PROCEDURE catalog_registry.users_organizations_view_dml(); 
COMMIT;
