SELECT
    CASE 
        WHEN atendime.cd_convenio IN ('1', '2') THEN 'SUS'
        WHEN atendime.cd_convenio = '16' THEN 'Particular'
        ELSE 'P.Saude'
    END AS Convenio,
    TO_CHAR(atendime.dt_atendimento, 'MON','NLS_DATE_LANGUAGE=PORTUGUESE') AS Mes_Atend,
    COUNT(CASE WHEN atendime.cd_especialid = '54' THEN 1 ELSE NULL END) AS FONOAUDIOLOGIA
FROM
    atendime atendime,
    convenio convenio
WHERE
    convenio.cd_convenio = '1'
    AND EXTRACT(YEAR FROM dt_atendimento)  = '2023' 
GROUP BY 
    CASE 
        WHEN atendime.cd_convenio IN ('1', '2') THEN 'SUS'
        WHEN atendime.cd_convenio = '16' THEN 'Particular'
        ELSE 'P.Saude'
    END,
    TO_CHAR(atendime.dt_atendimento, 'MON','NLS_DATE_LANGUAGE=PORTUGUESE'),
    convenio.nm_convenio   
ORDER BY 
    TO_DATE(mes_atend, 'MONTH', 'NLS_DATE_LANGUAGE=PORTUGUESE');
