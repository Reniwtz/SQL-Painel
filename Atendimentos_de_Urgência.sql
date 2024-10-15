-- Mês
SELECT
    CASE
        WHEN atendime.cd_convenio IN ( '1', '2' ) THEN
            'SUS'
        WHEN atendime.cd_convenio = '16' THEN
            'Particular'
        ELSE
            'P.Saude'
    END                                                                     AS convenio,
    to_char(atendime.dt_atendimento, 'MON', 'NLS_DATE_LANGUAGE=PORTUGUESE') AS mes_atend,
    COUNT(
        CASE
            WHEN atendime.tp_atendimento = 'U' THEN
                1
            ELSE
                NULL
        END
    )                                                                       AS urgência
FROM
    atendime atendime
WHERE
        atendime.dt_atendimento BETWEEN TO_DATE('01/01/23', 'DD/MM/YY') AND TO_DATE('31/12/23', 'DD/MM/YY')
GROUP BY
        CASE
            WHEN atendime.cd_convenio IN ( '1', '2' ) THEN
                'SUS'
            WHEN atendime.cd_convenio = '16' THEN
                'Particular'
            ELSE
                'P.Saude'
        END,
        to_char(atendime.dt_atendimento, 'MON', 'NLS_DATE_LANGUAGE=PORTUGUESE')
ORDER BY
    TO_DATE(mes_atend, 'MON', 'NLS_DATE_LANGUAGE=PORTUGUESE') 


-- ANO
SELECT
    CASE
        WHEN atendime.cd_convenio IN ( '1', '2' ) THEN
            'SUS'
        WHEN atendime.cd_convenio = '16' THEN
            'Particular'
        ELSE
            'P.Saude'
    END                                                                      AS convenio,
    to_char(atendime.dt_atendimento, 'YYYY', 'NLS_DATE_LANGUAGE=PORTUGUESE') AS mes_atend,
    COUNT(
        CASE
            WHEN atendime.tp_atendimento = 'U' THEN
                1
            ELSE
                NULL
        END
    )                                                                        AS urgência
FROM
    atendime atendime
WHERE
    EXTRACT(YEAR FROM atendime.dt_atendimento) BETWEEN '2006' AND '2024'
GROUP BY
        CASE
            WHEN atendime.cd_convenio IN ( '1', '2' ) THEN
                'SUS'
            WHEN atendime.cd_convenio = '16' THEN
                'Particular'
            ELSE
                'P.Saude'
        END,
        to_char(atendime.dt_atendimento, 'YYYY', 'NLS_DATE_LANGUAGE=PORTUGUESE')
ORDER BY
    to_date(mes_atend, 'YYYY', 'NLS_DATE_LANGUAGE=PORTUGUESE')
