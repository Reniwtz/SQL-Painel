-- Total de altas da internação
SELECT
    CASE 
        WHEN atendime.cd_convenio IN ('1', '2') THEN 'SUS'
        WHEN atendime.cd_convenio = '16' THEN 'Particular'
        ELSE 'P.Saude'
    END AS Convenio,
    TO_CHAR(atendime.dt_atendimento, 'MONTH','NLS_DATE_LANGUAGE=PORTUGUESE') AS Mes_Atend,
    COUNT(atendime.cd_convenio) AS Altas
FROM
    atendime atendime
    INNER JOIN convenio convenio ON atendime.cd_convenio = convenio.cd_convenio
WHERE
    trunc(atendime.dt_alta) BETWEEN '01/01/2022' AND '31/12/2022'
    AND tp_atendimento LIKE 'I'
GROUP BY 
    CASE 
        WHEN atendime.cd_convenio IN ('1', '2') THEN 'SUS'
        WHEN atendime.cd_convenio = '16' THEN 'Particular'
        ELSE 'P.Saude'
    END,
    TO_CHAR(atendime.dt_atendimento, 'MONTH','NLS_DATE_LANGUAGE=PORTUGUESE')  
ORDER BY 
    TO_DATE(mes_atend, 'MONTH', 'NLS_DATE_LANGUAGE=PORTUGUESE'); 
