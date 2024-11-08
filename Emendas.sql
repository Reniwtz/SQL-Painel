SELECT
    atendime.cd_atendimento                    AS atendimento,
    paciente.cd_paciente                       AS cad,
    paciente.nm_paciente                       AS nome_paciente,
    exa_rx.ds_exa_rx                           AS tipo_exame,
    ped_rx.cd_ped_rx                           AS nr_pedido_exame,
    to_char(ped_rx.dt_pedido, 'DD/MM/YYYY')    AS data_pedido,
    itped_rx.cd_laudo                          AS laudo,
    to_char(itped_rx.dt_entrega, 'DD/MM/YYYY') AS data_prevista,
    to_char(ent_psdi.hr_entrega, 'DD/MM/YYYY') AS data_entrega,
    convenio.nm_convenio                       AS convênio
FROM
         atendime atendime
    INNER JOIN paciente ON paciente.cd_paciente = atendime.cd_paciente
    INNER JOIN convenio ON atendime.cd_convenio = convenio.cd_convenio
    LEFT JOIN ped_rx ON ped_rx.cd_atendimento = atendime.cd_atendimento
    LEFT JOIN itped_rx ON itped_rx.cd_ped_rx = ped_rx.cd_ped_rx
    LEFT JOIN ent_psdi ON itped_rx.cd_ent_psdi = ent_psdi.cd_ent_psdi
    LEFT JOIN exa_rx ON itped_rx.cd_exa_rx = exa_rx.cd_exa_rx
WHERE
    atendime.cd_convenio LIKE '95'
GROUP BY
    atendime.cd_atendimento,
    paciente.cd_paciente,
    paciente.nm_paciente,
    exa_rx.ds_exa_rx,
    ped_rx.cd_ped_rx,
    to_char(ped_rx.dt_pedido, 'DD/MM/YYYY'),
    itped_rx.cd_laudo,
    to_char(itped_rx.dt_entrega, 'DD/MM/YYYY'),
    to_char(ent_psdi.hr_entrega, 'DD/MM/YYYY'),
    convenio.nm_convenio
