SELECT
    CASE
        WHEN atendime.cd_convenio IN ( '1', '2' ) THEN 'SUS'
        WHEN atendime.cd_convenio = '16' THEN 'Particular'
        ELSE 'P.Saude'
    END AS convenio,
    to_char(atendime.dt_alta, 'MONTH', 'NLS_DATE_LANGUAGE=PORTUGUESE') AS mes_atend,
    COUNT(CASE WHEN atendime.sn_obito = 'S' THEN 1 ELSE NULL END) AS cont_conv
FROM
    atendime atendime
    LEFT JOIN paciente paciente ON atendime.cd_paciente = paciente.cd_paciente
    LEFT JOIN convenio convenio ON atendime.cd_convenio = convenio.cd_convenio
    LEFT JOIN empresa_convenio ON empresa_convenio.cd_convenio = convenio.cd_convenio
WHERE
        atendime.dt_alta BETWEEN TO_DATE('01/01/23', 'DD/MM/YY') AND TO_DATE('31/12/23', 'DD/MM/YY')
    AND atendime.tp_atendimento <> 'I'
GROUP BY
    CASE
        WHEN atendime.cd_convenio IN ( '1', '2' ) THEN 'SUS'
        WHEN atendime.cd_convenio = '16' THEN 'Particular'
        ELSE 'P.Saude'
    END,
    to_char(atendime.dt_alta, 'MONTH', 'NLS_DATE_LANGUAGE=PORTUGUESE')
ORDER BY
    TO_DATE(mes_atend, 'MONTH', 'NLS_DATE_LANGUAGE=PORTUGUESE')   
