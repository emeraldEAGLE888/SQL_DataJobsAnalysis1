WITH remote_job_skills AS (
    SELECT 
        skills_to_job.skill_id, COUNT(*) AS skill_count
    FROM 
        skills_job_dim AS skills_to_job
    INNER JOIN 
        job_postings_fact ON skills_to_job.job_id = job_postings_fact.job_id
    WHERE 
        job_postings_fact.job_work_from_home = TRUE
        AND job_title_short LIKE 'Data Analyst'
    GROUP BY 
        skills_to_job.skill_id
    ORDER BY 
        skill_count DESC
)

SELECT 
    skills AS skill_name, skill_count
FROM 
    remote_job_skills
INNER JOIN 
    skills_dim on remote_job_skills.skill_id = skills_dim.skill_id
ORDER BY remote_job_skills.skill_count DESC
LIMIT 5;