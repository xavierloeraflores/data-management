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
);

-- ABSOLUTE PATH: 
COPY staging FROM 'C:\WGU\D597\Task 1\Scenario 2\Sales_Records.csv'
DELIMITER ','
CSV HEADER;

INSERT INTO sales_channels (sales_channel_name)
SELECT DISTINCT  sales_channel_name
FROM staging
ON CONFLICT (sales_channel_name) DO NOTHING;

INSERT INTO order_priorities (order_priority_name)
SELECT DISTINCT  order_priority_name
FROM staging
ON CONFLICT (order_priority_name) DO NOTHING;

INSERT INTO regions (region_name)
SELECT DISTINCT  region_name
FROM staging
ON CONFLICT (region_name) DO NOTHING;

INSERT INTO countries (country_name, region_id)
SELECT DISTINCT  country_name, regions.region_id
FROM staging
JOIN regions ON staging.region_name = regions.region_name;

INSERT INTO units (item_type, unit_price, unit_cost)
SELECT DISTINCT  item_type, unit_price, unit_cost
FROM staging
ON CONFLICT (item_type) DO NOTHING;

INSERT INTO orders (order_date, ship_date, units_sold, country_id, unit_id, sales_channel_id, order_priority_id)
SELECT DISTINCT  order_date, ship_date, units_sold, countries.country_id, units.unit_id, sales_channels.sales_channel_id, order_priorities.order_priority_id
FROM staging
JOIN countries ON staging.country_name = countries.country_name
JOIN units ON staging.item_type = units.item_type
JOIN sales_channels ON staging.sales_channel_name = sales_channels.sales_channel_name
JOIN order_priorities ON staging.order_priority_name = order_priorities.order_priority_name;
