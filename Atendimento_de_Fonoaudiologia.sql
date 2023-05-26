SELECT
    CASE 
        WHEN atendime.cd_convenio IN ('1', '2') THEN 'SUS'
        WHEN atendime.cd_convenio = '16' THEN 'Particular'
        ELSE 'P.Saude'
    END AS Convenio,
    TO_CHAR(atendime.dt_atendimento, 'MONTH','NLS_DATE_LANGUAGE=PORTUGUESE') AS Mes_Atend,
    COUNT(atendime.cd_convenio) AS FONOAUDIOLOGIA
FROM
    atendime atendime,
    convenio convenio
WHERE
    convenio.cd_convenio = '1'
    AND cd_especialid LIKE '54'
    AND atendime.dt_atendimento BETWEEN ( '01/04/2023' ) AND ( '30/04/2023' ) 
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
