--ANALYSIS OF SALES DATA --
--creating sales table--

CREATE TABLE sales(
    sale_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name  VARCHAR(50) NOT NULL,
    category VARCHAR(30),
    price DECIMAL(10,2),
    quantity INT,
    sale_date DATE
);


--insert data into the table--


INSERT INTO sales VALUES
(1, 'Laptop', 'Electronics', 850, 1, '2025-01-05'),
(2, 'Mouse', 'Electronics', 20, 2, '2025-01-07'),
(3, 'Shoes', 'Fashion', 60, 1, '2025-01-08'),
(4, 'Shirt', 'Fashion', 30, 3, '2025-01-09'),
(5, 'TV', 'Electronics', 600, 1, '2025-01-10');



--checking results of table creation--

SELECT * FROM sales;




--calculating total revenue for each product--


SELECT 
product_name, 
(price*quantity) AS  total_venue
FROM sales;



--finding total sales by category--

SELECT
category,
SUM(price*quantity) AS total_sales
FROM sales
GROUP BY category;



--fnding most sold by quantity--

SELECT
product_name,
SUM (quantity) AS total_quantity   
FROM sales
GROUP BY product_name
ORDER BY total_quantity DESC;




-- filtering sales dates--

SELECT *
FROM  sales
WHERE sale_date > '2025-01-07';













-- CUSTOMER PURCHASE ANALYSIS--


--creating customer table--
CREATE TABLE customers (
  customer_id INT PRIMARY KEY,
  name VARCHAR(50),
  city VARCHAR(50),
  gender CHAR(1)
);

--creating orders table--

CREATE TABLE orders (
  order_id INT PRIMARY KEY,
  customer_id INT,
  order_date DATE,
  amount DECIMAL(10,2),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);


-- adding data into the table --
INSERT INTO customers VALUES
(1, 'John', 'Nairobi', 'M'),
(2, 'Mary', 'Kisumu', 'F'),
(3, 'Peter', 'Mombasa', 'M'),
(4, 'Alice', 'Nakuru', 'F');

INSERT INTO orders VALUES
(1, 1, '2025-02-01', 1200),
(2, 2, '2025-02-03', 450),
(3, 3, '2025-02-05', 800),
(4, 1, '2025-02-06', 300),
(5, 4, '2025-02-08', 700);


--checking result of creation--

SELECT * FROM orders ;



-- getting all purchase details--

SELECT 
  c.name,
  c.city,
  o.order_id,
  o.order_date,
  o.amount
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id;



--total amount spent per customer--

SELECT 
  c.name,
  SUM(o.amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.name
ORDER BY total_spent DESC;


--average order amount by gender--

SELECT 
  c.gender,
  AVG(o.amount) AS avg_order_amount
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.gender;




--classifying custmers by spending level--

SELECT 
  c.name,
  SUM(o.amount) AS total_spent,
  CASE
    WHEN SUM(o.amount) > 1000 THEN 'High Spender'
    WHEN SUM(o.amount) BETWEEN 500 AND 1000 THEN 'Medium Spender'
    ELSE 'Low Spender'
  END AS spending_category
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.name;





