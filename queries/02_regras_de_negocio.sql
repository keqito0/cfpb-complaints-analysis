-- Query 2: Distribuição de tipos de resposta
-- Objetivo: definir o que será considerado "resolvido"

SELECT
  company_response_to_consumer,
  COUNT(*) AS total,
  ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS pct
FROM `bigquery-public-data.cfpb_complaints.complaint_database`
WHERE company_response_to_consumer IS NOT NULL
GROUP BY company_response_to_consumer
ORDER BY total DESC;

-- Query 3: Distribuição de tempo de tratativa
-- Objetivo: definir o prazo de SLA

SELECT
  DATE_DIFF(date_sent_to_company, date_received, DAY) AS dias_para_resposta,
  COUNT(*) AS total
FROM `bigquery-public-data.cfpb_complaints.complaint_database`
WHERE date_sent_to_company IS NOT NULL
  AND date_received IS NOT NULL
  AND DATE_DIFF(date_sent_to_company, date_received, DAY) >= 0
GROUP BY dias_para_resposta
ORDER BY dias_para_resposta ASC
LIMIT 30;
