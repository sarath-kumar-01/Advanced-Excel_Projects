CREATE DATABASE `milestone_1`;
USE `milestone_1`;
DESC data;
SELECT * FROM data;






# 1.Average Salary by Industry and Gender:
SELECT industry, gender, ROUND(AVG(annual_salary),2) AS Avg_Salary
FROM data
GROUP BY industry, gender
ORDER BY AVG(annual_salary) DESC;


# 2.Total Salary Compensation by Job Title:
SELECT job_title, SUM(total_salary) AS total_compensation
FROM data
GROUP By job_title
ORDER BY SUM(total_salary) DESC;


# 3.Salary Distribution by Education Level:
SELECT education,
				ROUND(AVG(annual_salary),2) AS Avg_Salary,
                MIN(annual_salary) AS Min_Salary,
                MAX(annual_salary) AS Max_Salary
FROM data
GROUP BY education
ORDER BY education ASC;

# 4.Number of Employees by Industry and Years of Experience:
SELECT industry,
       experience_overall,
       COUNT(row_id) AS no_of_emp
FROM data
GROUP BY industry, experience_overall
ORDER BY COUNT(row_id) DESC;
 
 
 
# 5.Median Salary by Age Range and Gender:
SELECT age_range, gender, ROUND(AVG(annual_salary),2) AS Avg_Salary
FROM data
GROUP BY age_range, gender
ORDER BY AVG(annual_salary) DESC;

# or

WITH rs AS (
SELECT age_range, gender, annual_salary,
ROW_NUMBER() OVER(PARTITION BY age_range, gender ORDER BY annual_salary ASC) AS row_num,
COUNT(row_id) OVER(PARTITION BY age_range,gender) AS total_count
FROM data
)
SELECT age_range, gender, annual_salary AS median_salary
FROM rs
WHERE row_num IN (CEIL(total_count / 2.0));
 
 
 
# 6.Job Titles with the Highest Salary in Each Country:
SELECT DISTINCT(country) , job_title, MAX(annual_salary) AS Avg_Salary
FROM data
GROUP BY country, job_title
ORDER BY MAX(annual_salary) DESC;

# or

 SELECT e.country, e.job_title, e.annual_salary
 FROM data AS e
 JOIN (SELECT country, MAX(annual_salary) AS max_sal
	   FROM data
       GROUP BY country) AS m
 ON e.country = m.country AND e.annual_salary = m.max_sal
 ORDER BY e.annual_salary DESC;
 
 
# 7.Average Salary by City and Industry:
SELECT city, industry, ROUND(AVG(annual_salary)) as Avg_Salary
FROM data
GROUP BY industry, city
ORDER BY AVG(annual_salary) DESC;
 
 
 # 8.Percentage of Employees with Additional Monetary Compensation by Gender:
 SELECT gender,
 ROUND((SUM(CASE WHEN bonus > 0 THEN 1 ELSE 0 END) * 100.00 / COUNT(row_id)),2) AS bonus_percent
 FROM data
 GROUP BY gender
 ORDER BY ROUND((SUM(CASE WHEN bonus > 0 THEN 1 ELSE 0 END) * 100.00 / COUNT(row_id)),2) DESC;
 
 # 9.Total Compensation by Job Title and Years of Experience:
 SELECT job_title, experience_overall, SUM(total_salary) AS total_compensation
 FROM data
 GROUP BY job_title, experience_overall
 ORDER BY SUM(total_salary) DESC;
 
  # 10.Average Salary by Industry, Gender, and Education Level:
 SELECT gender, education, industry, ROUND(AVG(annual_salary),2) AS Avg_Salary
 FROM data
 GROUP BY industry, gender, education
 ORDER BY AVG(annual_salary) DESC;
 
 
 # -- END -- #
 
 
 
 
 
 
 
 
 
 
 
 