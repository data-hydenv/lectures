# Advanced JOINS
Use the `space` table for this introduction. The needed tables were
created in the *Normalization* session. If you didn't follow that
lecture, you can create the neccessary tables using the hydenv CLI.

```
python -m hydenv examples space --normalize
```

Below, you will find the SQL queries used in the video, followed by a summary of
the lessons learned.

## SQL commands in the video

```SQL
-- recall the view
SELECT * FROM gps_missions_from_usa;
```

```SQL
-- implicit inner join
SELECT * FROM space
JOIN gps_missions_from_usa gps ON gps.company_id=space.company_id
```

```SQL
-- implicit inner join
SELECT * FROM space
JOIN gps_missions_from_usa gps ON gps.company_id=space.company_id
```

```SQL
-- left join
SELECT * FROM space
LEFT JOIN gps_missions_from_usa gps ON gps.company_id=space.company_id
```

```SQL
-- right join
SELECT * FROM space
RIGHT JOIN gps_missions_from_usa gps ON gps.company_id=space.company_id
```

## Summary

Consider again the JOIN from the lecture about
[working on relations](README.md):

customers:

| customer_id | product_id | store_id |
|----|--------|------|
| 3  | 3948573 | 1 |
| 4  | 3902938 | 1 |
| 5  | 3948573 | 2 |

products:

| products_id | name |
|--------|------|
| 3948573 | socks |
| 3902938 | pullover |

The join used was:

```SQL
SELECT
  customer_id
FROM customers
JOIN products ON products.product_id=customers.products_id
WHERE name='socks'
```

Here, the **whole** products table is joined to the customers table. Then,
the customers table is filtered by only the ones needed. As the customer table
grows larger, it can be helpful to first filter the articles and then perform the
join.

## Inner Joins

The type of join we need here is an `INNER JOIN` to the filtered `products` table.

```SQL
SELECT
  customer_id
FROM customers
INNER JOIN (SELECT * FROM products WHERE name='socks') AS sock_table
ON sock_table.product_id=customers.product_id
```

This can speed up the query by magnitudes.

## Left / Right Joins

A join has a direction. You always take all datasets from one table and then
join all the datasets from the other table that fulfill the `ON` clause.

Narrow down the products table by reducing it to the 10 most purchased products:

```SQL
CREATE TEMPORARY VIEW topseller AS
SELECT p.product_id, p.name, count(c.customer_id) AS solds
FROM customers AS c
JOIN products AS p ON p.product_id=c.product_id
GROUP BY p.product_id, p.name
ORDER BY solds
LIMIT 10
```

Now, by joining this new *table* to the customers and counting the size, we
see the different behavior demonstrated:

```SQL
SELECT count(*) FROM customers
LEFT JOIN topseller ON topseller.product_id=customers.product_id
```

and:
```SQL
SELECT count(*) FROM customers
RIGHT JOIN topseller ON topseller.product_id=customers.product_id
```
