-- Query to get all sales data matching the original CSV sales view
SELECT * from sales;

-- Query to get sales data from all countries 
SELECT * from sales_by_country;

-- Query to get sales data from countries with total revenue smaller than a specific amount in ascending order
SELECT * from sales_by_country WHERE total_revenue < 300000000 ORDER BY total_revenue ASC;

-- Query to get sales data on every unit basis
SELECT * from sales_by_unit;

-- Query to get sales data on a per unit basis in descending order of total revenue
SELECT * from sales_by_unit ORDER BY total_revenue DESC;

-- Query to get sales data from last month
SELECT * from sales_last_month;

-- Query to get yearly sales data 
SELECT * from sales_by_year;

-- Query to get sales data since a specific year
SELECT * from sales_by_year WHERE sales_year > 2012;
