-- Radioterapia SUS
SELECT
    CASE 
        WHEN eve_siasus.cd_convenio IN ('1', '2') THEN 'SUS'
        WHEN eve_siasus.cd_convenio = '16' THEN 'Particular'
        ELSE 'P.Saude'
    END AS Convenio,
    TO_CHAR(eve_siasus.dt_eve_siasus, 'MONTH','NLS_DATE_LANGUAGE=PORTUGUESE') AS Mes_Atend,
    COUNT(qt_lancada) AS Radioterapia
FROM
    eve_siasus eve_siasus,
    convenio convenio
    INNER JOIN empresa_convenio on empresa_convenio.cd_convenio = convenio.cd_convenio
WHERE
        convenio.cd_convenio = '1'
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
    TO_CHAR(eve_siasus.dt_eve_siasus, 'MONTH','NLS_DATE_LANGUAGE=PORTUGUESE'),
    convenio.nm_convenio   
ORDER BY 
    TO_DATE(mes_atend, 'MONTH', 'NLS_DATE_LANGUAGE=PORTUGUESE');
    
    
    

-- Radioterapia Particular e Convênio
SELECT
    CASE 
        WHEN atendime.cd_convenio IN ('1', '2') THEN 'SUS'
        WHEN atendime.cd_convenio = '16' THEN 'Particular'
        ELSE 'P.Saude'
    END AS Convenio,
    TO_CHAR(atendime.dt_atendimento,  'MONTH','NLS_DATE_LANGUAGE=PORTUGUESE') AS Mes_Atend,
    COUNT(atendime.cd_convenio) AS Radioterapia
FROM
    atendime atendime,
    convenio convenio
    INNER JOIN empresa_convenio on empresa_convenio.cd_convenio = convenio.cd_convenio
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
    TO_CHAR(atendime.dt_atendimento, 'MONTH','NLS_DATE_LANGUAGE=PORTUGUESE'),
    convenio.nm_convenio, 
    atendime.cd_procedimento
ORDER BY 
    TO_DATE(mes_atend, 'MONTH', 'NLS_DATE_LANGUAGE=PORTUGUESE');



-- Consultas de Radioterapia SUS
SELECT
    CASE
        WHEN atendime.cd_convenio IN ( '1', '2' ) THEN 'SUS'
        WHEN atendime.cd_convenio = '16' THEN 'Particular'
        ELSE 'P.Saude'
    END AS convenio,
    to_char(atendime.dt_atendimento, 'MON', 'NLS_DATE_LANGUAGE=PORTUGUESE') AS mes_atend,
    COUNT(CASE WHEN atendime.cd_ori_ate like 14 THEN 1 ELSE NULL END) AS cont_conv
FROM
    atendime atendime,
    convenio convenio
    INNER JOIN empresa_convenio ON empresa_convenio.cd_convenio = convenio.cd_convenio
WHERE
      convenio.cd_convenio = '1'
    AND atendime.dt_atendimento BETWEEN TO_DATE('01/06/2023', 'DD/MM/YYYY') AND TO_DATE('30/06/2023', 'DD/MM/YYYY')
    AND (cd_tip_mar like 2
         OR cd_tip_mar LIKE 4
         OR cd_tip_mar LIKE 7)
    AND (atendime.cd_prestador like '216'
        OR atendime.cd_prestador like '2046'
        OR atendime.cd_prestador like '3893'
        OR atendime.cd_prestador like '83')
GROUP BY
    CASE
        WHEN atendime.cd_convenio IN ( '1', '2' ) THEN 'SUS'
        WHEN atendime.cd_convenio = '16' THEN 'Particular'
        ELSE 'P.Saude'
    END,
    to_char(atendime.dt_atendimento, 'MON', 'NLS_DATE_LANGUAGE=PORTUGUESE')
ORDER BY
    TO_DATE(mes_atend, 'MON', 'NLS_DATE_LANGUAGE=PORTUGUESE')   
