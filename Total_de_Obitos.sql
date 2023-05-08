-- Total de Obitos SUS, Particular e Convênios
SELECT
    CASE
        WHEN atendime.cd_convenio IN ( '1', '2' ) THEN 'SUS'
        WHEN atendime.cd_convenio = '16' THEN 'Particular'
        ELSE 'P.Saude'
    END AS convenio,
    to_char(atendime.dt_alta, 'MONTH', 'NLS_DATE_LANGUAGE=PORTUGUESE') AS mes_atend,
    COUNT(atendime.cd_convenio) AS cont_conv
FROM
    atendime atendime
    INNER JOIN paciente on atendime.cd_paciente = paciente.cd_paciente, 
    convenio convenio
    INNER JOIN empresa_convenio on empresa_convenio.cd_convenio = convenio.cd_convenio
WHERE
    atendime.sn_obito = 'S'
    AND atendime.dt_alta BETWEEN ('01/01/2023') AND ('30/03/2023')
    AND atendime.cd_mot_alt IS NOT NULL
    AND convenio.cd_convenio = '1'
GROUP BY
    CASE
        WHEN atendime.cd_convenio IN ( '1', '2' ) THEN 'SUS'
        WHEN atendime.cd_convenio = '16' THEN 'Particular'
        ELSE 'P.Saude'
    END,
    to_char(atendime.dt_alta, 'MONTH', 'NLS_DATE_LANGUAGE=PORTUGUESE'),
    convenio.nm_convenio
ORDER BY
    TO_DATE(mes_atend, 'MONTH', 'NLS_DATE_LANGUAGE=PORTUGUESE')
