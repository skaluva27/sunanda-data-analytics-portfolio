-- Cleaning raw retail sales data

SELECT
    CAST(OrderID AS INT) AS OrderID,
    OrderDate,
    CustomerID,
    Product,
    Category,
    Region,
    CAST(Quantity AS INT) AS Quantity,
    CAST(UnitPrice AS DECIMAL(10,2)) AS UnitPrice,
    CAST(Cost AS DECIMAL(10,2)) AS Cost,
    (Quantity * UnitPrice) AS Sales,
    (Quantity * UnitPrice) - (Quantity * Cost) AS Profit
FROM RawSalesData
WHERE OrderID IS NOT NULL
  AND Quantity > 0
  AND UnitPrice > 0;
