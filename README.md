# Dannys_Diner_SQL

## Introduction
Danny seriously loves Japanese food so in the beginning of 2021, he decides to embark upon a risky venture and opens up a cute little restaurant that sells his 3 favourite foods: sushi, curry and ramen.
Danny’s Diner is in need of your assistance to help the restaurant stay afloat - the restaurant has captured some very basic data from their few months of operation but have no idea how to use their data to help them run the business.
***

## Problem Statement
* Danny wants to use the data to answer a few simple questions about his customers, especially about their visiting patterns, how much money they’ve spent and also which menu items are their favourite. Having this deeper connection with his customers will help him deliver a better and more personalised experience for his loyal customers.

* He plans on using these insights to help him decide whether he should expand the existing customer loyalty program - additionally he needs help to generate some basic datasets so his team can easily inspect the data without needing to use SQL.

* Danny has provided you with a sample of his overall customer data due to privacy issues - but he hopes that these examples are enough for you to write fully functioning SQL queries to help him answer his questions!
***

# 📁 DATASETS
Danny has shared with you 3 key datasets for this case study:

1. SALES
<details>
  <summary>View Table</summary>
	The sales table captures all customer_id level purchases with an corresponding order_date and product_id information for when and what menu items were ordered.
	| customer_id	| order_date |	product_id |
	| --- 	| ---  | --- |
	| A |	2021-01-01 |	1 |
	| A |	2021-01-01 |	2 |
	| A |	2021-01-07 |	2 |
	| A |	2021-01-10 |	3 |
	| A |	2021-01-11 |	3 |
	| A |	2021-01-11 |	3 |
	| B |	2021-01-01 |	2 |
	| B |	2021-01-02 |	2 |
	| B |	2021-01-04 |	1 |
	| B |	2021-01-11 |	1 |
	| B |	2021-01-16 |	3 |
	| B |	2021-02-01 |	3 |
	| C |	2021-01-01 |	3 |
	| C |   2021-01-01 |	3 |
	| C |   2021-01-07 |	3 |
</details>

2. MENU
<details>
  <summary>View Table</summary>
	The menu table maps the product_id to the actual product_name and price of each menu item.
	| product_id	| product_name |	price |
	| --- 	| ---  | --- |
	| 1 |	price |	10 |
	| 2 |	curry |	15 |
	| 3 |	ramen |	12 |
	
</details>


3. MEMBERS
<details>
  <summary>View Table</summary>
	The final members table captures the join_date when a customer_id joined the beta version of the Danny’s Diner loyalty program.
	| customer_id	| join_date |
	| --- 	| ---  |
	| A |	2021-01-07 |
	| B |	2021-01-09 |
	
</details>


# 💬 CASE STUDY QUESTIONS
* What is the total amount each customer spent at the restaurant?
* How many days has each customer visited the restaurant?
* What was the first item from the menu purchased by each customer?
* What is the most purchased item on the menu and how many times was it purchased by all customers?
* Which item was the most popular for each customer?
* Which item was purchased first by the customer after they became a member?
* Which item was purchased just before the customer became a member?
* What is the total items and amount spent for each member before they became a member?
* If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
* In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?

# 🎯 INSIGHTS GENERATED
* Ramen was the most favorite dish/ ordered item by all the customers with ordered 8 times.
* Customer with Id 'A' ordered the most while Customer with ID 'B' spent the least amount
* Customer with Id 'B' visited more in the restaurant i.e., 6 times.



# Detailed Analysis with MySQL Query

### Danny has shared with you 3 key datasets for this case study:

* sales
* menu
* members
```SQL
CREATE SCHEMA dannys_diner;
USE dannys_diner;

CREATE TABLE sales (
  customer_id VARCHAR(1),
  order_date DATE,
  product_id INTEGER
);

INSERT INTO sales
  (customer_id, order_date, product_id)
VALUES
  ('A', '2021-01-01', '1'),
  ('A', '2021-01-01', '2'),
  ('A', '2021-01-07', '2'),
  ('A', '2021-01-10', '3'),
  ('A', '2021-01-11', '3'),
  ('A', '2021-01-11', '3'),
  ('B', '2021-01-01', '2'),
  ('B', '2021-01-02', '2'),
  ('B', '2021-01-04', '1'),
  ('B', '2021-01-11', '1'),
  ('B', '2021-01-16', '3'),
  ('B', '2021-02-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-07', '3');
 

CREATE TABLE menu (
  product_id INTEGER,
  product_name VARCHAR(5),
  price INTEGER
);

INSERT INTO menu
  (product_id, product_name, price)
VALUES
  ('1', 'sushi', '10'),
  ('2', 'curry', '15'),
  ('3', 'ramen', '12');
  

CREATE TABLE members (
  customer_id VARCHAR(1),
  join_date DATE
);

INSERT INTO members
  (customer_id, join_date)
VALUES
  ('A', '2021-01-07'),
  ('B', '2021-01-09');
```

[DBFiddle Link For Schema](https://www.db-fiddle.com/f/2rM8RAnq7h5LLDTzZiRWcd/138)

You can inspect the entity relationship diagram and example data below.

<img src=https://github.com/RajKumar031998/Dannys_Diner_SQL/blob/main/Danny's%20Diner%20Schema.png width=50% height=50%>

## Database and Tools
* Postgre SQL
* PgAdmin4
