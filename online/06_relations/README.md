# Working with relations

**Note:** It is recommended to run the *Normalizing space* session of the
exercises before continuing with this lecture.


After normalizing a database, the information needed is usually split up into
several tables. Thus we need a means to combine tables again. We will look at three
ways: **sub-queries**, **views** and **joins**.

## Joins

* Most common approach is to *join* tables.

* You *glue* two table by matching a **foreign key** of the main table `ON` the **primary key** of the other table

* `JOIN`s can be chained and multiple joins on the **same** table are possible.

* If there are common attributes (like `id`, `name`), you need to specify which one to use, eg.: `tablename.attribute_name`

### Example

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

## Sub-query

* A sub-query `SELECT`s datasets from another `SELECT` instead of a table

* You have to alias (`AS`) the whole sub-query and can then *use* it like a table

* Sub-queries can be chained

* Sub-queries can also be used in filters

### Example

Consider the same example from the **JOIN**s section.
To find out who ordered `socks`, we need to first query the article id of socks
and then filter the customer table with it.

```SQL
SELECT customer_id FROM customers WHERE art_id in (SELECT art_id FROM articles WHERE name='socks') AS t;
```

Joins are way more flexible and powerful. There is a whole
optional section about [advanced joins](joins.md).

## Views

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
