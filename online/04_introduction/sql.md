# SQL language

Use the `space_raw` table for this introduction. It is installed along with
a clean initialization. If not run:

```
python -m hydenv examples space
```

## General

* standardized language, that works across all relational systems

* many packages implement pseudo-SQL  for managing data, like `pandas` (Python) or `dplyr` (R)

* most RDBMS ship with their own SQL accent, thus code is not 100% compatible

* everything you do to a database, you do in SQL. It's a common language for building up a database **and** using it.

## Syntax

* SQL is **not** case sensitive

* commands are ended by `;`, except only one command is executed

* comments start with `--`

* **quotes and double-quotes are distinguished.** Single quotes are used for `string` literals, double quotes for
structure names (like table or database names)

* SQL is type sensitive, thus the function `myFunction(5)` and `myFunction('five')` are two different functions.

## Basic commands

There are four basic commands for working with data:

* `SELECT` for requesting data or function output

* `INSERT` for adding datasets

* `UPDATE` for editing datasets

* `DELETE` for deleting data

In addition, the most important structural commands are:

* `CREATE` to add new structual elements, like `TABLE`, `CONSTRAINT`, `VIEW` or `FUNCTION`.

* `DROP` to delete database objects

* `ALTER` to edit database objects

## SELECT

The basic syntax to select is

```SQL
SELECT column_1, cololumn_2 FROM tablename
```

```SQL
SELECT location, detail, status_mission from space_raw
```

Instead of typing down **all** columns, there is the asterisk `*`, as a shortcut:

```SQL
SELECT * FROM tablename
```

### Filter

To filter the datasets, use `WHERE`

```SQL
SELECT * FROM space_raw WHERE detail = 'Saturn V | Apollo 13'
```

### LIMIT

Limit the results, to prevent PostgreSQL from returning everything, that matches a filter.

```SQL
SELECT * FROM space_raw LIMIT 5
```

### Order

Order results depending on the data type. Combined with a `LIMIT`, you can
quickly access the largest, smallest values.

```SQL
SELECT * FROM space_raw ORDER BY datum ASC LIMIT 5
```

### LIKE

With `LIKE` you can filter by *partial matches* on string fields. Use `%` as a wildcard.

```SQL
SELECT * FROM space_raw where detail LIKE '%Sputnik%'
```

### Aggregation

You can aggregate result by grouping them on one or many columns using `GROUP BY`
and then pass an aggregation function for all remaining (ungrouped) columns.
For available functions, search the documentation.

```SQL
SELECT
  company_name,
  count(*) as launches
FROM space_raw
GROUP BY company_name
ORDER BY launches DESC
LIMIT 5
```
