-- Total de internações SUS, Particular e Convênios
SELECT
    CASE 
        WHEN atendime.cd_convenio IN ('1', '2') THEN 'SUS'
        WHEN atendime.cd_convenio = '16' THEN 'Particular'
        ELSE 'P.Saude'
    END AS Convenio,
    TO_CHAR(atendime.dt_atendimento, 'MONTH', 'NLS_DATE_LANGUAGE=PORTUGUESE') AS Mes_Atend,
    COUNT(atendime.cd_convenio) AS Internação
FROM
    atendime atendime,
    convenio convenio
    INNER JOIN empresa_convenio on empresa_convenio.cd_convenio = convenio.cd_convenio
WHERE
        convenio.cd_convenio = '1'
    AND atendime.tp_atendimento = 'I'
    AND atendime.dt_atendimento BETWEEN ( '01/01/2023' ) AND ( '30/04/2023' )
GROUP BY 
    CASE 
        WHEN atendime.cd_convenio IN ('1', '2') THEN 'SUS'
        WHEN atendime.cd_convenio = '16' THEN 'Particular'
        ELSE 'P.Saude'
    END,
    TO_CHAR(atendime.dt_atendimento, 'MONTH', 'NLS_DATE_LANGUAGE=PORTUGUESE'),
    convenio.nm_convenio   
ORDER BY 
    TO_DATE(mes_atend, 'MONTH', 'NLS_DATE_LANGUAGE=PORTUGUESE');
