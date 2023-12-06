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




--Código Reformulado
SELECT
    procedimento_sus.cd_procedimento,
    procedimento_sus.ds_procedimento
FROM
    atendime atendime,
    procedimento_sus procedimento_sus
WHERE
    dt_atendimento BETWEEN TO_DATE('01/01/2023', 'DD/MM/YYYY') AND TO_DATE('31/01/2023', 'DD/MM/YYYY')
    AND ( atendime.cd_procedimento LIKE '0304%'
          OR atendime.cd_procedimento LIKE '304080012'
          OR atendime.cd_procedimento LIKE '304080071' )
    AND atendime.cd_procedimento = procedimento_sus.cd_procedimento
    AND ( procedimento_sus.ds_procedimento LIKE '%QUIMIO%'
          OR procedimento_sus.ds_procedimento LIKE '%HORMONIOTERAPIA%' )
GROUP BY
    procedimento_sus.ds_procedimento, procedimento_sus.cd_procedimento
ORDER BY
    procedimento_sus.ds_procedimento


    
--Código com a segunda Reformulação  
SELECT
    CASE 
        WHEN eve_siasus.cd_convenio IN ('1', '2') THEN 'SUS'
        WHEN eve_siasus.cd_convenio = '16' THEN 'Particular'
        ELSE 'P.Saude'
    END AS Convenio,
    TO_CHAR(eve_siasus.dt_eve_siasus, 'MONTH','NLS_DATE_LANGUAGE=PORTUGUESE') AS Mes_Atend,
    COUNT(qt_lancada) AS Quimioterapia
FROM
         eve_siasus eve_siasus
    INNER JOIN procedimento_sus ON eve_siasus.cd_procedimento = procedimento_sus.cd_procedimento, convenio convenio
    INNER JOIN empresa_convenio ON empresa_convenio.cd_convenio = convenio.cd_convenio
WHERE
        convenio.cd_convenio = '1'
    AND eve_siasus.dt_eve_siasus BETWEEN TO_DATE('01/10/2023', 'DD/MM/YYYY') AND TO_DATE('31/10/2023', 'DD/MM/YYYY')
    AND eve_siasus.cd_apac IS NOT NULL
    AND eve_siasus.qt_lancada >= 1
    AND eve_siasus.sn_apac_principal = 'S'
    AND eve_siasus.cd_tip_ate = 29
    AND NOT( eve_siasus.cd_procedimento LIKE '0304070017%'
          OR eve_siasus.cd_procedimento LIKE '0304070025%'
          OR eve_siasus.cd_procedimento LIKE '0304070041%'
          OR eve_siasus.cd_procedimento LIKE '0304070050%' 
          OR eve_siasus.cd_procedimento LIKE '0304070068%'
          OR eve_siasus.cd_procedimento LIKE '0304070076%'
          OR eve_siasus.cd_procedimento LIKE '0304080012%')
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

------------------------------------------------------------------------------------

SELECT
    eve_siasus.cd_paciente
FROM
         eve_siasus eve_siasus
    INNER JOIN procedimento_sus ON eve_siasus.cd_procedimento = procedimento_sus.cd_procedimento, convenio convenio
    INNER JOIN empresa_convenio ON empresa_convenio.cd_convenio = convenio.cd_convenio
WHERE
        convenio.cd_convenio = '1'
    AND eve_siasus.dt_eve_siasus BETWEEN TO_DATE('01/02/2023', 'DD/MM/YYYY') AND TO_DATE('28/02/2023', 'DD/MM/YYYY')
    AND eve_siasus.cd_apac IS NOT NULL
    AND eve_siasus.qt_lancada >= 1
    AND eve_siasus.sn_apac_principal = 'S'
    AND eve_siasus.cd_tip_ate = 29
    AND NOT( eve_siasus.cd_procedimento LIKE '0304070017%'
          OR eve_siasus.cd_procedimento LIKE '0304070025%'
          OR eve_siasus.cd_procedimento LIKE '0304070041%'
          OR eve_siasus.cd_procedimento LIKE '0304070050%' 
          OR eve_siasus.cd_procedimento LIKE '0304070068%'
          OR eve_siasus.cd_procedimento LIKE '0304070076%'
          OR eve_siasus.cd_procedimento LIKE '0304080012%');


---------------------------------------------------------------------------------------------------------

SELECT   
      CASE 
        WHEN apac.cd_convenio IN ('1', '2') THEN 'SUS'
        WHEN apac.cd_convenio = '16' THEN 'Particular'
        ELSE 'P.Saude'
    END AS Convenio,
    TO_CHAR(fat_sia.dt_periodo_inicial, 'MONTH','NLS_DATE_LANGUAGE=PORTUGUESE') AS Mes_Atend,
    COUNT(cd_apac) AS Quimioterapia
    
FROM
         apac apac
    INNER JOIN fat_sia ON fat_sia.cd_fat_sia = apac.cd_fat_sia
WHERE
    fat_sia.tipo_fatura LIKE 'APAC'
    AND dt_periodo_inicial BETWEEN TO_DATE('01/01/2023', 'DD/MM/YYYY') AND TO_DATE('31/01/2023', 'DD/MM/YYYY')
    AND cd_ori_ate LIKE 17
GROUP BY 
    CASE 
        WHEN apac.cd_convenio IN ('1', '2') THEN 'SUS'
        WHEN apac.cd_convenio = '16' THEN 'Particular'
        ELSE 'P.Saude'
    END,
    TO_CHAR(dt_periodo_inicial, 'MONTH','NLS_DATE_LANGUAGE=PORTUGUESE')   
ORDER BY 
    TO_DATE(mes_atend, 'MONTH', 'NLS_DATE_LANGUAGE=PORTUGUESE');    

