--CapStone Project
/*
Goals of the project.
1. You are an aspiring data nerd looking to analyze the top-paying roles and skills
2. You will create SQL queries to explore this large dataset specific to you
3. For those job searching or looking for a promotion; you can not only use this project to showcase experience BUT also to extract what roles/skills you should target.
DELIVERABLES
a. top_paying_jobs
b. top_paying_job_skills
c. top_demanded_skills
d. top_paying_skills
e. optimal_skills
Questions to Answer
1. What are the top-paying jobs for my role?
2. What are the skills required to these top-paying roles?
3. What are the most in-demand skills for my role?
4. What are the top skills based on salary for my role?
5. What are the most optimal skills to learn?
      Optimal: High Demand AND High Paying
*/
 
/*
Question: What are the top-paying data engineer jobs?
-Identify the top 10 highest-paying Data Engineer roles that are available remotely.
-Focuses on job postings with specified salaries (remove nulls).
-Why? Highlight the top-paying opportunities for Data Engineers, offering insights into employment
*/

SELECT
      job_id,
      name AS company_name,
      job_title,
      job_location,
      job_schedule_type,
      salary_year_avg,
      job_posted_date
FROM
      job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
      job_title_short = 'Data Engineer' AND
      job_location = 'Anywhere' AND
      salary_year_avg IS NOT NULL
ORDER BY
      salary_year_avg DESC
LIMIT 20
