COMMENT ON SCHEMA
    agi_grundbuchplan_pub
IS
    'Datenmodell für das Vorhalten speziell aufbereiteter AV-Daten zwecks korrekter Darstellung des Planes für das Grundbuch. Fragen: stefan.ziegler@bd.so.ch'
;

GRANT USAGE ON SCHEMA agi_grundbuchplan_pub TO public, gretl;

GRANT SELECT ON ALL TABLES IN SCHEMA agi_grundbuchplan_pub TO public;

GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA agi_grundbuchplan_pub TO gretl;
GRANT USAGE ON ALL SEQUENCES IN SCHEMA agi_grundbuchplan_pub TO gretl;
