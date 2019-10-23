COMMENT ON SCHEMA
    agi_av_gb_admin_einteilung_pub
IS
    'Pubmodell Admin Einteilung'
;

GRANT USAGE ON SCHEMA agi_av_gb_admin_einteilung_pub TO public, gretl;

GRANT SELECT ON ALL TABLES IN SCHEMA agi_av_gb_admin_einteilung_pub TO public;

GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA agi_av_gb_admin_einteilung_pub TO gretl;
GRANT USAGE ON ALL SEQUENCES IN SCHEMA agi_av_gb_admin_einteilung_pub TO gretl;
