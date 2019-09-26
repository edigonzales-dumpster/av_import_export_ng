COMMENT ON SCHEMA
    agi_mopublic
IS
    'Vereinfachtes Datenmodell der Daten der amtlichen Vermessung. Fragen: stefan.ziegler@bd.so.ch, andrea.luescher@bd.so.ch'
;

GRANT USAGE ON SCHEMA agi_mopublic TO public, gretl;

GRANT SELECT ON ALL TABLES IN SCHEMA agi_mopublic TO public;

GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA agi_mopublic TO gretl;
GRANT USAGE ON ALL SEQUENCES IN SCHEMA agi_mopublic TO gretl;
