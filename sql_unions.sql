WITH job_postings_q1 AS (
    SELECT *
    FROM january_jobs

    UNION ALL

    SELECT *
    FROM february_jobs

    UNION ALL

    SELECT *
    FROM march_jobs
)

SELECT 
    job_title_short, job_location, salary_year_avg
FROM job_postings_q1
WHERE 
    salary_year_avg > 70000 AND
    job_title_short LIKE '%Analyst'
ORDER BY salary_year_avg DESC;