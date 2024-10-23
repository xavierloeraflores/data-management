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

