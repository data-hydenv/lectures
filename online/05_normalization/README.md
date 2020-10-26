# Database normalization

* the relational concept alone does not make a good database

* a database is only as useful as the structure it represents

* the data model is way more important than the choice of RDBMS

* The structure should be as simple as possible while being as complex as necessary

## What is DB normalization?

* The overall goal is to avoid data inconsistencies and make the schema flexible

* The database is split up into different tables, each one representing only
one *topic*

* Avoid duplicated *values* in the database

* non-normalized databases are usually screwed up, when editing data

* There are 5 rules of normalization, of which three will be covered

* The five rules will be applied one after another

## First normal form

The database is in first normal form when all data ranges are **atomic**.

This is important to make the attributes query-able and avoid
inconsistencies.

non-atomic:

| customer_id | purchase |
|----|---------|
| 3  | 3948573 - socks , Bakers, San Francisco |
| 4  | 3902938 - pullover , Bakers, San Francisco |
| 5  | 3948573 - sock , Marcy's, Los Angeles |

atomic:

| customer_id | art_id | art_name | store_name | store_location |
|----|--------|-----|------|-----|
| 3  | 3948573 | socks | Bakers | San Francisco |
| 4  | 3902938 | pullover | Bakers | San Francisco |
| 5  | 3948573 | sock | Marcy's | Los Angeles |


## Second normal form

The database is in second normal form when it's in fist normal form and any non-prime attribute is fully dependent on the primary key.

Simpler: Put everything that has duplicated values into its own table, if possible.

| customer_id | art_id | store_id |
|----|--------|------|
| 3  | 3948573 | 1 |
| 4  | 3902938 | 1 |
| 5  | 3948573 | 2 |

| art_id | name |
|--------|------|
| 3948573 | socks |
| 3902938 | pullover |

| store_id | name | location |
| ---------|------|-------|
| 1 | Bakers | San Francisco |
| 2 | Marcy's | Los Angeles |

## Third normal form

A database is in third normal form when it's in second normal form and no non-prime
attribute is transitive dependent on any other non-prime attribute.

Simpler: Everything that's not a primary or foreign key must not depend on anything else than
a primary key.

Consider:

| store_id | name | location |
| ---------|------|-------|
| 1 | Bakers | San Francisco |
| 2 | Marcy's | Los Angeles |

Here, `location` is transitive dependent on `name` and not on `the store_id`.

Normalized:

| store_id | name | location_id |
| ---------|------|-------|
| 1 | Bakers | 1 |
| 2 | Marcy's | 2 |

| location_id | name |
| ------------| ----|
| 1 | San Francisco |
| 2 | Los Angeles |

Then, if we open more stores:

| store_id | name | location_id |
| ---------|------|-------|
| 1 | Bakers | 1 |
| 2 | Marcy's | 2 |
| 3 | Bakers | 2 |
| 4 | Tech Market | 2 |  
