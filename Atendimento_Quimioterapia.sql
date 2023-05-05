--Quimioterapia SUS
SELECT 
    CASE 
        WHEN eve_siasus.cd_convenio IN ('1', '2') THEN 'SUS'
        WHEN eve_siasus.cd_convenio = '16' THEN 'Particular'
        ELSE 'P.Saude'
    END AS Convenio,
    TO_CHAR(eve_siasus.dt_eve_siasus, 'MONTH','NLS_DATE_LANGUAGE=PORTUGUESE') AS Mes_Atend,
    COUNT(qt_lancada) AS Quimioterapia
FROM 
    eve_siasus eve_siasus,
    convenio convenio
    INNER JOIN empresa_convenio on empresa_convenio.cd_convenio = convenio.cd_convenio
WHERE 
        convenio.cd_convenio = '1'
    AND eve_siasus.dt_eve_siasus BETWEEN ( '01/01/2023' ) AND ( '31/03/2023' )
    AND eve_siasus.cd_apac IS NOT NULL
    AND eve_siasus.cd_procedimento LIKE ( '0304%' )
    AND eve_siasus.qt_lancada >= 1
    AND eve_siasus.sn_apac_principal = 'S'
    AND eve_siasus.cd_tip_ate = 29
GROUP BY 
    CASE 
        WHEN eve_siasus.cd_convenio IN ('1', '2') THEN 'SUS'
        WHEN eve_siasus.cd_convenio = '16' THEN 'Particular'
        ELSE 'P.Saude'
    END,
    TO_CHAR(eve_siasus.dt_eve_siasus, 'MONTH','NLS_DATE_LANGUAGE=PORTUGUESE'),
    convenio.nm_convenio   
ORDER BY 
    TO_DATE(mes_atend, 'MONTH', 'NLS_DATE_LANGUAGE=PORTUGUESE');



--Quimioterapia Particular e Convênio
SELECT
    CASE 
        WHEN atendime.cd_convenio IN ('1', '2') THEN 'SUS'
        WHEN atendime.cd_convenio = '16' THEN 'Particular'
        ELSE 'P.Saude'
    END AS Convenio,
    TO_CHAR(atendime.dt_atendimento, 'MONTH','NLS_DATE_LANGUAGE=PORTUGUESE') AS Mes_Atend,
    COUNT(atendime.cd_convenio) AS Quimioterapia
FROM
    atendime atendime,
    convenio convenio
WHERE
    
   atendime.dt_atendimento BETWEEN ( '01/01/2023' ) AND ( '31/03/2023' )
   AND atendime.cd_pro_int = '20104294'
   AND convenio.cd_convenio = '1'
GROUP BY 
    CASE 
        WHEN atendime.cd_convenio IN ('1', '2') THEN 'SUS'
        WHEN atendime.cd_convenio = '16' THEN 'Particular'
        ELSE 'P.Saude'
    END,
    TO_CHAR(atendime.dt_atendimento, 'MONTH','NLS_DATE_LANGUAGE=PORTUGUESE'),
    convenio.nm_convenio, 
    atendime.cd_procedimento
ORDER BY 
    TO_DATE(mes_atend, 'MONTH', 'NLS_DATE_LANGUAGE=PORTUGUESE');
