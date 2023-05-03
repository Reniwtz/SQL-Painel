SELECT
    decode(atendime.cd_convenio, '1', 'SUS - INT', '2', 'SUS - AMB', '16', 'Particular', 'P.Saude') convenio,
    substr(to_char(atendime.dt_atendimento, 'MONTH'),0, 3) mes_atend,
    COUNT(atendime.cd_convenio) cont_conv
FROM
    dbamv.atendime,
    dbamv.convenio
WHERE
        convenio.cd_convenio (+) = atendime.cd_convenio
    AND trunc(atendime.dt_atendimento) BETWEEN '01/01/2022' AND '31/08/2022'
    AND dbamv.fnc_mv_usuario_unidade_setor(NULL, NULL, atendime.cd_ori_ate, atendime.cd_leito) = 'S'
    AND atendime.tp_atendimento = 'U'
GROUP BY
    atendime.cd_convenio,
    substr(to_char(atendime.dt_atendimento, 'MONTH'), 0, 3),
    convenio.nm_convenio
ORDER BY
    convenio,
    mes_atend
