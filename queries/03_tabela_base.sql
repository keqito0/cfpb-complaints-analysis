-- Query 3: View base do projeto
-- Objetivo: consolidar todas as regras de negócio em uma estrutura única

CREATE OR REPLACE VIEW `thermal-effort-324516.cfpb_analysis.vw_base` AS
SELECT
  complaint_id,
  date_received,
  date_sent_to_company,
  DATE_DIFF(date_sent_to_company, date_received, DAY) AS dias_tratativa,
  CASE
    WHEN DATE_DIFF(date_sent_to_company, date_received, DAY) <= 7 THEN 'Dentro do prazo'
    ELSE 'Fora do prazo'
  END AS status_sla,
  product,
  subproduct,
  issue,
  company_name,
  state,
  submitted_via,
  company_response_to_consumer,
  CASE
    WHEN company_response_to_consumer IN (
      'Closed with explanation',
      'Closed with non-monetary relief',
      'Closed with monetary relief',
      'Closed with relief'
    ) THEN 'Resolvido'
    ELSE 'Não resolvido'
  END AS status_resolucao,
  timely_response,
  consumer_disputed
FROM `bigquery-public-data.cfpb_complaints.complaint_database`
WHERE date_received IS NOT NULL
  AND date_sent_to_company IS NOT NULL
  AND DATE_DIFF(date_sent_to_company, date_received, DAY) >= 0
  AND company_response_to_consumer != 'In progress';
