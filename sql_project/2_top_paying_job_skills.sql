WITH engineers_canada_jobs AS (
    SELECT job_id, job_title, company_dim.name as company_name, job_location, job_schedule_type, salary_year_avg
    FROM job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE job_title_short = 'Data Engineer'
    AND salary_year_avg IS NOT NULL
    AND job_location LIKE '%Canada%'
    ORDER BY salary_year_avg DESC
    LIMIT 10
)

SELECT job_title, company_name, job_location, job_schedule_type, salary_year_avg, skills_dim.skills AS skill_name
FROM engineers_canada_jobs
INNER JOIN skills_job_dim ON engineers_canada_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg DESC

/*Most Common Skills

Frequency across all top-paying jobs:

Skill	Mentions
SQL	6
Python	6
AWS	5
Spark	4
Azure	4
Java	4
Scala	4
Kafka	4
*/