WITH C AS (WITH B AS (WITH A as (SELECT item,
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
                                 GROUP BY tipo_movimento, item, data_lancamento)
                      SELECT A.item,
                             to_char(data_lancamento, 'DD/MM/YYYY') AS data_lancamento_formatada,
                             SUM(A.lancamento_entrada_qtd) as lancamento_entrada_qtd,
                             SUM(A.lancamento_entrada_valor) as lancamento_entrada_valor,
                             SUM(A.lancamento_saida_qtd) as lancamento_saida_qtd,
                             SUM(A.lancamento_saida_valor) as lancamento_saida_valor
                      FROM A
                      GROUP BY item, data_lancamento)
           SELECT B.item,
                  MIN(B.data_lancamento)          as data_lancamento,
                  SUM(B.lancamento_entrada_qtd)   AS lancamento_entrada_qtd,
                  SUM(B.lancamento_entrada_valor) AS lancamento_entrada_valor,
                  SUM(B.lancamento_saida_qtd)     AS lancamento_saida_qtd,
                  SUM(B.lancamento_saida_valor)   AS lancamento_saida_valor
           FROM B
           GROUP BY B.item)
SELECT MovimentoResumo.item,
       MovimentoResumo.data_lancamento,
       MovimentoResumo.lancamento_entrada_qtd,
       MovimentoResumo.lancamento_entrada_valor,
       MovimentoResumo.lancamento_saida_qtd,
       MovimentoResumo.lancamento_saida_valor,
       "Saldos".valor_inicio                    as saldo_inicial_qtd,
       "Saldos".qtd_inicio                      as saldo_inicial_qtd,
       ("Saldos".valor_inicio + MovimentoResumo.lancamento_entrada_valor - MovimentoResumo.lancamento_saida_valor) as saldo_final_valor,
       ("Saldos".qtd_inicio + MovimentoResumo.lancamento_entrada_qtd - MovimentoResumo.lancamento_saida_qtd)   as saldo_final_qtd
FROM "Saldos"
         JOIN C as MovimentoResumo ON "Saldos".item = MovimentoResumo.item