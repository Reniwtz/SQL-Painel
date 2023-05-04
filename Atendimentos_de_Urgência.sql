SELECT
    CASE
        WHEN atendime.cd_convenio IN ( '1', '2' ) THEN 'SUS'
        WHEN atendime.cd_convenio = '16' THEN 'Particular'
        ELSE 'P.Saude'
    END AS Convenio,
    SUBSTR(TO_CHAR(atendime.dt_atendimento, 'MONTH'),0,3) AS mes_atend,
    COUNT(atendime.cd_convenio) AS Urgência
FROM
    atendime atendime,
    convenio convenio,
    empresa_convenio
WHERE
          empresa_convenio.cd_convenio = convenio.cd_convenio
    AND trunc(atendime.dt_atendimento) BETWEEN '01/04/2023' AND '30/04/2023'
    AND dbamv.fnc_mv_usuario_unidade_setor(NULL, NULL, atendime.cd_ori_ate, atendime.cd_leito) = 'S'
    AND atendime.tp_atendimento = 'U'
    AND convenio.cd_convenio = '1'
GROUP BY
    CASE 
        WHEN atendime.cd_convenio IN ('1', '2') THEN 'SUS'
        WHEN atendime.cd_convenio = '16' THEN 'Particular'
        ELSE 'P.Saude'
    END,
    SUBSTR(TO_CHAR(atendime.dt_atendimento, 'MONTH'),0,3),
    convenio.nm_convenio
ORDER BY
    mes_atend 
