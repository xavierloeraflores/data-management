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
    region_name,
    SUM(total_revenue) AS total_revenue,
    SUM(total_cost) AS total_cost,
    SUM(total_profit) AS total_profit
FROM sales
GROUP BY country_name, region_name;

CREATE VIEW sales_by_unit AS
SELECT
    item_type,
    SUM(units_sold) AS total_units_sold,
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
    EXTRACT(YEAR FROM order_date) AS sales_year,
    SUM(total_revenue) AS total_revenue,
    SUM(total_cost) AS total_cost,
    SUM(total_profit) AS total_profit
FROM sales
GROUP BY sales_year;