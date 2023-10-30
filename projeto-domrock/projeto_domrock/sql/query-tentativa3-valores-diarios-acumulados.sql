WITH A as (SELECT item,
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
       SUM(A.lancamento_entrada_qtd)   as lancamento_entrada_qtd,
       SUM(A.lancamento_entrada_valor) as lancamento_entrada_valor,
       SUM(A.lancamento_saida_qtd)     as lancamento_saida_qtd,
       SUM(A.lancamento_saida_valor)   as lancamento_saida_valor,
       0                               as saldo_parcial_qtd,
       0.0                             as saldo_parcial_valor
FROM A
GROUP BY item, data_lancamento
ORDER BY data_lancamento