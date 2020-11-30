# Working with relations
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
-- overview
SELECT * FROM space
```

```SQL
-- join another table
SELECT * FROM space
JOIN locations on locations.location_id=space.location_id
```

```SQL
-- aggregate over a join
SELECT
	l.country,
	count(DISTINCT location_name) as space_ports,
	count(*) as launches
FROM space s
JOIN locations l on l.location_id=s.location_id
GROUP BY l.country
ORDER BY launches DESC
```

```SQL
-- filter on a subquery
SELECT * FROM
space WHERE location_id IN
(
	SELECT location_id FROM locations
	WHERE country='USA'
)
```

```SQL
-- use a subquery for selecting an attribute
SELECT
	datum,
	mission_detail,
	(SELECT company_name FROM companies WHERE companies.company_id=space.company_id) as company
FROM
space
WHERE location_id IN
(
	SELECT location_id FROM locations
	WHERE country='USA'
)
AND mission_detail LIKE '%GPS%'
```

```SQL
-- group from a subquery
SELECT
	count(*) AS missions,
	round(date_part('days', max(datum) - min(datum)) / 365) || ' years' AS "serving years",
	(SELECT company_name FROM companies WHERE companies.company_id=space.company_id) AS company
FROM
space
WHERE location_id IN
(
	SELECT location_id FROM locations
	WHERE country='USA'
)
AND mission_detail LIKE '%GPS%'
GROUP BY company
```

```SQL
-- Create a view from previous query
DROP VIEW IF EXISTS gps_missions_from_usa;
CREATE TEMPORARY VIEW gps_missions_from_usa AS
SELECT
	company_id,
	count(*) AS missions,
	round(date_part('days', max(datum) - min(datum)) / 365) || ' years' AS "serving years",
	(SELECT company_name FROM companies WHERE companies.company_id=space.company_id) AS company
FROM
space
WHERE location_id IN
(
	SELECT location_id FROM locations
	WHERE country='USA'
)
AND mission_detail LIKE '%GPS%'
GROUP BY company, company_id;
SELECT * FROM gps_missions_from_usa;
```


## Summary

After normalizing a database, the information needed is usually split up into
several tables. Thus we need a means to combine tables again. We will look at three
ways: **sub-queries**, **views** and **joins**.

### Joins

* Most common approach is to *join* tables.

* You *glue* two table by matching a **foreign key** of the main table `ON` the **primary key** of the other table

* `JOIN`s can be chained and multiple joins on the **same** table are possible.

* If there are common attributes (like `id`, `name`), you need to specify which one to use, eg.: `tablename.attribute_name`

#### Example

Consider the example db from the [normalization lecture](../05_normalization/README.md):

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

To find out which customer ordered socks, we need to **join** the articles by `art_id` and **then** filter only
the customers that ordered socks.

```SQL
SELECT
  customer_id
FROM customers
JOIN articles ON articles.art_id=customers.art_id
WHERE name='socks'
```

### Sub-query

* A sub-query `SELECT`s datasets from another `SELECT` instead of a table

* You have to alias (`AS`) the whole sub-query and can then *use* it like a table

* Sub-queries can be chained

* Sub-queries can also be used in filters

#### Example

Consider the same example from the **JOIN**s section.
To find out who ordered `socks`, we need to first query the article id of socks
and then filter the customer table with it.

```SQL
SELECT customer_id FROM customers WHERE art_id in (SELECT art_id FROM articles WHERE name='socks') AS t;
```

Joins are way more flexible and powerful. There is a whole
optional section about [advanced joins](joins.md).

### Views

Views are a very powerful concept in SQL. A `VIEW` is a structural, **persistent** element in in PostgreSQL.
You can think of it like a saved `SELECT` query.

Instead of nesting multiple sub-queries, maybe including
multiple `JOIN`s on each level, you can persist a **view**
on the data.

`VIEW`s can be used in `SELECT` queries just like tables. But they don't store the result, only the query. That means,
it is only executed at query time, potentially slowing down
the whole query. On the other hand, it will always query the
most recent values from tables with **dynamic** content.

```SQL
CREATE VIEW customers_loving_socks AS
SELECT
  customer_id, store_id
FROM customers
JOIN articles ON articles.art_id=customers.art_id
WHERE articles.name='socks'
```
