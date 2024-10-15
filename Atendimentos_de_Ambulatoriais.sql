--Mês
SELECT
    CASE
        WHEN atendime.cd_convenio IN ( '1', '2' ) THEN
            'SUS'
        WHEN atendime.cd_convenio = '16' THEN
            'Particular'
        ELSE
            'P.Saude'
    END                                                                                     AS convenio,
    substr(to_char(atendime.dt_atendimento, 'MON', 'NLS_DATE_LANGUAGE = PORTUGUESE'), 0, 3) AS mes_atend,
    COUNT(atendime.cd_convenio)                                                             AS cont_conv,
    to_number(to_char(atendime.dt_atendimento, 'MM'))                                       AS mes_numero 
FROM
    atendime atendime
WHERE
        atendime.tp_atendimento = 'A'
    AND atendime.dt_atendimento BETWEEN TO_DATE('01/01/2023', 'DD/MM/YYYY') AND TO_DATE('31/12/2023', 'DD/MM/YYYY')
GROUP BY
        CASE
            WHEN atendime.cd_convenio IN ( '1', '2' ) THEN
                'SUS'
            WHEN atendime.cd_convenio = '16' THEN
                'Particular'
            ELSE
                'P.Saude'
        END,
        substr(to_char(atendime.dt_atendimento, 'MON', 'NLS_DATE_LANGUAGE = PORTUGUESE'), 0, 3),
        to_number(to_char(atendime.dt_atendimento, 'MM'))
ORDER BY
    mes_numero


--Ano
SELECT
    CASE
        WHEN atendime.cd_convenio IN ( '1', '2' ) THEN
            'SUS'
        WHEN atendime.cd_convenio = '16' THEN
            'Particular'
        ELSE
            'P.Saude'
    END                                      AS convenio,
    to_char(atendime.dt_atendimento, 'YYYY') AS ano_atend,
    COUNT(atendime.cd_convenio)              AS cont_conv
FROM
    atendime atendime
WHERE
       atendime.tp_atendimento = 'A'
    AND EXTRACT(YEAR FROM atendime.dt_atendimento) BETWEEN '2006' AND '2024'
GROUP BY
        CASE
            WHEN atendime.cd_convenio IN ( '1', '2' ) THEN
                'SUS'
            WHEN atendime.cd_convenio = '16' THEN
                'Particular'
            ELSE
                'P.Saude'
        END,
        to_char(atendime.dt_atendimento, 'YYYY')
ORDER BY
    ano_atend
