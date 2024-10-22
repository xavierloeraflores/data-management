-- ### Region Table

-- region
-- | field | type |
-- |-------|------|
-- | region_id | INT PRIMARY KEY |
-- | region_name | VARCHAR(255) |

CREATE TABLE  region (
    region_id INT PRIMARY KEY,
    region_name VARCHAR(255)
);

-- ### Country Table

-- country
-- | field | type |
-- |-------|------|
-- | country_id | INT PRIMARY KEY |
-- | country_name | VARCHAR(255) |
-- | region_id | INT FOREIGN KEY REFERENCES region(region_id) |

CREATE TABLE country (
    country_id INT PRIMARY KEY,
    country_name VARCHAR(255),
    region_id INT,
    FOREIGN KEY (region_id) REFERENCES region(region_id)
);


-- ### Unit Table

-- unit
-- | field | type |
-- |-------|------|
-- | unit_id | INT PRIMARY KEY |
-- | item_type | VARCHAR(255) |
-- | unit_price | DECIMAL(10,2) |
-- | unit_cost | DECIMAL(10,2) |

CREATE TABLE unit (
    unit_id INT PRIMARY KEY,
    item_type VARCHAR(255),
    unit_price DECIMAL(10,2),
    unit_cost DECIMAL(10,2)
);


-- ### Sales Channel Table

-- sales_channel
-- | field | type |
-- |-------|------|
-- | sales_channel_id | INT PRIMARY KEY |
-- | sales_channel_name | VARCHAR(255) |


CREATE TABLE sales_channel (
    sales_channel_id INT PRIMARY KEY,
    sales_channel_name VARCHAR(255)
);



-- ### Order Table

-- order
-- | field | type |
-- |-------|------|
-- | order_id | INT PRIMARY KEY |
-- | order_date | DATE |
-- | ship_date | DATE |
-- | units_sold | INT |
-- | country_id | INT FOREIGN KEY REFERENCES country(country_id) |
-- | unit_id | INT FOREIGN KEY REFERENCES unit(unit_id) |
-- | sales_channel_id | INT FOREIGN KEY REFERENCES sales_channel(sales_channel_id) |

CREATE TABLE order (
    order_id INT PRIMARY KEY,
    order_date DATE,
    ship_date DATE,
    units_sold INT,
    country_id INT,
    unit_id INT,
    sales_channel_id INT,
    FOREIGN KEY (country_id) REFERENCES country(country_id),
    FOREIGN KEY (unit_id) REFERENCES unit(unit_id),
    FOREIGN KEY (sales_channel_id) REFERENCES sales_channel(sales_channel_id)
);


