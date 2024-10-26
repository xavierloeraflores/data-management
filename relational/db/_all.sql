
CREATE TABLE  regions (
    region_id SERIAL PRIMARY KEY,
    region_name VARCHAR(255) UNIQUE
);


CREATE TABLE countries (
    country_id SERIAL PRIMARY KEY,
    country_name VARCHAR(255) UNIQUE,
    region_id INT,
    FOREIGN KEY (region_id) REFERENCES regions(region_id)
);


CREATE TABLE units (
    unit_id SERIAL PRIMARY KEY,
    item_type VARCHAR(255) UNIQUE,
    unit_price DECIMAL(10,2),
    unit_cost DECIMAL(10,2)
);



CREATE TABLE sales_channels (
    sales_channel_id SERIAL PRIMARY KEY,
    sales_channel_name VARCHAR(255) UNIQUE
);



CREATE TABLE order_priorities (
    order_priority_id SERIAL PRIMARY KEY,
    order_priority_name VARCHAR(255) UNIQUE
);


CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    order_date DATE,
    ship_date DATE,
    units_sold INT,
    country_id INT,
    unit_id INT,
    sales_channel_id INT,
    order_priority_id INT,
    FOREIGN KEY (country_id) REFERENCES countries(country_id),
    FOREIGN KEY (unit_id) REFERENCES units(unit_id),
    FOREIGN KEY (sales_channel_id) REFERENCES sales_channels(sales_channel_id),
    FOREIGN KEY (order_priority_id) REFERENCES order_priorities(order_priority_id)
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

-- VIEWS FOR SALES ANALYSIS
CREATE VIEW sales AS
SELECT
    regions.region_name,
    countries.country_name,
    units.item_type,
    units.unit_price,
    units.unit_cost,
    sales_channels.sales_channel_name,
    order_priorities.order_priority_name,
    orders.order_date,
    orders.order_id,
    orders.ship_date,
    orders.units_sold,
    orders.units_sold * units.unit_price AS total_revenue,
    orders.units_sold * units.unit_cost AS total_cost,
    orders.units_sold * units.unit_price - orders.units_sold * units.unit_cost AS total_profit
FROM regions
JOIN countries ON regions.region_id = countries.region_id
JOIN orders ON countries.country_id = orders.country_id
JOIN units ON orders.unit_id = units.unit_id
JOIN sales_channels ON orders.sales_channel_id = sales_channels.sales_channel_id
JOIN order_priorities ON orders.order_priority_id = order_priorities.order_priority_id;

CREATE VIEW sales_by_country AS
SELECT
    country_name,
    SUM(total_revenue) AS total_revenue,
    SUM(total_cost) AS total_cost,
    SUM(total_profit) AS total_profit
FROM sales
GROUP BY country_name;

CREATE VIEW sales_by_unit AS
SELECT
    item_type,
    SUM(total_revenue) AS total_revenue,
    SUM(total_cost) AS total_cost,
    SUM(total_profit) AS total_profit
FROM sales
GROUP BY item_type;

CREATE VIEW sales_last_month AS
SELECT
    *
FROM sales
WHERE order_date >= DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '1 month'
  AND order_date < DATE_TRUNC('month', CURRENT_DATE);

CREATE VIEW sales_by_year AS
SELECT
    EXTRACT(YEAR FROM order_date) AS year,
    SUM(total_revenue) AS total_revenue,
    SUM(total_cost) AS total_cost,
    SUM(total_profit) AS total_profit
FROM sales
GROUP BY year;