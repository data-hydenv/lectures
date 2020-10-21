# SQL language

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
SELECT col_1, col_2 FROM tablename
```

Instead of typing down **all** columns, there is the asterisk `*`, as a shortcut:

```SQL
SELECT * FROM tablename
```

### Filter

To filter the datasets, use `WHERE`

```SQL
SELECT name, size FROM cities WHERE name = 'Freiburg'
```

### LIMIT

Limit the results, to prevent PostgreSQL from returning everything, that matches a filter.

```SQL
SELECT name, size FROM cities LIMIT 5
```
