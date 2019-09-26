COMMENT ON SCHEMA agi_plz_ortschaften IS 'Postleitzahl- und Ortschaftsgebiete der gesamten Schweiz. Daten stammen vom Bund. Fragen: stefan.ziegler@bd.so.ch'
;
GRANT USAGE ON SCHEMA agi_plz_ortschaften TO public, gretl
;
GRANT SELECT ON ALL TABLES IN SCHEMA agi_plz_ortschaften TO public
;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA agi_plz_ortschaften TO gretl
;
GRANT USAGE ON ALL SEQUENCES IN SCHEMA agi_plz_ortschaften TO gretl
;
