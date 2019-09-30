COMMENT ON SCHEMA
    agi_mopublic_pub
IS
    'Vereinfachtes Datenmodell der Daten der amtlichen Vermessung. Fragen: stefan.ziegler@bd.so.ch, andrea.luescher@bd.so.ch'
;

GRANT USAGE ON SCHEMA agi_mopublic_pub TO public, gretl;

GRANT SELECT ON ALL TABLES IN SCHEMA agi_mopublic_pub TO public;

GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA agi_mopublic_pub TO gretl;
GRANT USAGE ON ALL SEQUENCES IN SCHEMA agi_mopublic_pub TO gretl;
