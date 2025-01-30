 Select *
 From job_postings_fact
 LIMIT 100;

 SELECT 
 '2023-02-19' :: Date,
 '123' :: integer,
 'true' ::boolean,
 '3.14' :: Real;

 SELECT
    job_title_short as title,
    job_location as location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' as date_time,
    Extract(Month From job_posted_date) as date_month,
    Extract(Year From job_posted_date) as date_year
 From
    job_postings_fact
 Limit 100;

 SELECT
   COUNT(job_id),
   EXTRACT(MONTH From job_posted_date) as month 
 FROM
   job_postings_fact
 GROUP BY
   month
 LIMIT 5;

 SELECT
   COUNT(job_id) as job_posted_count,
   EXTRACT(MONTH From job_posted_date) as month 
 FROM
   job_postings_fact
 WHERE
   job_title_short = 'Data Engineer'
 GROUP BY
   month
 ORDER BY
   job_posted_count DESC;

/*Here I'll be creating table from other table, i am tring
to create tables for each month of the job postings*/

SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 1
LIMIT 10;

-- Creating a table for job_posted_date for the month of January.
CREATE TABLE january_jobs AS
   SELECT *
   FROM job_postings_fact
   WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

-- Creating a table for job_posted_date for the month of Febuary.
CREATE TABLE febuary_jobs AS
   SELECT *
   FROM job_postings_fact
   WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

-- Creating a table for job_posted_date for the month of March.
CREATE TABLE march_jobs AS
   SELECT *
   FROM job_postings_fact
   WHERE EXTRACT(MONTH FROM job_posted_date) = 3;

-- My Assignment to create job_posted table for Data Engineer for the 12 months.
SELECT *
From january_jobs;

-- CASE EXPRESSION
SELECT
   job_title_short,
   job_location
FROM job_postings_fact;
/*
Label a new column as follows:
- 'Anywhere' jobs as 'Remote'
- 'New York, NY' jobs as 'Local'
- Otherwise 'Onsite'
*/
SELECT
   job_title_short,
   job_location,
   CASE
      WHEN job_location = 'Anywhere' THEN 'Remote'
      WHEN job_location = 'New York, NY' THEN 'Local'
      ELSE 'Onsite'
   END AS location_category
FROM job_postings_fact;

-- Aggregating to get number of Onsite,Remote, and Local jobs analysing for Data Engineer.
SELECT
   COUNT(job_id) AS number_of_jobs,
   CASE
      WHEN job_location = 'Anywhere' THEN 'Remote'
      WHEN job_location = 'New York, NY' THEN 'Local'
      ELSE 'Onsite'
   END AS location_category
FROM job_postings_fact
WHERE
   job_title_short = 'Data Engineer'
GROUP BY
   location_category;

/*Subqueries and CTEs used to organize and simplify complex queries, 
by creating Temporary result set. Helps to break down query into more manageable parts.
Subqueries are for simpler queries. CTEs are for more complex queries.*/

--Here we want to create a temporary table for january jobs

-- Using Subqueries
SELECT *
FROM (
   SELECT *
   FROM job_postings_fact
   WHERE EXTRACT(MONTH FROM job_posted_date) = 1
) AS january_jobs_temp;

--Using Common Table Expressions(CTEs) which can be reference within a select, insert, update, or delete statement.
With january_jobs_temp AS (
   SELECT *
   FROM job_postings_fact
   WHERE EXTRACT(MONTH FROM job_posted_date) = 1
)

SELECT *
FROM january_jobs_temp; 

--More queries on Subqueries

--Here i am looking at companies job postings that do no require a degree, i'll be getting the company name,job title.
SELECT NAME AS company_name
FROM company_dim
WHERE company_id IN(
   SELECT
      company_id
   FROM
      job_postings_fact
   WHERE
      job_no_degree_mention = true
)

--More queries on CTEs
--Here i'll be finding the companies with the most job openings.
/*
PROCESS
-Get the total number of job postings per company id (job_posting_fact)
-Return the total number of jobs with the company name (company_dim)
*/

WITH company_job_count AS (
   SELECT 
      company_id,
      COUNT(*) AS total_jobs
   FROM
      job_postings_fact
   GROUP BY
      company_id
)

SELECT 
   company_dim.name AS company_name,
   company_job_count.total_jobs
FROM 
   company_dim
LEFT JOIN 
   company_job_count ON company_job_count.company_id = company_dim.company_id
ORDER BY
   total_jobs DESC;

/*
Find the count of the number of remote job postings per skill
   -Display the top 5 skills by their demand in remote jobs.
   -Include skill ID, name, and count of postings requiring the skill
   -Do this for Data Engineering
*/

WITH remote_job_skills AS ( 
SELECT
   skill_id,
   COUNT(*) AS skill_count
FROM
   skills_job_dim AS skills_to_job
INNER JOIN job_postings_fact AS job_postings ON job_postings.job_id = skills_to_job.job_id
WHERE
   job_postings.job_work_from_home = True AND 
   job_postings.job_title_short = 'Data Engineer'
GROUP BY
   skill_id  
)

SELECT 
   skills.skill_id,
   skills as skill_name, 
   skill_count
FROM remote_job_skills
INNER JOIN skills_dim AS skills ON skills.skill_id = remote_job_skills.skill_id
ORDER BY
   skill_count DESC
LIMIT 5;

--UNOINS
/*Using Unions on the Jan, Feb, and March tables*/

SELECT
   job_title_short,
   company_id,
   job_location
FROM
   january_jobs

UNION ALL

SELECT
   job_title_short,
   company_id,
   job_location
FROM
   febuary_jobs

UNION ALL

SELECT
   job_title_short,
   company_id,
   job_location
FROM
   march_jobs

/*
Find job postings from the first quarter that have a salary greater then $70k
- Combine job posting tables from the first quarter of 2023(Jan-Mar)
- Get job postings with an average yearly salary > $70,000
*/

SELECT 
   quarter1_job_postings.job_title_short,
   quarter1_job_postings.job_location,
   quarter1_job_postings.job_via,
   quarter1_job_postings.job_posted_date :: date,
   quarter1_job_postings.salary_year_avg
FROM (

   SELECT *
   FROM january_jobs
   UNION ALL
   SELECT *
   FROM febuary_jobs
   UNION ALL
   SELECT *
   FROM march_jobs
) AS quarter1_job_postings
WHERE
   quarter1_job_postings.salary_year_avg >  70000 AND
   quarter1_job_postings.job_title_short = 'Data Engineer' AND
   quarter1_job_postings.job_location = 'Anywhere'
ORDER BY
   quarter1_job_postings.salary_year_avg DESC

--Codes without the extension quarter1_job_postings

SELECT 
   job_title_short,
   job_location,
   job_via,
   job_posted_date :: date,
   salary_year_avg
FROM (

   SELECT *
   FROM january_jobs
   UNION ALL
   SELECT *
   FROM febuary_jobs
   UNION ALL
   SELECT *
   FROM march_jobs
) AS quarter1_job_postings
WHERE
   salary_year_avg >  70000 AND
   job_title_short = 'Data Engineer' AND
   job_location = 'Anywhere'
ORDER BY
   salary_year_avg DESC

--CapStone Project
/*
Goals of the project.
1. You are an aspiring data nerd looking to analyze the top-paying roles and skills
2. You will create SQL queries to explore this large dataset specific to you
3. For those job searching or looking for a promotion; you can not only use this project to showcase experience BUT also to extract what roles/skills you should target.
Deliverables
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



