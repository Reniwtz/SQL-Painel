-- Cirurgia Mês
SELECT
    CASE
        WHEN cirurgia_aviso.cd_convenio IN ( '1', '2' ) THEN
            'SUS'
        WHEN cirurgia_aviso.cd_convenio = '16' THEN
            'Particular'
        ELSE
            'P.Saude'
    END                               AS convenio,
    substr(to_char(aviso_cirurgia.dt_realizacao, 'MON', 'NLS_DATE_LANGUAGE = PORTUGUESE'),
           0,
           3)                         mes_atend,
    COUNT(cirurgia_aviso.cd_convenio) AS cont_conv,
    TO_NUMBER(TO_CHAR(aviso_cirurgia.dt_realizacao, 'MM')) AS mes_numero  -- Adiciona o número do mês
FROM
         aviso_cirurgia aviso_cirurgia
    INNER JOIN cirurgia_aviso cirurgia_aviso ON aviso_cirurgia.cd_aviso_cirurgia = cirurgia_aviso.cd_aviso_cirurgia
    INNER JOIN cirurgia ON cirurgia_aviso.cd_cirurgia = cirurgia.cd_cirurgia
WHERE
        aviso_cirurgia.tp_situacao = 'R'
    AND aviso_cirurgia.cd_cen_cir = '1'
    AND EXTRACT(YEAR FROM aviso_cirurgia.dt_realizacao) = '2024'
GROUP BY
        CASE
            WHEN cirurgia_aviso.cd_convenio IN ( '1', '2' ) THEN
                'SUS'
            WHEN cirurgia_aviso.cd_convenio = '16' THEN
                'Particular'
            ELSE
                'P.Saude'
        END,
        substr(to_char(aviso_cirurgia.dt_realizacao, 'MON', 'NLS_DATE_LANGUAGE = PORTUGUESE'),
               0,
               3),
        TO_NUMBER(TO_CHAR(aviso_cirurgia.dt_realizacao, 'MM'))  -- Agrupa pelo número do mês
ORDER BY
    mes_numero  -- Ordena pelo número do mês para garantir a ordem cronológica



-- Cirurgia Ano
SELECT
    CASE
        WHEN cirurgia_aviso.cd_convenio IN ( '1', '2' ) THEN 'SUS'
        WHEN cirurgia_aviso.cd_convenio = '16' THEN 'Particular'
        ELSE 'P.Saude'
    END AS convenio,
    to_char(aviso_cirurgia.dt_realizacao, 'YYYY', 'NLS_DATE_LANGUAGE=PORTUGUESE') AS ano_atend,
    COUNT(cirurgia_aviso.cd_convenio) AS cirurgia
FROM
    aviso_cirurgia aviso_cirurgia
    INNER JOIN cirurgia_aviso ON aviso_cirurgia.cd_aviso_cirurgia = cirurgia_aviso.cd_aviso_cirurgia
    INNER JOIN cirurgia ON cirurgia_aviso.cd_cirurgia = cirurgia.cd_cirurgia
WHERE
    aviso_cirurgia.tp_situacao = 'R'
    AND aviso_cirurgia.cd_cen_cir = '1'
    AND EXTRACT(YEAR FROM aviso_cirurgia.dt_realizacao) BETWEEN 2006 AND 2024-- Substituir por parâmetro
GROUP BY
    CASE
        WHEN cirurgia_aviso.cd_convenio IN ( '1', '2' ) THEN 'SUS'
        WHEN cirurgia_aviso.cd_convenio = '16' THEN 'Particular'
        ELSE 'P.Saude'
    END,
    to_char(aviso_cirurgia.dt_realizacao, 'YYYY', 'NLS_DATE_LANGUAGE=PORTUGUESE')
ORDER BY
    ano_atend; -- Apenas ordenar pelo ano diretamente
