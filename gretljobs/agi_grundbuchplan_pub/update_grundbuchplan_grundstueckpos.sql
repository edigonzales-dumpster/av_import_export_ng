
SELECT
    (ST_DumpPoints(ST_GeomFromText(numpos))).*
    ,
    *
FROM
    agi_grundbuchplan_pub.grundbuchplan_liegenschaft
WHERE
    mutation = false
    

