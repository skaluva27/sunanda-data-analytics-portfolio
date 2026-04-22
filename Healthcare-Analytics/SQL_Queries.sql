-- SQL QUERIES FOR HEALTHCARE ANALYTICS PROJECT

---------------------------------------------------------
-- 1. Total Patients
---------------------------------------------------------
SELECT 
    COUNT(*) AS TotalPatients
FROM healthcare_data;


---------------------------------------------------------
-- 2. No-Show Count and No-Show Rate
---------------------------------------------------------
SELECT
    SUM(CASE WHEN NoShow = 'Yes' THEN 1 ELSE 0 END) AS NoShowCount,
    ROUND(
        (SUM(CASE WHEN NoShow = 'Yes' THEN 1 ELSE 0 END) * 100.0) / COUNT(*),
        2
    ) AS NoShowRate
FROM healthcare_data;


---------------------------------------------------------
-- 3. Average Wait Time
---------------------------------------------------------
SELECT
    ROUND(AVG(WaitTimeMinutes), 2) AS AvgWaitTime
FROM healthcare_data
WHERE WaitTimeMinutes > 0;


---------------------------------------------------------
-- 4. Wait Time by Department
---------------------------------------------------------
SELECT
    Department,
    ROUND(AVG(WaitTimeMinutes), 2) AS AvgWaitTime,
    COUNT(*) AS TotalAppointments
FROM healthcare_data
WHERE WaitTimeMinutes > 0
GROUP BY Department
ORDER BY AvgWaitTime DESC;


---------------------------------------------------------
-- 5. No-Show Rate by Department
---------------------------------------------------------
SELECT
    Department,
    COUNT(*) AS TotalAppointments,
    SUM(CASE WHEN NoShow = 'Yes' THEN 1 ELSE 0 END) AS NoShowCount,
    ROUND(
        (SUM(CASE WHEN NoShow = 'Yes' THEN 1 ELSE 0 END) * 100.0) / COUNT(*),
        2
    ) AS NoShowRate
FROM healthcare_data
GROUP BY Department
ORDER BY NoShowRate DESC;


---------------------------------------------------------
-- 6. Satisfaction Score Summary
---------------------------------------------------------
SELECT
    Department,
    ROUND(AVG(SatisfactionScore), 2) AS AvgSatisfaction
FROM healthcare_data
WHERE SatisfactionScore IS NOT NULL
GROUP BY Department
ORDER BY AvgSatisfaction DESC;


---------------------------------------------------------
-- 7. Appointment Type Analysis
---------------------------------------------------------
SELECT
    AppointmentType,
    COUNT(*) AS TotalAppointments,
    ROUND(AVG(WaitTimeMinutes), 2) AS AvgWaitTime,
    SUM(CASE WHEN NoShow = 'Yes' THEN 1 ELSE 0 END) AS NoShowCount
FROM healthcare_data
GROUP BY AppointmentType
ORDER BY TotalAppointments DESC;


---------------------------------------------------------
-- 8. Time-of-Day Patient Load
---------------------------------------------------------
SELECT
    SUBSTR(ScheduledTime, 1, 2) AS HourOfDay,
    COUNT(*) AS AppointmentCount
FROM healthcare_data
GROUP BY HourOfDay
ORDER BY HourOfDay;


---------------------------------------------------------
-- 9. High-Level Operational Summary
---------------------------------------------------------
SELECT
    COUNT(*) AS TotalPatients,
    ROUND(AVG(Age), 1) AS AvgAge,
    ROUND(AVG(WaitTimeMinutes), 2) AS AvgWaitTime,
    ROUND(AVG(SatisfactionScore), 2) AS AvgSatisfaction
FROM healthcare_data
WHERE SatisfactionScore IS NOT NULL;
