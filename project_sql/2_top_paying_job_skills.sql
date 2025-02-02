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
Question: What skills are required for the top-paying data engineer jobs?
-Use the top 10 highest-paying Data Engineer jobs from query
-Add the specific skills required for these roles
-Why? It provides a detailed look at which high-paying jobs demand certain skills,
    helping job seekers understand which skills to develop that align with top salaries.
*/

WITH top_paying_jobs AS (
    SELECT
        job_id,
        name AS company_name,
        job_title,
        salary_year_avg
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
)

SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC

/*
Here are the top 10 most common skills for data engineering roles based on job postings in 2023:

Python – 15 mentions
Spark – 10 mentions
SQL – 9 mentions
Kafka – 9 mentions
Kubernetes – 7 mentions
AWS – 6 mentions
Snowflake – 5 mentions
Scala – 5 mentions
Java – 5 mentions
NoSQL – 4 mentions
It looks like Python, Spark, and SQL 
are the most in-demand skills. 
Let me know if you want deeper insights, 
like trends across companies or salary correlations!

JSON
[
  {
    "job_id": 21321,
    "company_name": "Engtal",
    "job_title": "Data Engineer",
    "salary_year_avg": "325000.0",
    "skills": "python"
  },
  {
    "job_id": 21321,
    "company_name": "Engtal",
    "job_title": "Data Engineer",
    "salary_year_avg": "325000.0",
    "skills": "spark"
  },
  {
    "job_id": 21321,
    "company_name": "Engtal",
    "job_title": "Data Engineer",
    "salary_year_avg": "325000.0",
    "skills": "pandas"
  },
  {
    "job_id": 21321,
    "company_name": "Engtal",
    "job_title": "Data Engineer",
    "salary_year_avg": "325000.0",
    "skills": "numpy"
  },
  {
    "job_id": 21321,
    "company_name": "Engtal",
    "job_title": "Data Engineer",
    "salary_year_avg": "325000.0",
    "skills": "pyspark"
  },
  {
    "job_id": 21321,
    "company_name": "Engtal",
    "job_title": "Data Engineer",
    "salary_year_avg": "325000.0",
    "skills": "hadoop"
  },
  {
    "job_id": 21321,
    "company_name": "Engtal",
    "job_title": "Data Engineer",
    "salary_year_avg": "325000.0",
    "skills": "kafka"
  },
  {
    "job_id": 21321,
    "company_name": "Engtal",
    "job_title": "Data Engineer",
    "salary_year_avg": "325000.0",
    "skills": "kubernetes"
  },
  {
    "job_id": 157003,
    "company_name": "Engtal",
    "job_title": "Data Engineer",
    "salary_year_avg": "325000.0",
    "skills": "python"
  },
  {
    "job_id": 157003,
    "company_name": "Engtal",
    "job_title": "Data Engineer",
    "salary_year_avg": "325000.0",
    "skills": "spark"
  },
  {
    "job_id": 157003,
    "company_name": "Engtal",
    "job_title": "Data Engineer",
    "salary_year_avg": "325000.0",
    "skills": "pandas"
  },
  {
    "job_id": 157003,
    "company_name": "Engtal",
    "job_title": "Data Engineer",
    "salary_year_avg": "325000.0",
    "skills": "numpy"
  },
  {
    "job_id": 157003,
    "company_name": "Engtal",
    "job_title": "Data Engineer",
    "salary_year_avg": "325000.0",
    "skills": "pyspark"
  },
  {
    "job_id": 157003,
    "company_name": "Engtal",
    "job_title": "Data Engineer",
    "salary_year_avg": "325000.0",
    "skills": "hadoop"
  },
  {
    "job_id": 157003,
    "company_name": "Engtal",
    "job_title": "Data Engineer",
    "salary_year_avg": "325000.0",
    "skills": "kafka"
  },
  {
    "job_id": 157003,
    "company_name": "Engtal",
    "job_title": "Data Engineer",
    "salary_year_avg": "325000.0",
    "skills": "kubernetes"
  },
  {
    "job_id": 270455,
    "company_name": "Durlston Partners",
    "job_title": "Data Engineer",
    "salary_year_avg": "300000.0",
    "skills": "sql"
  },
  {
    "job_id": 270455,
    "company_name": "Durlston Partners",
    "job_title": "Data Engineer",
    "salary_year_avg": "300000.0",
    "skills": "python"
  },
  {
    "job_id": 230458,
    "company_name": "Twitch",
    "job_title": "Director of Engineering - Data Platform",
    "salary_year_avg": "251000.0",
    "skills": "spark"
  },
  {
    "job_id": 230458,
    "company_name": "Twitch",
    "job_title": "Director of Engineering - Data Platform",
    "salary_year_avg": "251000.0",
    "skills": "hadoop"
  },
  {
    "job_id": 230458,
    "company_name": "Twitch",
    "job_title": "Director of Engineering - Data Platform",
    "salary_year_avg": "251000.0",
    "skills": "kafka"
  },
  {
    "job_id": 230458,
    "company_name": "Twitch",
    "job_title": "Director of Engineering - Data Platform",
    "salary_year_avg": "251000.0",
    "skills": "tensorflow"
  },
  {
    "job_id": 230458,
    "company_name": "Twitch",
    "job_title": "Director of Engineering - Data Platform",
    "salary_year_avg": "251000.0",
    "skills": "keras"
  },
  {
    "job_id": 230458,
    "company_name": "Twitch",
    "job_title": "Director of Engineering - Data Platform",
    "salary_year_avg": "251000.0",
    "skills": "pytorch"
  },
  {
    "job_id": 561728,
    "company_name": "AI Startup",
    "job_title": "Data Engineer",
    "salary_year_avg": "250000.0",
    "skills": "python"
  },
  {
    "job_id": 561728,
    "company_name": "AI Startup",
    "job_title": "Data Engineer",
    "salary_year_avg": "250000.0",
    "skills": "scala"
  },
  {
    "job_id": 561728,
    "company_name": "AI Startup",
    "job_title": "Data Engineer",
    "salary_year_avg": "250000.0",
    "skills": "r"
  },
  {
    "job_id": 561728,
    "company_name": "AI Startup",
    "job_title": "Data Engineer",
    "salary_year_avg": "250000.0",
    "skills": "azure"
  },
  {
    "job_id": 595768,
    "company_name": "Signify Technology",
    "job_title": "Principal Data Engineer",
    "salary_year_avg": "250000.0",
    "skills": "python"
  },
  {
    "job_id": 595768,
    "company_name": "Signify Technology",
    "job_title": "Principal Data Engineer",
    "salary_year_avg": "250000.0",
    "skills": "scala"
  },
  {
    "job_id": 595768,
    "company_name": "Signify Technology",
    "job_title": "Principal Data Engineer",
    "salary_year_avg": "250000.0",
    "skills": "databricks"
  },
  {
    "job_id": 595768,
    "company_name": "Signify Technology",
    "job_title": "Principal Data Engineer",
    "salary_year_avg": "250000.0",
    "skills": "spark"
  },
  {
    "job_id": 543728,
    "company_name": "Signify Technology",
    "job_title": "Staff Data Engineer",
    "salary_year_avg": "250000.0",
    "skills": "python"
  },
  {
    "job_id": 543728,
    "company_name": "Signify Technology",
    "job_title": "Staff Data Engineer",
    "salary_year_avg": "250000.0",
    "skills": "scala"
  },
  {
    "job_id": 543728,
    "company_name": "Signify Technology",
    "job_title": "Staff Data Engineer",
    "salary_year_avg": "250000.0",
    "skills": "databricks"
  },
  {
    "job_id": 543728,
    "company_name": "Signify Technology",
    "job_title": "Staff Data Engineer",
    "salary_year_avg": "250000.0",
    "skills": "spark"
  },
  {
    "job_id": 151972,
    "company_name": "Movable Ink",
    "job_title": "Principal Data Engineer (Remote)",
    "salary_year_avg": "245000.0",
    "skills": "nosql"
  },
  {
    "job_id": 151972,
    "company_name": "Movable Ink",
    "job_title": "Principal Data Engineer (Remote)",
    "salary_year_avg": "245000.0",
    "skills": "aws"
  },
  {
    "job_id": 151972,
    "company_name": "Movable Ink",
    "job_title": "Principal Data Engineer (Remote)",
    "salary_year_avg": "245000.0",
    "skills": "gcp"
  },
  {
    "job_id": 204320,
    "company_name": "Handshake",
    "job_title": "Staff Data Engineer",
    "salary_year_avg": "245000.0",
    "skills": "go"
  },
  {
    "job_id": 2446,
    "company_name": "Meta",
    "job_title": "Data Engineering Manager",
    "salary_year_avg": "242000.0",
    "skills": "sql"
  },
  {
    "job_id": 2446,
    "company_name": "Meta",
    "job_title": "Data Engineering Manager",
    "salary_year_avg": "242000.0",
    "skills": "python"
  },
  {
    "job_id": 2446,
    "company_name": "Meta",
    "job_title": "Data Engineering Manager",
    "salary_year_avg": "242000.0",
    "skills": "java"
  },
  {
    "job_id": 2446,
    "company_name": "Meta",
    "job_title": "Data Engineering Manager",
    "salary_year_avg": "242000.0",
    "skills": "perl"
  },
  {
    "job_id": 609418,
    "company_name": "Meta",
    "job_title": "Data Engineering Manager",
    "salary_year_avg": "242000.0",
    "skills": "sql"
  },
  {
    "job_id": 609418,
    "company_name": "Meta",
    "job_title": "Data Engineering Manager",
    "salary_year_avg": "242000.0",
    "skills": "python"
  },
  {
    "job_id": 609418,
    "company_name": "Meta",
    "job_title": "Data Engineering Manager",
    "salary_year_avg": "242000.0",
    "skills": "java"
  },
  {
    "job_id": 609418,
    "company_name": "Meta",
    "job_title": "Data Engineering Manager",
    "salary_year_avg": "242000.0",
    "skills": "perl"
  },
  {
    "job_id": 456144,
    "company_name": "LTK",
    "job_title": "Data Engineering Manager - Event Streaming and Real-Time Analytics",
    "salary_year_avg": "235000.0",
    "skills": "sql"
  },
  {
    "job_id": 456144,
    "company_name": "LTK",
    "job_title": "Data Engineering Manager - Event Streaming and Real-Time Analytics",
    "salary_year_avg": "235000.0",
    "skills": "python"
  },
  {
    "job_id": 456144,
    "company_name": "LTK",
    "job_title": "Data Engineering Manager - Event Streaming and Real-Time Analytics",
    "salary_year_avg": "235000.0",
    "skills": "scala"
  },
  {
    "job_id": 456144,
    "company_name": "LTK",
    "job_title": "Data Engineering Manager - Event Streaming and Real-Time Analytics",
    "salary_year_avg": "235000.0",
    "skills": "r"
  },
  {
    "job_id": 456144,
    "company_name": "LTK",
    "job_title": "Data Engineering Manager - Event Streaming and Real-Time Analytics",
    "salary_year_avg": "235000.0",
    "skills": "golang"
  },
  {
    "job_id": 456144,
    "company_name": "LTK",
    "job_title": "Data Engineering Manager - Event Streaming and Real-Time Analytics",
    "salary_year_avg": "235000.0",
    "skills": "aws"
  },
  {
    "job_id": 456144,
    "company_name": "LTK",
    "job_title": "Data Engineering Manager - Event Streaming and Real-Time Analytics",
    "salary_year_avg": "235000.0",
    "skills": "redshift"
  },
  {
    "job_id": 456144,
    "company_name": "LTK",
    "job_title": "Data Engineering Manager - Event Streaming and Real-Time Analytics",
    "salary_year_avg": "235000.0",
    "skills": "spark"
  },
  {
    "job_id": 456144,
    "company_name": "LTK",
    "job_title": "Data Engineering Manager - Event Streaming and Real-Time Analytics",
    "salary_year_avg": "235000.0",
    "skills": "kafka"
  },
  {
    "job_id": 14251,
    "company_name": "Hinge",
    "job_title": "Staff Data Engineer",
    "salary_year_avg": "234500.0",
    "skills": "sql"
  },
  {
    "job_id": 14251,
    "company_name": "Hinge",
    "job_title": "Staff Data Engineer",
    "salary_year_avg": "234500.0",
    "skills": "python"
  },
  {
    "job_id": 14251,
    "company_name": "Hinge",
    "job_title": "Staff Data Engineer",
    "salary_year_avg": "234500.0",
    "skills": "aws"
  },
  {
    "job_id": 14251,
    "company_name": "Hinge",
    "job_title": "Staff Data Engineer",
    "salary_year_avg": "234500.0",
    "skills": "bigquery"
  },
  {
    "job_id": 14251,
    "company_name": "Hinge",
    "job_title": "Staff Data Engineer",
    "salary_year_avg": "234500.0",
    "skills": "redshift"
  },
  {
    "job_id": 14251,
    "company_name": "Hinge",
    "job_title": "Staff Data Engineer",
    "salary_year_avg": "234500.0",
    "skills": "gcp"
  },
  {
    "job_id": 14251,
    "company_name": "Hinge",
    "job_title": "Staff Data Engineer",
    "salary_year_avg": "234500.0",
    "skills": "airflow"
  },
  {
    "job_id": 14251,
    "company_name": "Hinge",
    "job_title": "Staff Data Engineer",
    "salary_year_avg": "234500.0",
    "skills": "kafka"
  },
  {
    "job_id": 14251,
    "company_name": "Hinge",
    "job_title": "Staff Data Engineer",
    "salary_year_avg": "234500.0",
    "skills": "looker"
  },
  {
    "job_id": 14251,
    "company_name": "Hinge",
    "job_title": "Staff Data Engineer",
    "salary_year_avg": "234500.0",
    "skills": "terraform"
  },
  {
    "job_id": 14251,
    "company_name": "Hinge",
    "job_title": "Staff Data Engineer",
    "salary_year_avg": "234500.0",
    "skills": "kubernetes"
  },
  {
    "job_id": 14251,
    "company_name": "Hinge",
    "job_title": "Staff Data Engineer",
    "salary_year_avg": "234500.0",
    "skills": "docker"
  },
  {
    "job_id": 11602,
    "company_name": "Meta",
    "job_title": "Data Engineer, Analytics (Generalist)",
    "salary_year_avg": "233000.0",
    "skills": "sql"
  },
  {
    "job_id": 11602,
    "company_name": "Meta",
    "job_title": "Data Engineer, Analytics (Generalist)",
    "salary_year_avg": "233000.0",
    "skills": "python"
  },
  {
    "job_id": 173752,
    "company_name": "Henry Schein One",
    "job_title": "Data Engineering Leader",
    "salary_year_avg": "227630.0",
    "skills": "sql"
  },
  {
    "job_id": 173752,
    "company_name": "Henry Schein One",
    "job_title": "Data Engineering Leader",
    "salary_year_avg": "227630.0",
    "skills": "python"
  },
  {
    "job_id": 173752,
    "company_name": "Henry Schein One",
    "job_title": "Data Engineering Leader",
    "salary_year_avg": "227630.0",
    "skills": "nosql"
  },
  {
    "job_id": 173752,
    "company_name": "Henry Schein One",
    "job_title": "Data Engineering Leader",
    "salary_year_avg": "227630.0",
    "skills": "java"
  },
  {
    "job_id": 173752,
    "company_name": "Henry Schein One",
    "job_title": "Data Engineering Leader",
    "salary_year_avg": "227630.0",
    "skills": "go"
  },
  {
    "job_id": 173752,
    "company_name": "Henry Schein One",
    "job_title": "Data Engineering Leader",
    "salary_year_avg": "227630.0",
    "skills": "cassandra"
  },
  {
    "job_id": 173752,
    "company_name": "Henry Schein One",
    "job_title": "Data Engineering Leader",
    "salary_year_avg": "227630.0",
    "skills": "azure"
  },
  {
    "job_id": 173752,
    "company_name": "Henry Schein One",
    "job_title": "Data Engineering Leader",
    "salary_year_avg": "227630.0",
    "skills": "aws"
  },
  {
    "job_id": 173752,
    "company_name": "Henry Schein One",
    "job_title": "Data Engineering Leader",
    "salary_year_avg": "227630.0",
    "skills": "snowflake"
  },
  {
    "job_id": 173752,
    "company_name": "Henry Schein One",
    "job_title": "Data Engineering Leader",
    "salary_year_avg": "227630.0",
    "skills": "spark"
  },
  {
    "job_id": 173752,
    "company_name": "Henry Schein One",
    "job_title": "Data Engineering Leader",
    "salary_year_avg": "227630.0",
    "skills": "kafka"
  },
  {
    "job_id": 173752,
    "company_name": "Henry Schein One",
    "job_title": "Data Engineering Leader",
    "salary_year_avg": "227630.0",
    "skills": "gdpr"
  },
  {
    "job_id": 173752,
    "company_name": "Henry Schein One",
    "job_title": "Data Engineering Leader",
    "salary_year_avg": "227630.0",
    "skills": "splunk"
  },
  {
    "job_id": 173752,
    "company_name": "Henry Schein One",
    "job_title": "Data Engineering Leader",
    "salary_year_avg": "227630.0",
    "skills": "terraform"
  },
  {
    "job_id": 173752,
    "company_name": "Henry Schein One",
    "job_title": "Data Engineering Leader",
    "salary_year_avg": "227630.0",
    "skills": "kubernetes"
  },
  {
    "job_id": 173752,
    "company_name": "Henry Schein One",
    "job_title": "Data Engineering Leader",
    "salary_year_avg": "227630.0",
    "skills": "docker"
  },
  {
    "job_id": 202624,
    "company_name": "Understanding Recruitment",
    "job_title": "Rust Data Engineer",
    "salary_year_avg": "225000.0",
    "skills": "rust"
  },
  {
    "job_id": 1375618,
    "company_name": "Brightcove",
    "job_title": "Director, Data Engineering (Remote)",
    "salary_year_avg": "221500.0",
    "skills": "python"
  },
  {
    "job_id": 1375618,
    "company_name": "Brightcove",
    "job_title": "Director, Data Engineering (Remote)",
    "salary_year_avg": "221500.0",
    "skills": "nosql"
  },
  {
    "job_id": 1375618,
    "company_name": "Brightcove",
    "job_title": "Director, Data Engineering (Remote)",
    "salary_year_avg": "221500.0",
    "skills": "scala"
  },
  {
    "job_id": 1375618,
    "company_name": "Brightcove",
    "job_title": "Director, Data Engineering (Remote)",
    "salary_year_avg": "221500.0",
    "skills": "java"
  },
  {
    "job_id": 1375618,
    "company_name": "Brightcove",
    "job_title": "Director, Data Engineering (Remote)",
    "salary_year_avg": "221500.0",
    "skills": "snowflake"
  },
  {
    "job_id": 1375618,
    "company_name": "Brightcove",
    "job_title": "Director, Data Engineering (Remote)",
    "salary_year_avg": "221500.0",
    "skills": "spark"
  },
  {
    "job_id": 1375618,
    "company_name": "Brightcove",
    "job_title": "Director, Data Engineering (Remote)",
    "salary_year_avg": "221500.0",
    "skills": "kafka"
  },
  {
    "job_id": 1375618,
    "company_name": "Brightcove",
    "job_title": "Director, Data Engineering (Remote)",
    "salary_year_avg": "221500.0",
    "skills": "kubernetes"
  },
  {
    "job_id": 503833,
    "company_name": "Grindr",
    "job_title": "Principal AI Data Engineer (Remote)",
    "salary_year_avg": "220000.0",
    "skills": "sql"
  },
  {
    "job_id": 503833,
    "company_name": "Grindr",
    "job_title": "Principal AI Data Engineer (Remote)",
    "salary_year_avg": "220000.0",
    "skills": "python"
  },
  {
    "job_id": 503833,
    "company_name": "Grindr",
    "job_title": "Principal AI Data Engineer (Remote)",
    "salary_year_avg": "220000.0",
    "skills": "nosql"
  },
  {
    "job_id": 503833,
    "company_name": "Grindr",
    "job_title": "Principal AI Data Engineer (Remote)",
    "salary_year_avg": "220000.0",
    "skills": "java"
  },
  {
    "job_id": 503833,
    "company_name": "Grindr",
    "job_title": "Principal AI Data Engineer (Remote)",
    "salary_year_avg": "220000.0",
    "skills": "r"
  },
  {
    "job_id": 503833,
    "company_name": "Grindr",
    "job_title": "Principal AI Data Engineer (Remote)",
    "salary_year_avg": "220000.0",
    "skills": "bash"
  },
  {
    "job_id": 503833,
    "company_name": "Grindr",
    "job_title": "Principal AI Data Engineer (Remote)",
    "salary_year_avg": "220000.0",
    "skills": "dynamodb"
  },
  {
    "job_id": 503833,
    "company_name": "Grindr",
    "job_title": "Principal AI Data Engineer (Remote)",
    "salary_year_avg": "220000.0",
    "skills": "azure"
  },
  {
    "job_id": 503833,
    "company_name": "Grindr",
    "job_title": "Principal AI Data Engineer (Remote)",
    "salary_year_avg": "220000.0",
    "skills": "aws"
  },
  {
    "job_id": 503833,
    "company_name": "Grindr",
    "job_title": "Principal AI Data Engineer (Remote)",
    "salary_year_avg": "220000.0",
    "skills": "snowflake"
  },
  {
    "job_id": 503833,
    "company_name": "Grindr",
    "job_title": "Principal AI Data Engineer (Remote)",
    "salary_year_avg": "220000.0",
    "skills": "gcp"
  },
  {
    "job_id": 503833,
    "company_name": "Grindr",
    "job_title": "Principal AI Data Engineer (Remote)",
    "salary_year_avg": "220000.0",
    "skills": "spark"
  },
  {
    "job_id": 503833,
    "company_name": "Grindr",
    "job_title": "Principal AI Data Engineer (Remote)",
    "salary_year_avg": "220000.0",
    "skills": "pandas"
  },
  {
    "job_id": 503833,
    "company_name": "Grindr",
    "job_title": "Principal AI Data Engineer (Remote)",
    "salary_year_avg": "220000.0",
    "skills": "pyspark"
  },
  {
    "job_id": 503833,
    "company_name": "Grindr",
    "job_title": "Principal AI Data Engineer (Remote)",
    "salary_year_avg": "220000.0",
    "skills": "airflow"
  },
  {
    "job_id": 503833,
    "company_name": "Grindr",
    "job_title": "Principal AI Data Engineer (Remote)",
    "salary_year_avg": "220000.0",
    "skills": "kafka"
  },
  {
    "job_id": 503833,
    "company_name": "Grindr",
    "job_title": "Principal AI Data Engineer (Remote)",
    "salary_year_avg": "220000.0",
    "skills": "express"
  },
  {
    "job_id": 503833,
    "company_name": "Grindr",
    "job_title": "Principal AI Data Engineer (Remote)",
    "salary_year_avg": "220000.0",
    "skills": "git"
  },
  {
    "job_id": 503833,
    "company_name": "Grindr",
    "job_title": "Principal AI Data Engineer (Remote)",
    "salary_year_avg": "220000.0",
    "skills": "kubernetes"
  },
  {
    "job_id": 503833,
    "company_name": "Grindr",
    "job_title": "Principal AI Data Engineer (Remote)",
    "salary_year_avg": "220000.0",
    "skills": "docker"
  },
  {
    "job_id": 67320,
    "company_name": "Harnham",
    "job_title": "Staff Data Engineer",
    "salary_year_avg": "220000.0",
    "skills": "sql"
  },
  {
    "job_id": 67320,
    "company_name": "Harnham",
    "job_title": "Staff Data Engineer",
    "salary_year_avg": "220000.0",
    "skills": "python"
  },
  {
    "job_id": 67320,
    "company_name": "Harnham",
    "job_title": "Staff Data Engineer",
    "salary_year_avg": "220000.0",
    "skills": "snowflake"
  },
  {
    "job_id": 67320,
    "company_name": "Harnham",
    "job_title": "Staff Data Engineer",
    "salary_year_avg": "220000.0",
    "skills": "kafka"
  },
  {
    "job_id": 67320,
    "company_name": "Harnham",
    "job_title": "Staff Data Engineer",
    "salary_year_avg": "220000.0",
    "skills": "kubernetes"
  },
  {
    "job_id": 536902,
    "company_name": "Shiftsmart",
    "job_title": "Senior / Staff, Data Engineer",
    "salary_year_avg": "215000.0",
    "skills": "sql"
  },
  {
    "job_id": 536902,
    "company_name": "Shiftsmart",
    "job_title": "Senior / Staff, Data Engineer",
    "salary_year_avg": "215000.0",
    "skills": "python"
  },
  {
    "job_id": 536902,
    "company_name": "Shiftsmart",
    "job_title": "Senior / Staff, Data Engineer",
    "salary_year_avg": "215000.0",
    "skills": "nosql"
  },
  {
    "job_id": 536902,
    "company_name": "Shiftsmart",
    "job_title": "Senior / Staff, Data Engineer",
    "salary_year_avg": "215000.0",
    "skills": "mongodb"
  },
  {
    "job_id": 536902,
    "company_name": "Shiftsmart",
    "job_title": "Senior / Staff, Data Engineer",
    "salary_year_avg": "215000.0",
    "skills": "mongodb"
  },
  {
    "job_id": 536902,
    "company_name": "Shiftsmart",
    "job_title": "Senior / Staff, Data Engineer",
    "salary_year_avg": "215000.0",
    "skills": "spark"
  },
  {
    "job_id": 536902,
    "company_name": "Shiftsmart",
    "job_title": "Senior / Staff, Data Engineer",
    "salary_year_avg": "215000.0",
    "skills": "airflow"
  },
  {
    "job_id": 536902,
    "company_name": "Shiftsmart",
    "job_title": "Senior / Staff, Data Engineer",
    "salary_year_avg": "215000.0",
    "skills": "kafka"
  }
]
*/