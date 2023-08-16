SELECT
    CASE
        WHEN atendime.cd_convenio IN ( '1', '2' ) THEN 'SUS'
        WHEN atendime.cd_convenio = '16' THEN 'Particular'
        ELSE 'P.Saude'
    END AS Convenio,
    TO_CHAR(atendime.dt_atendimento, 'MON','NLS_DATE_LANGUAGE=PORTUGUESE') AS mes_atend,
    COUNT(CASE WHEN atendime.cd_especialid = '1' THEN 1 ELSE NULL END) AS Consulta_Enfermagem
FROM
    atendime atendime,
    convenio convenio
WHERE
        EXTRACT(YEAR FROM dt_atendimento)  = '2023'
    AND convenio.cd_convenio = '1'
GROUP BY
    CASE 
        WHEN atendime.cd_convenio IN ('1', '2') THEN 'SUS'
        WHEN atendime.cd_convenio = '16' THEN 'Particular'
        ELSE 'P.Saude'
    END,
    TO_CHAR(atendime.dt_atendimento, 'MONTH','NLS_DATE_LANGUAGE=PORTUGUESE'),
    convenio.nm_convenio
ORDER BY
     TO_DATE(mes_atend, 'MON', 'NLS_DATE_LANGUAGE=PORTUGUESE');
