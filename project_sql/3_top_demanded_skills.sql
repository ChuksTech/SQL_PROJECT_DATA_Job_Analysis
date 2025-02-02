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
Question: What are the most in-demand skills for data engineers working remotely?
-Join job postings to inner join table similar to query 3
-Identify the top 20 in-demand skills for a data engineer.
-Focus on all job postings.
-Why? Retrieves the top 20 skills with the highest demand in the job market,
    providing insights into the most valuable skills for job seekers.
*/

SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Engineer' AND
    job_work_from_home = True
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 20