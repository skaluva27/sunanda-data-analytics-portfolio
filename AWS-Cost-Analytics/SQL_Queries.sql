-- SQL QUERIES FOR AWS COST ANALYTICS PROJECT

---------------------------------------------------------
-- 1. Total Monthly AWS Cost
---------------------------------------------------------
SELECT 
    InvoiceMonth,
    SUM(Cost) AS TotalMonthlyCost
FROM aws_cost_data
GROUP BY InvoiceMonth
ORDER BY InvoiceMonth;


---------------------------------------------------------
-- 2. Cost by AWS Service
---------------------------------------------------------
SELECT 
    ServiceName,
    SUM(Cost) AS TotalServiceCost
FROM aws_cost_data
GROUP BY ServiceName
ORDER BY TotalServiceCost DESC;


---------------------------------------------------------
-- 3. Cost by Region
---------------------------------------------------------
SELECT 
    Region,
    SUM(Cost) AS TotalRegionCost
FROM aws_cost_data
GROUP BY Region
ORDER BY TotalRegionCost DESC;


---------------------------------------------------------
-- 4. Monthly Cost Trend for EC2
---------------------------------------------------------
SELECT 
    InvoiceMonth,
    SUM(Cost) AS EC2MonthlyCost
FROM aws_cost_data
WHERE ServiceName = 'Amazon EC2'
GROUP BY InvoiceMonth
ORDER BY InvoiceMonth;


---------------------------------------------------------
-- 5. Top 10 Highest Cost Items
---------------------------------------------------------
SELECT 
    InvoiceMonth,
    ServiceName,
    UsageType,
    Cost
FROM aws_cost_data
ORDER BY Cost DESC
LIMIT 10;


---------------------------------------------------------
-- 6. Detect Cost Spikes (Month-over-Month Increase > 10%)
---------------------------------------------------------
WITH MonthlyCost AS (
    SELECT 
        InvoiceMonth,
        SUM(Cost) AS TotalCost
    FROM aws_cost_data
    GROUP BY InvoiceMonth
)
SELECT 
    curr.InvoiceMonth,
    curr.TotalCost AS CurrentMonthCost,
    prev.TotalCost AS PreviousMonthCost,
    ROUND(((curr.TotalCost - prev.TotalCost) / prev.TotalCost) * 100, 2) AS PercentIncrease
FROM MonthlyCost curr
JOIN MonthlyCost prev
    ON DATE(curr.InvoiceMonth || '-01') = DATE(prev.InvoiceMonth || '-01', '+1 month')
WHERE ((curr.TotalCost - prev.TotalCost) / prev.TotalCost) * 100 > 10
ORDER BY curr.InvoiceMonth;
