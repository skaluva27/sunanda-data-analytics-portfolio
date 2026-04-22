-- SQL QUERIES FOR HR ANALYTICS PROJECT

---------------------------------------------------------
-- 1. Total Employees
---------------------------------------------------------
SELECT 
    COUNT(*) AS TotalEmployees
FROM hr_data;


---------------------------------------------------------
-- 2. Total Attrition Count and Attrition Rate
---------------------------------------------------------
SELECT
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS AttritionCount,
    ROUND(
        (SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0) / COUNT(*),
        2
    ) AS AttritionRate
FROM hr_data;


---------------------------------------------------------
-- 3. Attrition by Department
---------------------------------------------------------
SELECT
    Department,
    COUNT(*) AS TotalEmployees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS AttritionCount,
    ROUND(
        (SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0) / COUNT(*),
        2
    ) AS AttritionRate
FROM hr_data
GROUP BY Department
ORDER BY AttritionRate DESC;


---------------------------------------------------------
-- 4. Salary Distribution by Department
---------------------------------------------------------
SELECT
    Department,
    ROUND(AVG(MonthlyIncome), 2) AS AvgSalary,
    MIN(MonthlyIncome) AS MinSalary,
    MAX(MonthlyIncome) AS MaxSalary
FROM hr_data
GROUP BY Department
ORDER BY AvgSalary DESC;


---------------------------------------------------------
-- 5. Job Satisfaction Summary
---------------------------------------------------------
SELECT
    JobRole,
    ROUND(AVG(JobSatisfaction), 2) AS AvgJobSatisfaction
FROM hr_data
GROUP BY JobRole
ORDER BY AvgJobSatisfaction DESC;


---------------------------------------------------------
-- 6. Performance Rating Distribution
---------------------------------------------------------
SELECT
    PerformanceRating,
    COUNT(*) AS EmployeeCount
FROM hr_data
GROUP BY PerformanceRating
ORDER BY PerformanceRating;


---------------------------------------------------------
-- 7. Attrition by Age Group
---------------------------------------------------------
SELECT
    CASE
        WHEN Age < 30 THEN 'Under 30'
        WHEN Age BETWEEN 30 AND 39 THEN '30-39'
        WHEN Age BETWEEN 40 AND 49 THEN '40-49'
        ELSE '50+'
    END AS AgeGroup,
    COUNT(*) AS TotalEmployees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS AttritionCount,
    ROUND(
        (SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0) / COUNT(*),
        2
    ) AS AttritionRate
FROM hr_data
GROUP BY AgeGroup
ORDER BY AttritionRate DESC;


---------------------------------------------------------
-- 8. Years at Company vs Attrition
---------------------------------------------------------
SELECT
    YearsAtCompany,
    COUNT(*) AS TotalEmployees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS AttritionCount
FROM hr_data
GROUP BY YearsAtCompany
ORDER BY YearsAtCompany;


---------------------------------------------------------
-- 9. High-Level Workforce Summary
---------------------------------------------------------
SELECT
    COUNT(*) AS TotalEmployees,
    ROUND(AVG(Age), 1) AS AvgAge,
    ROUND(AVG(MonthlyIncome), 2) AS AvgIncome,
    ROUND(AVG(YearsAtCompany), 1) AS AvgTenure
FROM hr_data;
