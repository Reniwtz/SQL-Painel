-- Cirurgia SUS, Particular e Convênio
SELECT 
    CASE 
        WHEN cirurgia_aviso.cd_convenio IN ('1', '2') THEN 'SUS'
        WHEN cirurgia_aviso.cd_convenio = '16' THEN 'Particular'
        ELSE 'P.Saude'
    END AS Convenio,
    TO_CHAR(aviso_cirurgia.dt_realizacao, 'MONTH','NLS_DATE_LANGUAGE=PORTUGUESE') AS Mes_Atend,
    COUNT(cirurgia_aviso.cd_convenio) AS Cirúrgia
FROM 
    aviso_cirurgia aviso_cirurgia
    INNER JOIN cirurgia_aviso ON aviso_cirurgia.cd_aviso_cirurgia = cirurgia_aviso.cd_aviso_cirurgia
    INNER JOIN cirurgia ON cirurgia_aviso.cd_cirurgia = cirurgia.cd_cirurgia,
    convenio convenio
    INNER JOIN empresa_convenio on empresa_convenio.cd_convenio = convenio.cd_convenio
WHERE 
        aviso_cirurgia.tp_situacao = 'R'
    AND convenio.cd_convenio = '1'
    AND aviso_cirurgia.cd_cen_cir = '1'
    AND aviso_cirurgia.dt_realizacao BETWEEN ('01/01/2023') AND ('31/03/2023')
GROUP BY 
    CASE 
        WHEN cirurgia_aviso.cd_convenio IN ('1', '2') THEN 'SUS'
        WHEN cirurgia_aviso.cd_convenio = '16' THEN 'Particular'
        ELSE 'P.Saude'
    END,
    TO_CHAR(aviso_cirurgia.dt_realizacao, 'MONTH','NLS_DATE_LANGUAGE=PORTUGUESE'),
    convenio.nm_convenio   
ORDER BY 
    TO_DATE(mes_atend, 'MONTH', 'NLS_DATE_LANGUAGE=PORTUGUESE');
