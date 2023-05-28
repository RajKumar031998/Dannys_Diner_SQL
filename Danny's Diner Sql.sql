/*1 What is the total amount each customer spent at the restaurant?*/
SELECT s.customer_id ,
		SUM(price) AS total_spent 
FROM dannys_diner.sales s
LEFT JOIN dannys_diner.menu me
	ON s.product_id=me.product_id
GROUP BY customer_id
ORDER BY total_spent DESC;

/*2 How many days has each customer visited the restaurant?*/
SELECT customer_id,
		COUNT(DISTINCT order_date) AS times_visited
FROM dannys_diner.sales s 
GROUP BY customer_id;

/*3 What was the first item from the menu purchased by each customer?*/
SELECT customer_id,product_name FROM(
	SELECT s.customer_id,order_date,product_name,
	DENSE_RANK() OVER(partition by s.customer_id order by order_date) As rnk
	FROM dannys_diner.sales s
	JOIN dannys_diner.menu me 
		ON s.product_id=me.product_id
	GROUP BY s.customer_id,order_date,product_name) x
WHERE rnk=1;

/*4 What is the most purchased item on the menu and how many times was it purchased by all customers?*/
SELECT product_name,
		COUNT(product_name) AS times_ordered  
FROM dannys_diner.sales s
LEFT JOIN dannys_diner.menu me
	ON s.product_id=me.product_id
GROUP BY product_name
LIMIT 1;

/*5.Which item was the most popular for each customer?*/
WITH ranking AS (
	SELECT customer_id,
			product_id,
			count(product_id) as timeorder ,
			RANK() OVER(PARTITION BY customer_id ORDER BY count(product_id))AS ordrank 
	FROM dannys_diner.sales
	GROUP BY customer_id,product_id
	ORDER BY customer_id)

SELECT customer_id,
		product_name FROM ranking r
JOIN dannys_diner.menu me ON r.product_id=me.product_id
WHERE ordrank=1
ORDER BY customer_id,r.product_id;

/* 6 Which item was purchased first by the customer after they became a member*/

SELECT customer_id,
		product_name
FROM(
	SELECT s.customer_id,
			s.product_id,
			order_date,
			product_name,
			join_date,
	RANK() OVER(partition by s.customer_id order by order_date) As rn
	FROM dannys_diner.sales s
	JOIN dannys_diner.menu me 
		ON s.product_id=me.product_id
	JOIN dannys_diner.members mm 
		ON s.customer_id=mm.customer_id
	WHERE order_date>=join_date
	ORDER BY order_date) x
WHERE rn=1;

/* 7. Which item was purchased just before the customer became a member?*/
WITH CTE AS(
SELECT s.customer_id,order_date,s.product_id,product_name,price,join_date,
RANK() OVER(PARTITION BY s.customer_id ORDER BY order_date DESC) AS rnk
FROM dannys_diner.sales s 
JOIN dannys_diner.menu me 
	ON s.product_id=me.product_id
JOIN dannys_diner.members mm 
		ON s.customer_id=mm.customer_id
WHERE order_date<join_date)
SELECT customer_id,product_name FROM CTE
WHERE rnk=1
GROUP BY customer_id,product_name


/*8. What is the total items and amount spent for each member before they became a member*/
SELECT 
	s.customer_id,
	COUNT(s.product_id) AS total_item,
	SUM(price)AS total_spent 
FROM dannys_diner.sales s 
JOIN dannys_diner.menu me 
	ON s.product_id=me.product_id
JOIN dannys_diner.members mm 
	ON s.customer_id=mm.customer_id
WHERE order_date<join_date
GROUP BY s.customer_id
ORDER BY s.customer_id;

/*9.If each $1 spent equates to 10 points and sushi has a 2x points multiplier 
- how many points would each customer have?*/
SELECT customer_id,SUM(points)
FROM(
	SELECT *,
		CASE WHEN product_name = 'sushi' THEN price*20
		ELSE price*10
		END AS points
	FROM dannys_diner.sales s 
	JOIN dannys_diner.menu me 
		ON s.product_id=me.product_id
	ORDER BY s.customer_id)x
GROUP BY customer_id;

/*10. In the first week after a customer joins the program (including their join date)
they earn 2x points on all items, not just sushi - how many points do customer A and B 
have at the end of January?*/
SELECT 
	s.customer_id,
	SUM(CASE 
		WHEN (s.order_date >= mb.join_date) AND (s.order_date <= '2021-01-31') THEN  price*20
            	WHEN (s.order_date < mb.join_date) AND (m.product_name='sushi') THEN price*20 ELSE price*10
	    END) as Points
FROM 
	dannys_diner.menu AS m
JOIN 
	dannys_diner.sales AS s ON s.product_id = m.product_id
JOIN 
	dannys_diner.members AS mb ON s.customer_id = mb.customer_id
GROUP BY s.customer_id ;

/*10. All tables*/


SELECT * FROM dannys_diner.sales 
SELECT * FROM dannys_diner.menu
SELECT * FROM dannys_diner.members




