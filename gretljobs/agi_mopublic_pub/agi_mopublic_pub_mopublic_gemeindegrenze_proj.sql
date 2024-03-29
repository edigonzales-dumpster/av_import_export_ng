SELECT
    gemeinde.aname AS gemeindename,
    CAST(gemeinde.t_datasetname AS INT) AS bfs_nr,    
    aimport.importdate AS importdatum,
    nachfuehrung.gueltigereintrag AS nachfuehrung,
    ST_CurveToLine(grenze.geometrie, 0.002, 1, 1) AS geometrie
FROM
    agi_dm01avso24.gemeindegrenzen_gemeinde AS gemeinde  
    RIGHT JOIN agi_dm01avso24.gemeindegrenzen_projgemeindegrenze AS grenze
        ON grenze.projgemeindegrenze_von = gemeinde.t_id
    LEFT JOIN agi_dm01avso24.gemeindegrenzen_gemnachfuehrung AS nachfuehrung
        ON nachfuehrung.t_id = grenze.entstehung
    LEFT JOIN agi_dm01avso24.t_ili2db_basket AS basket
        ON gemeinde.t_basket = basket.t_id    
    LEFT JOIN 
    (
        SELECT
            max(importdate) AS importdate, dataset
        FROM
            agi_dm01avso24.t_ili2db_import
        GROUP BY
            dataset 
    ) AS  aimport
        ON basket.dataset = aimport.dataset    
;