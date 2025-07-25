/* What are the most optimal skills to learn */

/* WITH skills_demand AS (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        count(skills_job_dim.job_id) AS demand_count

    FROM job_postings_fact

    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id

    WHERE
        job_title_short = 'Data Analyst' 
        AND job_location = 'Anywhere'
        AND salary_year_avg IS NOT NULL

    GROUP BY 
        skills_dim.skill_id
),
    Average_salary AS (
    SELECT
        skills_job_dim.skill_id,
        ROUND(AVG(salary_year_avg),0) AS avg_salary

    FROM job_postings_fact

    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id

    WHERE
        job_title_short = 'Data Analyst' 
        AND salary_year_avg IS NOT NULL
        AND job_location = 'Anywhere'

    GROUP BY 
        skills_job_dim.skill_id    
)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary

FROM
    skills_demand
INNER JOIN Average_salary ON Average_salary.skill_id = skills_demand.skill_id

WHERE
    demand_count > 10

ORDER BY 
     avg_salary DESC,
     demand_count DESC
   

LIMIT 25; */


SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT (skills_job_dim.job_id) AS demand_count,
    ROUND (AVG (job_postings_fact.salary_year_avg),0) AS avg_salary

FROM
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id

WHERE
    job_title_short = 'Data Analyst'
    AND job_location = 'Anywhere'
    AND salary_year_avg IS NOT NULL

GROUP BY
    skills_dim.skill_id

HAVING
    COUNT (skills_job_dim.job_id)>10
    
ORDER BY 
    avg_salary DESC,
    demand_count DESC

LIMIT 25;


