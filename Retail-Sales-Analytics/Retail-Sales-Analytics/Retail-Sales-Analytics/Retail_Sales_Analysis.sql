-- Monthly Sales Summary
SELECT
    FORMAT(OrderDate, 'yyyy-MM') AS Month,
    SUM(Sales) AS TotalSales,
    SUM(Profit) AS TotalProfit,
    SUM(Quantity) AS UnitsSold
FROM CleanedSalesData
GROUP BY FORMAT(OrderDate, 'yyyy-MM')
ORDER BY Month;

-- Top 10 Products
SELECT TOP 10
    Product,
    SUM(Sales) AS TotalSales,
    SUM(Profit) AS TotalProfit
FROM CleanedSalesData
GROUP BY Product
ORDER BY TotalSales DESC;

-- Regional Performance
SELECT
    Region,
    SUM(Sales) AS TotalSales,
    SUM(Profit) AS TotalProfit
FROM CleanedSalesData
GROUP BY Region
ORDER BY TotalSales DESC;
