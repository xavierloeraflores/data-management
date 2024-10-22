
CREATE TABLE  regions (
    region_id INT PRIMARY KEY,
    region_name VARCHAR(255)
);


CREATE TABLE countries (
    country_id INT PRIMARY KEY,
    country_name VARCHAR(255),
    region_id INT,
    FOREIGN KEY (region_id) REFERENCES regions(region_id)
);


CREATE TABLE units (
    unit_id INT PRIMARY KEY,
    item_type VARCHAR(255),
    unit_price DECIMAL(10,2),
    unit_cost DECIMAL(10,2)
);



CREATE TABLE sales_channels (
    sales_channel_id INT PRIMARY KEY,
    sales_channel_name VARCHAR(255)
);



CREATE TABLE order_priorities (
    order_priority_id INT PRIMARY KEY,
    order_priority_name VARCHAR(255)
);


CREATE TABLE orders (
    order_id INT PRIMARY KEY,
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




-- Region,Country,Item Type,Sales Channel,Order Priority,Order Date,Order ID,Ship Date,Units Sold,Unit Price,Unit Cost,Total Revenue,Total Cost,Total Profit
--- Total Revenue = Units Sold * Unit Price
--- Total Cost = Units Sold * Unit Cost
--- Total Profit = Total Revenue - Total Cost

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

