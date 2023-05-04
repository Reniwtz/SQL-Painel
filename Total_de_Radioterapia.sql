SELECT
    CASE 
        WHEN eve_siasus.cd_convenio IN ('1', '2') THEN 'SUS'
        WHEN eve_siasus.cd_convenio = '16' THEN 'Particular'
        ELSE 'P.Saude'
    END AS Convenio,
    SUBSTR(TO_CHAR(eve_siasus.dt_eve_siasus, 'MONTH'),0,3) AS Mes_Atend,
    COUNT(qt_lancada) AS Radioterapia
FROM
    eve_siasus eve_siasus,
    convenio convenio,
    empresa_convenio
WHERE
    empresa_convenio.cd_convenio = convenio.cd_convenio
    AND convenio.cd_convenio = '1'
    AND eve_siasus.dt_eve_siasus BETWEEN ( '01/01/2023' ) AND ( '30/04/2023' )
    AND eve_siasus.cd_apac IS NOT NULL
    AND eve_siasus.cd_procedimento LIKE ( '0304%' )
    AND eve_siasus.qt_lancada >= 1
    AND eve_siasus.cd_tip_ate = 28
GROUP BY 
    CASE 
        WHEN eve_siasus.cd_convenio IN ('1', '2') THEN 'SUS'
        WHEN eve_siasus.cd_convenio = '16' THEN 'Particular'
        ELSE 'P.Saude'
    END,
    SUBSTR(TO_CHAR(eve_siasus.dt_eve_siasus, 'MONTH'),0,3),
    convenio.nm_convenio   
ORDER BY 
    Mes_Atend;
    
    
    

-- Radioterapia Particular e Convênio
SELECT
    CASE 
        WHEN atendime.cd_convenio IN ('1', '2') THEN 'SUS'
        WHEN atendime.cd_convenio = '16' THEN 'Particular'
        ELSE 'P.Saude'
    END AS Convenio,
    SUBSTR(TO_CHAR(atendime.dt_atendimento, 'MONTH'),0,3) AS Mes_Atend,
    COUNT(atendime.cd_convenio) AS CONT_CONV
FROM
    atendime atendime,
    convenio convenio
WHERE   
   atendime.dt_atendimento BETWEEN ( '01/01/2023' ) AND ( '31/03/2023' )
   AND (atendime.cd_pro_int LIKE ( '4120%' ) OR atendime.cd_pro_int LIKE ( '31602290' ))
   AND atendime.cd_pro_int LIKE ( '4120%' )
   AND convenio.cd_convenio = '1'
GROUP BY 
    CASE 
        WHEN atendime.cd_convenio IN ('1', '2') THEN 'SUS'
        WHEN atendime.cd_convenio = '16' THEN 'Particular'
        ELSE 'P.Saude'
    END,
    SUBSTR(TO_CHAR(atendime.dt_atendimento, 'MONTH'),0,3),
    convenio.nm_convenio, 
    atendime.cd_procedimento
ORDER BY 
    Mes_Atend;
