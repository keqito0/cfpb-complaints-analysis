-- Query 1: Exploração inicial do dataset CFPB
-- Objetivo: entender volume, período e distribuições principais

-- Volume por ano
SELECT
  EXTRACT(YEAR FROM date_received) AS ano,
  COUNT(*) AS total_reclamacoes,
  COUNT(DISTINCT company_name) AS empresas_distintas,
  COUNT(DISTINCT product) AS produtos_distintos
FROM `bigquery-public-data.cfpb_complaints.complaint_database`
GROUP BY ano
ORDER BY ano;
