/*
Answer: What are the most optimal skills to learn (aka it's in high demand and a high-paying skill)?
Identify skills in high demand and associated with high average salaries for Data Analyst roles
- Concentrates on positions with specified salaries
Why? Targets skills that offer job security (high demand) and financial benefits (high salaries),
offering strategic insights for career development in data analysis
*/

SELECT skills_dim.skills, AVG(salary_year_avg)::INT AS avg_salary, COUNT(*) AS skill_count, skills_dim.type
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short LIKE '%Data Engineer%' AND 
    salary_year_avg IS NOT NULL
GROUP BY skills_dim.skill_id, skills_dim.type
HAVING COUNT(*) > 10
ORDER BY avg_salary DESC, COUNT(*) DESC
LIMIT 10


-- Old Query by Using CTEs from Queries 3 and 4

/*
WITH demanded_skills AS (
    SELECT skills_dim.skill_id, skills_dim.skills, COUNT(*) AS count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_title_short LIKE '%Data Engineer%' AND 
        salary_year_avg IS NOT NULL
    GROUP BY skills_dim.skill_id
),

top_paying_skills AS (
    SELECT skills_dim.skill_id, skills_dim.skills, AVG(salary_year_avg)::INT AS avg_salary, COUNT(*) AS skill_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_title_short LIKE '%Data Engineer%' AND 
        salary_year_avg IS NOT NULL
    GROUP BY skills_dim.skill_id
    HAVING COUNT(*) > 10
)

SELECT demanded_skills.skill_id, demanded_skills.skills, demanded_skills.count AS count, top_paying_skills.avg_salary
FROM demanded_skills
INNER JOIN top_paying_skills ON demanded_skills.skill_id = top_paying_skills.skill_id
ORDER BY avg_salary DESC, count DESC
LIMIT 25
*/