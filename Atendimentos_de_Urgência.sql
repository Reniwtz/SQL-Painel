-- Total de Atendimentos de Urgência SUS, Particular e Convênios
SELECT
    CASE
        WHEN atendime.cd_convenio IN ( '1', '2' ) THEN 'SUS'
        WHEN atendime.cd_convenio = '16' THEN 'Particular'
        ELSE 'P.Saude'
    END AS Convenio,
    TO_CHAR(atendime.dt_atendimento, 'MON','NLS_DATE_LANGUAGE=PORTUGUESE') AS mes_atend,
    COUNT(CASE WHEN atendime.tp_atendimento = 'U' THEN 1 ELSE NULL END) AS Urgência
FROM
    atendime atendime,
    convenio convenio
    INNER JOIN empresa_convenio on empresa_convenio.cd_convenio = convenio.cd_convenio
WHERE
        EXTRACT(YEAR FROM atendime.dt_atendimento) = '2023'
    AND dbamv.fnc_mv_usuario_unidade_setor(NULL, NULL, atendime.cd_ori_ate, atendime.cd_leito) = 'S'
    AND convenio.cd_convenio = '1'
GROUP BY
    CASE 
        WHEN atendime.cd_convenio IN ('1', '2') THEN 'SUS'
        WHEN atendime.cd_convenio = '16' THEN 'Particular'
        ELSE 'P.Saude'
    END,
    TO_CHAR(atendime.dt_atendimento, 'MON','NLS_DATE_LANGUAGE=PORTUGUESE'),
    convenio.nm_convenio
ORDER BY
     TO_DATE(mes_atend, 'MON', 'NLS_DATE_LANGUAGE=PORTUGUESE');
