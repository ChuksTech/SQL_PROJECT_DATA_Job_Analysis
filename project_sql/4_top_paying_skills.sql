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
Answer: What are the top skills based on salary?
-Look at the average salary associated with each skill for Data Engineer positions.
-Focuses on roles with specified salaries, regardless of location
-Why? It reveals how different skills impact salary levels for Data Engineers and 
    helps identify the most financially rewarding skills to acquire or improve.
-Use Matplotlib to visualize the data. Code are in the comments below.
*/

SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Engineer' 
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 30

/*
Here are some quick insights into the top-paying skills for data engineers:  

### **1. High-Paying Niche Skills**  
- **Assembly ($192,500)** is the highest-paying skill, which is surprising for a data engineering role.
 It suggests specialized, low-level programming knowledge is highly valuable in certain industries.  
- **MongoDB ($182,223)** and **Neo4j ($166,559)** indicate that NoSQL databases are in high demand.  

### **2. Emerging Technologies Pay Well**  
- **Rust ($172,819)** and **Clojure ($170,867)** are functional and systems programming languages
 gaining popularity for performance and reliability.  
- **Solidity ($166,250)** shows strong demand for blockchain and smart contract expertise.  

### **3. Data Science & AI Skills Are Lucrative**  
- **Julia ($160,500)**, **TensorFlow ($148,100)**, and **Keras ($148,698)** highlight the importance of machine learning 
and AI in data engineering.  
- **FastAPI ($157,500)** and **MXNet ($157,500)** suggest that frameworks for building high-performance APIs and 
deep learning models are in demand.  

### **4. DevOps & Cloud Are Essential**  
- **Kubernetes ($158,190)**, **Terraform ($146,057)**, and **VMware ($150,000)** show that infrastructure-as-code and 
cloud technologies are crucial for high-paying roles.  

### **5. Surprising Tools in the List**  
- **Zoom ($159,000)** and **Trello ($155,000)**—their presence might indicate specialized roles in collaboration tooling
 or integrations.  
- **Bitbucket ($160,333)**—suggests expertise in CI/CD pipelines is valuable.  

JSON

[
  {
    "skills": "assembly",
    "avg_salary": "192500"
  },
  {
    "skills": "mongo",
    "avg_salary": "182223"
  },
  {
    "skills": "ggplot2",
    "avg_salary": "176250"
  },
  {
    "skills": "rust",
    "avg_salary": "172819"
  },
  {
    "skills": "clojure",
    "avg_salary": "170867"
  },
  {
    "skills": "perl",
    "avg_salary": "169000"
  },
  {
    "skills": "neo4j",
    "avg_salary": "166559"
  },
  {
    "skills": "solidity",
    "avg_salary": "166250"
  },
  {
    "skills": "graphql",
    "avg_salary": "162547"
  },
  {
    "skills": "julia",
    "avg_salary": "160500"
  },
  {
    "skills": "splunk",
    "avg_salary": "160397"
  },
  {
    "skills": "bitbucket",
    "avg_salary": "160333"
  },
  {
    "skills": "zoom",
    "avg_salary": "159000"
  },
  {
    "skills": "kubernetes",
    "avg_salary": "158190"
  },
  {
    "skills": "numpy",
    "avg_salary": "157592"
  },
  {
    "skills": "fastapi",
    "avg_salary": "157500"
  },
  {
    "skills": "mxnet",
    "avg_salary": "157500"
  },
  {
    "skills": "redis",
    "avg_salary": "157000"
  },
  {
    "skills": "trello",
    "avg_salary": "155000"
  },
  {
    "skills": "jquery",
    "avg_salary": "151667"
  },
  {
    "skills": "express",
    "avg_salary": "151636"
  },
  {
    "skills": "cassandra",
    "avg_salary": "151282"
  },
  {
    "skills": "unify",
    "avg_salary": "151000"
  },
  {
    "skills": "kafka",
    "avg_salary": "150549"
  },
  {
    "skills": "vmware",
    "avg_salary": "150000"
  },
  {
    "skills": "keras",
    "avg_salary": "148698"
  },
  {
    "skills": "tensorflow",
    "avg_salary": "148100"
  },
  {
    "skills": "golang",
    "avg_salary": "147818"
  },
  {
    "skills": "angular",
    "avg_salary": "147021"
  },
  {
    "skills": "terraform",
    "avg_salary": "146057"
  }
]
*/

/*
Matplotlib codes for the data above.

import matplotlib.pyplot as plt
import pandas as pd

# Define the data
top_paying_skills = [
    {"skills": "assembly", "avg_salary": 192500},
    {"skills": "mongo", "avg_salary": 182223},
    {"skills": "ggplot2", "avg_salary": 176250},
    {"skills": "rust", "avg_salary": 172819},
    {"skills": "clojure", "avg_salary": 170867},
    {"skills": "perl", "avg_salary": 169000},
    {"skills": "neo4j", "avg_salary": 166559},
    {"skills": "solidity", "avg_salary": 166250},
    {"skills": "graphql", "avg_salary": 162547},
    {"skills": "julia", "avg_salary": 160500},
    {"skills": "splunk", "avg_salary": 160397},
    {"skills": "bitbucket", "avg_salary": 160333},
    {"skills": "zoom", "avg_salary": 159000},
    {"skills": "kubernetes", "avg_salary": 158190},
    {"skills": "numpy", "avg_salary": 157592},
    {"skills": "fastapi", "avg_salary": 157500},
    {"skills": "mxnet", "avg_salary": 157500},
    {"skills": "redis", "avg_salary": 157000},
    {"skills": "trello", "avg_salary": 155000},
    {"skills": "jquery", "avg_salary": 151667},
    {"skills": "express", "avg_salary": 151636},
    {"skills": "cassandra", "avg_salary": 151282},
    {"skills": "unify", "avg_salary": 151000},
    {"skills": "kafka", "avg_salary": 150549},
    {"skills": "vmware", "avg_salary": 150000},
    {"skills": "keras", "avg_salary": 148698},
    {"skills": "tensorflow", "avg_salary": 148100},
    {"skills": "golang", "avg_salary": 147818},
    {"skills": "angular", "avg_salary": 147021},
    {"skills": "terraform", "avg_salary": 146057},
]

# Convert to DataFrame
df = pd.DataFrame(top_paying_skills)

# Sort data by salary
df = df.sort_values(by="avg_salary", ascending=True)

# Create the bar chart
plt.figure(figsize=(12, 8))
plt.barh(df["skills"], df["avg_salary"], color="lightcoral", edgecolor="black")

# Customize the plot
plt.title("Top Paying Skills for Data Engineers (2023)", fontsize=14)
plt.xlabel("Average Salary ($)", fontsize=12)
plt.ylabel("Skills", fontsize=12)
plt.grid(axis="x", linestyle="--", alpha=0.7)

# Show the plot
plt.show()

How to install instructions.
1. Install matplotlib and pandas if you haven't already:
    Python code:
        pip install matplotlib pandas

2. Copy and paste the code into a Python script or Jupyter Notebook.

3. Run the script, and it will generate a horizontal bar chart showing the top-paying skills.


*/