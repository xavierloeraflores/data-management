# D597 Task 1 Writeup

Xavier Loera Flores

ID:011037676

xloeraf@wgu.edu

D596 Data Management

# Design Document

---

## Business Scenario

EcoMart is a online consumer marketplace that needs a relational database to store and manage their data. The relational database solution should be tailored to their marketplace featuring a flexible data model, scalable performance optimization, robust security measure, and monitoring and maintenance workflows.

### Business Problem

EcoMart needs a database solution that can accommodate their worldwide sales data while being able to scale to meet the demands of their growing customer base. Having a database for their marketplace sales data will allow the EcoMart team to gain key insights and answers to business questions regarding their sales data. While the the EcoMart team has a good understanding to their business standing on the global market, they do not have deep understanding as to which regions are driving their success and which regions are under performing.

### Data Structure Proposal

The following fields are available to use in the sales data:
Region,Country,Item Type,Sales Channel,Order Priority,Order Date,Order ID,Ship Date,Units Sold,Unit Price,Unit Cost,Total Revenue,Total Cost,Total Profit

The the data will be stored in a relational table data structure which include the following tables:

-   Region
-   Country
-   Unit
-   Order
-   Sales Channel
-   Order Priority

There will also be a temporary staging table which features the same columns as the original csv data spreadsheet. This table will be used to load the data into the database and then transformed into the normalized tables.

### SQL Database Solution Justification

By implementing a relational database solution, the EcoMart team can identify trends, track sales performance, and make data-driven decisions to target customers in specific regions with marketing or promotional campaigns. The database solution will allow the team to structure, store, manage, and organize their sales data, enabling them to perform data queries and analysis to gain insights into their business performance in any specified region.

### Business Data Usage

The business data will be used to track sales performance, identify trends, and make data-driven decisions to target customers in specific regions with marketing or promotional campaigns. All of the sales data will be stored into the database and normalized across different tables to ensure data integrity and consistency.

---

## Logical Data Model & Database Objects/Storage

The logical data model for the EcoMart database solution is as follows:

### Region Table

region
| field | type |
|-------|------|
| region_id | SERIAL PRIMARY KEY |
| region_name | VARCHAR(255) |

### Country Table

country
| field | type |
|-------|------|
| country_id | SERIAL PRIMARY KEY |
| country_name | VARCHAR(255) |
| region_id | INT FOREIGN KEY REFERENCES region(region_id) |

### Unit Table

unit
| field | type |
|-------|------|
| unit_id | SERIAL PRIMARY KEY |
| item_type | VARCHAR(255) |
| unit_price | DECIMAL(10,2) |
| unit_cost | DECIMAL(10,2) |

### Sales Channel Table

sales_channel
| field | type |
|-------|------|
| sales_channel_id | SERIAL PRIMARY KEY |
| sales_channel_name | VARCHAR(255) |

### Order Priority Table

order_priorities
| field | type |
| ------------------- | --------------- |
| order_priority_id | SERIAL PRIMARY KEY |
| order_priority_name | VARCHAR(255) |

### Order Table

orders
| field | type |
|-------|------|
| order_id | SERIAL PRIMARY KEY |
| order_date | DATE |
| ship_date | DATE |
| units_sold | INT |
| country_id | INT FOREIGN KEY REFERENCES countries(country_id) |
| unit_id | INT FOREIGN KEY REFERENCES units(unit_id) |
| sales_channel_id | INT FOREIGN KEY REFERENCES sales_channels(sales_channel_id) |
| order_priority_id | INT FOREIGN KEY REFERENCES order_priorities(order_priority_id) |

Total cost, total revenue, and total profit are not stored in the database as they can be calculated using the unit cost, unit price, and units sold fields.

### Staging Table

staging
| field | type |
|-------|------|
| region_name | VARCHAR(255) |
| country_name | VARCHAR(255) |
| item_type | VARCHAR(255) |
| sales_channel_name | VARCHAR(255) |
| order_priority_name | VARCHAR(255) |
| order_date | DATE |
| order_id | INT |
| ship_date | DATE |
| units_sold | INT |
| unit_price | DECIMAL(10,2) |
| unit_cost | DECIMAL(10,2) |
| total_revenue | DECIMAL(10,2) |
| total_cost | DECIMAL(10,2) |
| total_profit | DECIMAL(10,2) |

### Relationships

The relationships between the tables are as follows:

-   The `country` table has a foreign key reference to the `region` table.
-   The `order` table has foreign key references to the `country`, `unit`, `sales_channel`, and `order_priority` tables.

### Storage

The data will be stored in a relational database management system (RDBMS) such as MySQL, PostgreSQL, or SQL Server. The tables will be created in the RDBMS with the appropriate data types and constraints to ensure data integrity and consistency.

### Views

There will be one additional sales view that will be created to mimic the original data spreadsheet structure. It will contain the following fields:

-   region
-   country
-   item_type
-   sales_channel
-   order_priority
-   order_date
-   order_id
-   ship_date
-   units_sold
-   unit_price
-   unit_cost
-   total_revenue
-   total_cost
-   total_profit

The Total Revenue, Total Cost, and Total Profit fields will be calculated in the view using the Unit Price, Unit Cost, and Units Sold fields.

---

## Scalability Concerns and Strategies

The proposed database design addresses scalability concerns by organizing the data into normalized relational tables, which optimizes performance as the dataset grows. By splitting sales data into separate entities (Region, Country, Unit, Sales Channel, & Order), the database can handle increasing volumes of data more efficiently by reducing redundancy and improving query performance. Additionally, calculating fields like total revenue and total profit dynamically in views reduces storage overhead aligning the design with EcoMart’s need for flexible growth for constantly changing data.

There are 2 potential strategies using a relational database management system to address scalability needs. Firstly, we can simply scale vertically by enhancing server capacity with better compute resources as needed. This would allow us to scale introducing more complexity into our system design. The second strategy is to scale the database horizontally (distributing data across servers) via methods such as sharding or splitting data depending on the region. This would increase complexity and may require more resources but it allows to continuously scale without needing more powerful machines.

---

## Privacy and Security Measures

The following measures will be implemented to ensure EcoMart's level of privacy and security are met in the proposed database design.

-   Access controls and role-based permissions will limit database access based on user roles to ensure only authorized personnel can view or modify personal sensitive data such as orders and personal information.
-   Sensitive data like customer information or sales transactions should be encrypted using secure encryption algorithms to protect incase of an unauthorized access.
-   Logging and auditing must be set up to track and detect malicious database activity and breaches.

---
