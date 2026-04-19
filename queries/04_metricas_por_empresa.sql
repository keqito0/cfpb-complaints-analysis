-- Query 4: Métricas por empresa
-- Objetivo: calcular resolutividade, SLA e contestação por empresa

WITH base AS (
  SELECT
    company_name,
    DATE_DIFF(date_sent_to_company, date_received, DAY) AS dias_tratativa,
    CASE
      WHEN DATE_DIFF(date_sent_to_company, date_received, DAY) <= 7 THEN 1
      ELSE 0
    END AS dentro_prazo,
    CASE
      WHEN company_response_to_consumer IN (
        'Closed with explanation',
        'Closed with non-monetary relief',
        'Closed with monetary relief',
        'Closed with relief'
      ) THEN 1
      ELSE 0
    END AS resolvido,
    CASE WHEN consumer_disputed = TRUE THEN 1 ELSE 0 END AS contestado
  FROM `bigquery-public-data.cfpb_complaints.complaint_database`
  WHERE date_received IS NOT NULL
    AND date_sent_to_company IS NOT NULL
    AND DATE_DIFF(date_sent_to_company, date_received, DAY) >= 0
    AND company_response_to_consumer != 'In progress'
)

SELECT
  company_name,
  COUNT(*) AS total_reclamacoes,
  ROUND(AVG(dias_tratativa), 1) AS media_dias_tratativa,
  ROUND(SUM(dentro_prazo) * 100.0 / COUNT(*), 2) AS pct_dentro_prazo,
  ROUND(SUM(resolvido) * 100.0 / COUNT(*), 2) AS pct_resolvido,
  ROUND(SUM(contestado) * 100.0 / COUNT(*), 2) AS pct_contestado
FROM base
GROUP BY company_name
HAVING COUNT(*) >= 100
ORDER BY total_reclamacoes DESC
LIMIT 20;
