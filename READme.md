# Overview
This report analyzes popular skills for Data Engineers and categorizes them by demand and average salary. The project was created with a desire to delve into the data job market and understand it effectively in order to optimize success in the industry.

This project was completed in conjuction with [Luke Barousse's SQL for Data Analytics Course](https://lukeb.co/sql), which provided all the data analyzed as well as a foundation for my analysis. The dataset used in this analysis was a series of data job postings in 2023 with detailed information on salaries, locations, and essential skills.

# Essential Questions
Below are the overarching questions answered through this project's analysis:

1. What are the top paying jobs for data engineers in Canada?
2. What skills do the top paying jobs for data engineers require?
3. What are the most demanded skills for data engineers?
4. What are the highest paid skills for data engineers?
5. What are the most optimal (high-paying and high-demand) skills for data engineers?

# Tools Used
Through this project, several tools were utilized to allow me to complete the report:
- **SQL**: The backbone of the analysis, allowing querying of the database and data analysis.
- **PostgreSQL**: The database management system most ideal for handling the job posting data.
- **Visual Studio Code**: The platform for database management and executing SQL queries.
- **Git & GitHub**: Essential for version control and sharing SQL scripts and analysis, ensuring project tracking.

# Analysis
## What are the top paying jobs for data engineers in Canada?
Based on the job market data, roles were filtered to data engineering in Canada and ordered by average salary, resulting in the identifcation of the top 10 highest paying jobs in data engineering in Canada. 

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
![Visualization of Top Skills Trends for Data Analysts](Final_Project/Images/real_skill_trend_chart.png)
*Line graph demonstrating the 2023 monthly trend of popular data job skills.*

### Insights
- Salaries range from $175K–$375K CAD, showing the vast possibilities of pay at the top of the data engineering spectrum.
- Nearly all the roles are **financial-related** or **software-related**, showing an overwhelming need for data engineers in these industries.
- Half the roles are from Toronto, highlighting Ontario's role as a hub for large-scale businesses.

 # Lessons
Several general insights can be made as a result of this analysis:
- **Skill Demand and Salary Correlation**: Skills that are more specialized or require more training usually lead to higher salaries. Advanced skills such as Python not only pay more but also are widely demanded in the job market.
- **Constant Market Change**: The dynamic nature of the data job market was revealed as skill demand and job postings shifted over 2023. Analyzing which skills are on the rise may give a candidate the upper hand when applying for roles.
- **Optimization of Skills for Data Roles**: Knowing which skills are the most demanded as well as the highest paying is key for data analysts to learn the right tools and maximize their returns. 

# Sources of Error
While this project was a good introduction to data analysis and provided a broad overview of the job market, it should not be considered an full comprehensive summary. Several factors contributed to inconsistencies in the project:
- **Inconsistent and Incorrect Data**: All the job postings analyzed were public data. A good deal of information provided was incorrect or missing altogether.
**Balancing Analysis Depth**: This project focused mainly on Canada, often examining only data engineering roles. For a more broad analysis, more roles or countries should be examined, and for a more specific analysis, a data engineer should consider narrowing down this analysis to a smaller geographical area.

 # Conclusion
This dive into the data job market was an informative exploration into the nuances and trends of modern roles in data science. Based on the insights drawn, those applying to data jobs should always be aware of the skills needed to succeed in certain roles and keep aware of the changing market to stay ahead in data engineering. This project serves as a basic foundation for data engineering and will prove useful in future projects and learning in the field of data.