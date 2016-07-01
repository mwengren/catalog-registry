CREATE OR REPLACE FUNCTION users_organizations_view_dml() RETURNS TRIGGER
LANGUAGE plpgsql
AS $function$
   BEGIN
     IF TG_OP = 'INSERT' THEN
        INSERT INTO users_organizations_join_supp (user_id, organization_id)
        SELECT u.id, o.id FROM users u, organizations o                                                                                             
            WHERE o.name = NEW.organization_name AND u.email = new.email;
        RETURN NEW;
     ELSIF TG_OP = 'DELETE' THEN
        DELETE FROM users_organizations_join_supp j
            USING users u, organizations o
            WHERE u.id = j.user_id AND o.id = j.organization_id
                                   AND o.name = OLD.organization_name
                                   AND u.email = OLD.email;
        RETURN OLD;
     ELSIF TG_OP = 'UPDATE' THEN
        UPDATE users_organizations_join_supp j
              SET user_id = (SELECT id FROM users WHERE email = NEW.email),
                  organization_id = (SELECT id FROM organizations WHERE
                                                name = NEW.organization_name)
              FROM users u, organizations o 
              WHERE u.id = j.user_id AND o.id = j.organization_id
                                   AND o.name = OLD.organization_name
                                   AND u.email = OLD.email;
        RETURN NEW;
     END IF;
   END;
   $function$;
