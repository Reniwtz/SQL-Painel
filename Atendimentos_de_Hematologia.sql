SELECT 
    CASE
        WHEN convenio.cd_convenio IN ('1', '2') THEN 'SUS'
        WHEN convenio.cd_convenio = '16' THEN 'Particular'
        ELSE 'P.Saude'
    END AS convenio,
    substr(to_char(atendime.dt_atendimento, 'MONTH'), 0, 3) AS mes_atend,
    COUNT(CASE WHEN cid.cd_cid in ('C910','C920','C924','C925') THEN 1 ELSE NULL END) AS cont_conv 
FROM
    atendime atendime
    inner JOIN paciente paciente on atendime.cd_paciente = paciente.cd_paciente
    LEFT JOIN convenio convenio ON atendime.cd_convenio = convenio.cd_convenio
    LEFT JOIN cid cid ON atendime.cd_cid = cid.cd_cid
    LEFT JOIN same same ON same.cd_paciente = paciente.cd_paciente
WHERE
    atendime.dt_atendimento BETWEEN ( '01/01/2022' ) AND ( '31/12/2022' )
    GROUP BY
    CASE
        WHEN convenio.cd_convenio IN ('1', '2') THEN 'SUS'
        WHEN convenio.cd_convenio = '16' THEN 'Particular'
        ELSE 'P.Saude'
    END,
    substr(to_char(atendime.dt_atendimento, 'MONTH'), 0, 3)
ORDER BY
 TO_DATE(mes_atend, 'MONTH')
