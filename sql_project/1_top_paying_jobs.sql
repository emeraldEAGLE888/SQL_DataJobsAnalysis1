-- What are the top 10 highest paying jobs in Canada for Data Engineers?
-- Ensure to remove NULLS

SELECT job_title, company_dim.name as company_name, job_location, job_schedule_type, salary_year_avg
FROM job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE job_title_short = 'Data Engineer'
AND salary_year_avg IS NOT NULL
AND job_location LIKE '%Canada%'
ORDER BY salary_year_avg DESC
LIMIT 10;