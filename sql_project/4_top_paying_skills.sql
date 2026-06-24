/*
Answer: What are the top skills based on salary?
Look at the average salary associated with each skill for Data Engineer positions
Focuses on roles with specified salaries, regardless of location
Why? It reveals how different skills impact salary levels for Data Engineers and helps identify the most financially rewarding skills to acquire or improve
*/

SELECT skills_dim.skills, AVG(salary_year_avg)::INT AS avg_salary, COUNT(*) AS skill_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short LIKE '%Data Engineer%' AND 
    salary_year_avg IS NOT NULL
GROUP BY skills_dim.skill_id
HAVING COUNT(*) > 10
ORDER BY avg_salary DESC
LIMIT 25;