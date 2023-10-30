WITH B AS (
       WITH A AS (
              SELECT item,
                     tipo_movimento,
                     data_lancamento,
                     SUM(quantidade) as lancamento_entrada_qtd,
                     SUM(valor)      as lancamento_entrada_valor,
                     0               as lancamento_saida_qtd,
                     0.0             as lancamento_saida_valor
              FROM "Movimentos"
              WHERE tipo_movimento = 'Ent'
              GROUP BY tipo_movimento, item, data_lancamento
              UNION ALL
              SELECT item,
                     tipo_movimento,
                     data_lancamento,
                     0               as lancamento_entrada_qtd,
                     0.0             as lancamento_entrada_valor,
                     SUM(quantidade) as lancamento_saida_qtd,
                     SUM(valor)      as lancamento_saida_valor
              FROM "Movimentos"
              WHERE tipo_movimento = 'Sai'
              GROUP BY tipo_movimento, item, data_lancamento
       )
       SELECT MovimentoEntrada.item,
              MovimentoEntrada.data_lancamento,
              MovimentoEntrada.lancamento_entrada_qtd,
              MovimentoEntrada.lancamento_entrada_valor,
              MovimentoSaida.lancamento_saida_qtd,
              MovimentoSaida.lancamento_saida_valor
       FROM A as MovimentoEntrada
       JOIN A as MovimentoSaida ON MovimentoEntrada.item = MovimentoSaida.item 
                                   AND MovimentoEntrada.data_lancamento = MovimentoSaida.data_lancamento
)
SELECT MovimentoResumo.item, 
       MovimentoResumo.data_lancamento, 
       MovimentoResumo.lancamento_entrada_qtd, 
       MovimentoResumo.lancamento_entrada_valor,
       MovimentoResumo.lancamento_saida_qtd, 
       MovimentoResumo.lancamento_saida_valor,
       ("Saldos".valor_inicio + MovimentoResumo.lancamento_entrada_valor - MovimentoResumo.lancamento_saida_valor) AS saldo_final_valor,
       ("Saldos".qtd_inicio + MovimentoResumo.lancamento_entrada_qtd - MovimentoResumo.lancamento_saida_qtd) AS saldo_final_qtd
FROM "Saldos"
JOIN B as MovimentoResumo ON "Saldos".item = MovimentoResumo.item