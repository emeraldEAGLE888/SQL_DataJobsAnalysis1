# Overview
This report analyzes popular skills for Data Engineers and categorizes them by demand and average salary. The project was created with a desire to delve into the data job market and understand it effectively in order to optimize success in the industry.

This project was completed in conjuction with [Luke Barousse's SQL for Data Analytics Course](https://lukeb.co/sql), which provided all the data analyzed as well as a foundation for my analysis. The dataset used in this analysis was a series of data job postings in 2023 with detailed information on salaries, locations, and essential skills.

# Essential Questions
Below are the overarching questions answered through this project's analysis:

1. What are the top paying jobs for data engineers in Canada and what skills do they require?
2. What are the most optimal (in demand and high-paying) skills in data engineering jobs?

# Tools Used
Through this project, several tools were utilized to allow me to complete the report:
- **SQL**: The backbone of the analysis, allowing querying of the database and data analysis.
- **PostgreSQL**: The database management system most ideal for handling the job posting data.
- **Visual Studio Code**: The platform for database management and executing SQL queries.
- **Git & GitHub**: Essential for version control and sharing SQL scripts and analysis, ensuring project tracking.

# Analysis
## What are the top paying jobs for data engineers in Canada and what skills do they require?
Based on the job market data, roles were filtered to data engineering in Canada and ordered by average salary, resulting in the identifcation of the top 10 highest paying jobs in data engineering in Canada. I then compiled the skills required for each of the roles listed to identify some skills to watch for being needed in high-paying data engineering roles.

### Querying the Jobs 
```sql
SELECT job_title, company_dim.name as company_name, job_location, job_schedule_type, salary_year_avg
FROM job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE job_title_short = 'Data Engineer'
AND salary_year_avg IS NOT NULL
AND job_location LIKE '%Canada%'
ORDER BY salary_year_avg DESC
LIMIT 10;
```
### Result
| Job Title                    | Company               | Location             | Schedule Type | Salary   |
| ---------------------------- | --------------------- | -------------------- | ------------- | -------- |
| Director of Data Engineering | Ripple                | Toronto, ON          | Full-time     | $375,000 |
| Distinguished Data Engineer  | eSmartloan            | Richmond, BC         | Full-time     | $244,500 |
| Principal Data Engineer      | Ripple                | Toronto, ON          | Full-time     | $225,000 |
| Lead Data Engineer           | Capital One           | British Columbia, BC | Full-time     | $211,000 |
| Senior Software Engineer     | Gusto                 | Toronto, ON          | Full-time     | $200,000 |
| Sr. Data Engineer            | Productboard          | Vancouver, BC        | Full-time     | $190,000 |
| Data Platform Engineer       | Grammarly             | Canada               | Full-time     | $188,000 |
| Data Engineering Manager     | 360insights.com       | Moncton, NB          | Full-time     | $175,000 |
| Sr. Staff Data Engineer      | Generac Power Systems | Vancouver, BC        | Full-time     | $175,000 |
| Senior Developer             | Bell Canada           | Mississauga, ON      | Full-time     | $175,000 |

### Querying the Skills 
```sql
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
```
### Result
| Skill      | Postings |
| ---------- | -------: |
| SQL        |        7 |
| Python     |        7 |
| AWS        |        6 |
| Spark      |        5 |
| Kafka      |        5 |
| Scala      |        4 |
| Java       |        4 |
| Azure      |        4 |
| Hadoop     |        3 |
| Databricks |        3 |

### Insights
- Salaries range from **$175K–$375K** CAD, showing the vast possibilities of pay at the top of the data engineering spectrum.
- Nearly all the roles are **financial-related** or **software-related**, showing an overwhelming need for data engineers in these industries.
- **SQL** and **Python** are the most popular skills, both appearing in 7/10 roles. They're the baseline for any high-paying data engineering position.
- **Cloud platforms** are also essential, with AWS leading (6 roles) and Azure in 4 roles.
- **Data processing** tools are also helpful: Spark, Kafka, Scala, and Hadoop all appear in 3–5 roles.

## What are the most optimal (in demand and high-paying) skills in data engineering jobs?
Next, the most demanded and highest-paying skills in data engineering overall were examined. By querying the skills and ordering by total number of postings containing them OR the average salary for each of the skills, a list of the top 10 skills in each category was obtained. For the purpose of this query, no location filter was applied. Skills were also filtered so that they were required to have at least 10 total postings to avoid salary outliers.

Note: this query is from the 5th query of this project, which combines the 3rd and 4th queries into one succinct file.

### Query 
```sql
SELECT skills_dim.skills, AVG(salary_year_avg)::INT AS avg_salary, COUNT(*) AS skill_count, skills_dim.type
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short LIKE '%Data Engineer%' AND 
    salary_year_avg IS NOT NULL
GROUP BY skills_dim.skill_id, skills_dim.type
HAVING COUNT(*) > 10
ORDER BY COUNT(*) DESC, avg_salary DESC -- for most demanded
LIMIT 10
```
### Result
### Most Demanded Skills
| Skill     | Postings | Salary   | Type        |
|-----------|---------:|----------:|-------------|
| SQL       | 4289     | $132,986  | programming |
| Python    | 4196     | $136,694  | programming |
| AWS       | 2887     | $139,027  | cloud       |
| Spark     | 2297     | $140,994  | libraries   |
| Azure     | 2059     | $134,285  | cloud       |
| Java      | 1656     | $141,600  | programming |
| Snowflake | 1571     | $142,562  | cloud       |
| Kafka     | 1319     | $147,097  | libraries   |
| Hadoop    | 1226     | $141,345  | libraries   |
| Scala     | 1222     | $146,949  | programming |

### Highest Paid Skills (w/ 10+ postings)
| Skill     | Salary   | Postings | Type          |
|-----------|----------:|----------:|---------------|
| Mongo     | $176,119  | 239       | programming   |
| Node      | $175,807  | 39        | webframeworks |
| Cassandra | $156,724  | 432       | databases     |
| Rust      | $151,361  | 30        | programming   |
| Shell     | $149,303  | 569       | programming   |
| Kafka     | $147,097  | 1319      | libraries     |
| Scala     | $146,949  | 1222      | programming   |
| Angular   | $146,583  | 54        | webframeworks |
| MySQL     | $145,363  | 612       | databases     |
| Splunk    | $145,300  | 71        | analyst tools |

### Insights
- **SQL** and **Python** are by far the most demanded skills in data engineering, both having almost 4x the amount of job postings as the 10th most popular skill (**Scala**).
- A wide variety of skill types are in high demand, including **programming**, **cloud**, and **libraries** based skills.
- More niche tools like **Mongo**, **Node**, and **Cassandra** take the top spots for highest-paid skills, and skill types expand further to include **database** and **web framework** tools.
- **Kafka** and **Scala** are the only tools to appear on both lists, showing their strength not only as very demanded skills but also higher-paying on average.

# Main Takeaways
- Data engineers work within nearly every industry but are especially found within **financial** or **software** related roles.
- These positions often require a diverse mix of **programming**, **cloud platform**, and **data processing** related skills in order to complete the various tasks of a data engineer.
- While **SQL** and **Python** are the most common skills needed for any data engineer, other more specialized skills like **Kafka** and **Scala** are often higher-paying within more senior roles.

# Sources of Error
While this project was a good introduction to data analysis and provided a broad overview of the job market, it is not a comprehensive summary. Several factors contributed to inconsistencies in the project:
- **Inconsistent and Incorrect Data**: All the job postings analyzed were public data. A good deal of information provided was incorrect or missing altogether, including salaries or job locations.
- **Balancing Analysis Depth**: This project focused mainly on global postings, often examining only data engineering roles. For a more broad analysis, more roles or countries should be examined, and for a more specific analysis, a data engineer should consider narrowing down this analysis to a smaller geographical area.

 # Conclusion
This basic look at the data engineering job market was a good first step into analyzing what skills are necessary to be a data engineer. Based on the insights drawn, there is a multitude of skills that aspiring data engineers should target in order to become more technically sound in their field. This project serves as a basic foundation for data engineering and will prove useful in future projects and learning in the field of data.