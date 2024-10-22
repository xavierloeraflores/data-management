-- Region,Country,Item Type,Sales Channel,Order Priority,Order Date,Order ID,Ship Date,Units Sold,Unit Price,Unit Cost,Total Revenue,Total Cost,Total Profit
--- Total Revenue = Units Sold * Unit Price
--- Total Cost = Units Sold * Unit Cost
--- Total Profit = Total Revenue - Total Cost

CREATE VIEW sales AS
SELECT
    region.region_name,
    country.country_name,
    unit.item_type,
    unit.unit_price,
    unit.unit_cost,
    sales_channel.sales_channel_name,
    order_priority.order_priority_name,
    order.order_date,
    order.order_id,
    order.ship_date,
    order.units_sold,
    order.units_sold * unit.unit_price AS total_revenue,
    order.units_sold * unit.unit_cost AS total_cost,
    order.units_sold * unit.unit_price - order.units_sold * unit.unit_cost AS total_profit
FROM region
JOIN country ON region.region_id = country.region_id
JOIN order ON country.country_id = order.country_id
JOIN unit ON order.unit_id = unit.unit_id
JOIN sales_channel ON order.sales_channel_id = sales_channel.sales_channel_id
JOIN order_priority ON order.order_priority_id = order_priority.order_priority_id;

