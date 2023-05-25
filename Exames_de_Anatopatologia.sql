SELECT
    CASE
        WHEN ped_rx.cd_convenio IN ( '1', '2' ) THEN 'SUS'
        WHEN ped_rx.cd_convenio = '16' THEN 'Particular'
        ELSE 'P.Saude'
    END AS convenio,
    TO_CHAR(itped_rx.dt_realizado, 'MONTH', 'NLS_DATE_LANGUAGE=PORTUGUESE') AS mes_atend,
    COUNT(ped_rx.cd_convenio) AS Anatopatologia
FROM
    itped_rx
    INNER JOIN exa_rx ON itped_rx.cd_exa_rx = exa_rx.cd_exa_rx
    INNER JOIN ped_rx ON itped_rx.cd_ped_rx = ped_rx.cd_ped_rx
    INNER JOIN convenio ON ped_rx.cd_convenio = convenio.cd_convenio
WHERE
        itped_rx.dt_realizado BETWEEN '01/01/2022' AND '31/12/2022'
    AND ped_rx.cd_set_exa = 13
GROUP BY
        CASE
            WHEN ped_rx.cd_convenio IN ( '1', '2' ) THEN 'SUS'
            WHEN ped_rx.cd_convenio = '16' THEN 'Particular'
            ELSE 'P.Saude'
        END,
        TO_CHAR(itped_rx.dt_realizado, 'MONTH', 'NLS_DATE_LANGUAGE=PORTUGUESE')
ORDER BY
    TO_DATE(mes_atend, 'MONTH', 'NLS_DATE_LANGUAGE=PORTUGUESE');
    