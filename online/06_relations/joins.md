# Advanced JOINS

Consider again the JOIN from the lecture about
[working on relations](README.md):

customers:

| customer_id | art_id | store_id |
|----|--------|------|
| 3  | 3948573 | 1 |
| 4  | 3902938 | 1 |
| 5  | 3948573 | 2 |

articles:

| art_id | name |
|--------|------|
| 3948573 | socks |
| 3902938 | pullover |

The join used was:

```SQL
SELECT
  customer_id
FROM customers
JOIN articles ON articles.art_id=customers.art_id
WHERE name='socks'
```

Here, the **whole** 
