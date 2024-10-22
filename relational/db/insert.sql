CREATE TABLE staging (
    region_name VARCHAR(255),
    country_name VARCHAR(255),
    item_type VARCHAR(255),
    sales_channel_name VARCHAR(255),
    order_priority_name VARCHAR(255),
    order_date DATE,
    order_id INT,
    ship_date DATE,
    units_sold INT,
    unit_price DECIMAL(10,2),
    unit_cost DECIMAL(10,2),
    total_revenue DECIMAL(10,2),
    total_cost DECIMAL(10,2),
    total_profit DECIMAL(10,2)
)
-- ABSOLUTE PATH: 
COPY staging FROM 'C:\WGU\D597\Task 1\Scenario 2\Sales_Records.csv'
DELIMITER ','
CSV HEADER;



DROP TABLE IF EXISTS staging;