
CREATE TABLE  regions (
    region_id INT PRIMARY KEY,
    region_name VARCHAR(255) UNIQUE
);


CREATE TABLE countries (
    country_id INT PRIMARY KEY,
    country_name VARCHAR(255) UNIQUE,
    region_id INT,
    FOREIGN KEY (region_id) REFERENCES regions(region_id)
);


CREATE TABLE units (
    unit_id INT PRIMARY KEY,
    item_type VARCHAR(255) UNIQUE,
    unit_price DECIMAL(10,2),
    unit_cost DECIMAL(10,2)
);



CREATE TABLE sales_channels (
    sales_channel_id INT PRIMARY KEY,
    sales_channel_name VARCHAR(255) UNIQUE
);



CREATE TABLE order_priorities (
    order_priority_id INT PRIMARY KEY,
    order_priority_name VARCHAR(255) UNIQUE
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

