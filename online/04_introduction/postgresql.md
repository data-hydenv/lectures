# PostgreSQL

## General

* open source database management system

* one of the most commonly used systems

* many extensions, highly customizable

* de-facto standard for (relational) spatial data

## Relational

* PostgreSQL is a **relational** database system

* **Relational** systems organize their data into *table rows*

*  duplicates are not allowed

* system handles relationships between *tables*

## Definitions

There are some concepts, that are important while working on a database. Some
of these definitions might have other meanings in other contexts.

* **dataset** (= tuple) is one row in a data table. Duplicates are not allowed.

* **attributes** describe a dataset. They are like the columns in a data table and
must have a common data type.

* **primary key** is one (or more) attributes that identify a dataset unequivocally.

* **foreign keys** are attributes that refer a dataset to a primary key of *other* tables.

* **cardinality** in simple terms, the cardinality defines the type and amount
of connections of one or more foreign keys
