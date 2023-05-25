SELECT
    CASE
        WHEN ped_rx.cd_convenio IN ( '1', '2' ) THEN 'SUS'
        WHEN ped_rx.cd_convenio = '16' THEN 'Particular'
        ELSE 'P.Saude'
    END AS convenio,
    to_char(itped_rx.dt_realizado, 'MONTH', 'NLS_DATE_LANGUAGE=PORTUGUESE') AS mes_atend,
    COUNT(ped_rx.cd_convenio) AS ambulatorias
FROM
    dbamv.itped_rx,
    dbamv.exa_rx,
    dbamv.convenio,
    dbamv.ped_rx,
    dbamv.empresa_convenio
WHERE
        empresa_convenio.cd_convenio = convenio.cd_convenio
    AND empresa_convenio.cd_multi_empresa = 1
    AND exa_rx.cd_exa_rx = itped_rx.cd_exa_rx
    AND itped_rx.cd_ped_rx = ped_rx.cd_ped_rx
    AND ped_rx.cd_convenio = convenio.cd_convenio
    AND trunc(ped_rx.dt_pedido) < '01/05/2023'
    AND trunc(itped_rx.dt_realizado) BETWEEN '01/04/2023' AND '30/04/2023'
    AND ped_rx.cd_set_exa = 13
GROUP BY
        CASE
            WHEN ped_rx.cd_convenio IN ( '1', '2' ) THEN 'SUS'
            WHEN ped_rx.cd_convenio = '16' THEN 'Particular'
            ELSE 'P.Saude'
        END,
        to_char(itped_rx.dt_realizado, 'MONTH', 'NLS_DATE_LANGUAGE=PORTUGUESE')
ORDER BY
    TO_DATE(mes_atend, 'MONTH', 'NLS_DATE_LANGUAGE=PORTUGUESE');
