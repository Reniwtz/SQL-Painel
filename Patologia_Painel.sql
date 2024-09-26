- PENDENTES
SELECT
    atendime.cd_atendimento AS atendimento,
    paciente.cd_paciente    AS cad,
    paciente.nm_paciente    AS nome_paciente,
    ped_rx.dt_pedido        AS data_pedido,
    exa_rx.ds_exa_rx        AS tipo_exame,
    itped_rx.cd_ped_rx      AS pedido_exame,
    itped_rx.cd_laudo       AS laudo,
    ped_rx.nr_controle      AS controle,
    convenio.nm_convenio    AS convenio,
    itped_rx.dt_entrega     AS data_prevista
FROM
         itped_rx
    INNER JOIN ped_rx ON itped_rx.cd_ped_rx = ped_rx.cd_ped_rx
    INNER JOIN atendime ON ped_rx.cd_atendimento = atendime.cd_atendimento
    INNER JOIN paciente ON paciente.cd_paciente = atendime.cd_paciente
    INNER JOIN exa_rx ON itped_rx.cd_exa_rx = exa_rx.cd_exa_rx
    INNER JOIN convenio ON atendime.cd_convenio = convenio.cd_convenio
    LEFT JOIN laudo_rx ON laudo_rx.cd_ped_rx = ped_rx.cd_ped_rx
WHERE
        ped_rx.cd_setor <> '47'
    AND ped_rx.cd_set_exa LIKE '13'
    AND ped_rx.dt_pedido BETWEEN TO_DATE('01/01/2024', 'DD/MM/YYYY') AND TO_DATE('30/09/2024', 'DD/MM/YYYY')
    AND laudo_rx.cd_prestador_assinatura IS NULL
    AND itped_rx.cd_ped_rx LIKE '949079'
    AND itped_rx.cd_exa_rx <> '376'
    AND itped_rx.sn_realizado IS NULL
GROUP BY
    atendime.cd_atendimento,
    paciente.cd_paciente,
    paciente.nm_paciente,
    ped_rx.dt_pedido,
    exa_rx.ds_exa_rx,
    itped_rx.cd_ped_rx,
    itped_rx.cd_laudo,
    ped_rx.nr_controle,
    convenio.nm_convenio,
    itped_rx.dt_entrega;

-- ENTREGUE
SELECT
    atendime.cd_atendimento AS atendimento,
    paciente.cd_paciente    AS cad,
    paciente.nm_paciente    AS nome_paciente,
    ent_psdi.hr_entrega     AS data_entrega,
    exa_rx.ds_exa_rx        AS tipo_exame,
    itped_rx.cd_ped_rx      AS pedido_exame,
    itped_rx.cd_laudo       AS laudo,
    itped_rx.dt_entrega     AS data_da_entrega,
    ped_rx.nr_controle      AS controle,
    convenio.nm_convenio    AS convênio,
    ped_rx.dt_pedido        AS data_pedido
FROM
         itped_rx
    INNER JOIN ped_rx ON itped_rx.cd_ped_rx = ped_rx.cd_ped_rx
    INNER JOIN atendime ON ped_rx.cd_atendimento = atendime.cd_atendimento
    INNER JOIN paciente ON paciente.cd_paciente = atendime.cd_paciente
    INNER JOIN exa_rx ON itped_rx.cd_exa_rx = exa_rx.cd_exa_rx
    INNER JOIN set_exa ON ped_rx.cd_set_exa = set_exa.cd_set_exa
    INNER JOIN setor ON setor.cd_setor = ped_rx.cd_setor
    LEFT JOIN ent_psdi ON itped_rx.cd_ent_psdi = ent_psdi.cd_ent_psdi
    INNER JOIN convenio ON atendime.cd_convenio = convenio.cd_convenio
    INNER JOIN laudo_rx ON laudo_rx.cd_laudo = itped_rx.cd_laudo
WHERE
        ped_rx.cd_setor <> '47'
    AND ped_rx.cd_set_exa LIKE '13'
    AND laudo_rx.dt_laudo BETWEEN TO_DATE('01/01/2024', 'DD/MM/YYYY') AND TO_DATE('30/09/2024', 'DD/MM/YYYY')
    AND itped_rx.cd_ped_rx LIKE '949079'
    AND laudo_rx.cd_prestador_assinatura IS NOT NULL
    AND itped_rx.cd_exa_rx <> '376'
GROUP BY
    atendime.cd_atendimento,
    paciente.cd_paciente,
    paciente.nm_paciente,
    ent_psdi.hr_entrega,
    exa_rx.ds_exa_rx,
    itped_rx.cd_ped_rx,
    itped_rx.cd_laudo,
    itped_rx.dt_entrega,
    ped_rx.nr_controle,
    convenio.nm_convenio,
    ped_rx.dt_pedido;
