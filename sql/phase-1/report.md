# REPORT

## Team Members

- Anthony Chraim
- Ethan Benabou
- Justin Loh
- Mohamed Amine Kihal

## Files

- `data/`: scripts for pre-processing the input `.dat` files.
- `sql/`: queries, views, etc. to answer the assignment questions.
- `results-csv/`: csv files displaying the output of all queries.
- `docker/`: docker-compose file and scripts for using Postgres.
- `schema.sql`: SQL statements for creating the table schema.
- `erd.png`: Entity-Relation diagram, exported from Postgres.

## Introduction

**DATABASE:** PostgreSQL v12.6 in Docker


## Procedures




## Performance Analysis

| Question No.  | Type                   | Execution time  |
| ------------- |:----------------------:| ---------------:|
| 3-K-2         | View                   | 25 sec 318 msec |
| 3-L           | View                   | 2 min 29 sec    |
| 4-K-2         | Materialized View      | 147 msec        |
| 4-L           | Materialized View      | 226 msec        |



## Discussion

Based on the observation obtained , it is confirmed that that the execution time of
materialized views complete in proportionately less time compared to that of normal
views.  As materialized views exist physically as entities in disk space, the execution
time is much quicker that views which are simply stored in a temporary virtual space
after view creation. Hence, it is recommended to use materialized views in the storage
of data with a seldom need for updates.

However unlike normal views , materialized views are not automated to be updated
with each view use. Materialized views need to be manually updated with via specific
commands or the use of triggers, in comparison, normal views are updated after each
view use in different query statements, making normal views much more responsive in
storing up-to-date information.
