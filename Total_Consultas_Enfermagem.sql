SELECT
    CASE
        WHEN atendime.cd_convenio IN ( '1', '2' ) THEN 'SUS'
        WHEN atendime.cd_convenio = '16' THEN 'Particular'
        ELSE 'P.Saude'
    END AS Convenio,
    TO_CHAR(atendime.dt_atendimento, 'MONTH','NLS_DATE_LANGUAGE=PORTUGUESE') AS mes_atend,
    COUNT(atendime.cd_convenio) AS Consul_Enfermagem
FROM
    atendime atendime,
    convenio convenio
WHERE
        cd_especialid = '1'
    AND dt_atendimento >= '01/01/2023'
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
     TO_DATE(mes_atend, 'MONTH', 'NLS_DATE_LANGUAGE=PORTUGUESE');
