
# CFPB Consumer Complaints — Resolução, SLA e Performance por Empresa

Análise exploratória de 3,4 milhões de reclamações financeiras registradas ao 
Consumer Financial Protection Bureau (CFPB) entre 2011 e 2023, com foco em 
resolutividade, cumprimento de SLA e performance comparativa entre empresas.

## Ferramentas utilizadas
- BigQuery (SQL)
- Looker Studio
- Dataset público: `bigquery-public-data.cfpb_complaints.complaint_database`

## Decisões analíticas

**Resolvido:** casos classificados como `Closed with explanation`, 
`Closed with non-monetary relief`, `Closed with monetary relief` ou `Closed with relief`.

**SLA:** prazo de até 7 dias entre o recebimento da reclamação e o repasse à empresa, 
baseado na distribuição real dos dados, onde 95% dos casos ficam dentro desse intervalo.

**Contestação:** o campo `consumer_disputed` foi descontinuado pelo CFPB a partir de 
abril/2017. A análise de contestação é válida apenas para o período 2011–2017.

**Casos excluídos:** registros com `In progress`, datas nulas ou diferença negativa 
entre datas foram removidos da análise.

## Principais insights

- Equifax, TransUnion e Experian concentram o maior volume de reclamações, mas 
apresentam as menores taxas de contestação, abaixo de 2%.
- Ocwen Financial tem a pior combinação do dataset: menor taxa de resolução (93,5%) 
e maior taxa de contestação (16,96%).
- O volume de reclamações cresceu mais de 35 vezes entre 2011 e 2023.
- 95% dos casos são repassados às empresas dentro de 7 dias.

## Dashboard

[Acessar o dashboard no Looker Studio](https://datastudio.google.com/reporting/bf087cb6-4e74-4611-95bf-63f57b09692d/page/p_56hg36fw2d/edit)
