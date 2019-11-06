# Project 1: Data modeling with Postgres

This **Udacity Data Engineering nanodegree** project creates a postgres database `sparkifydb` for a music app, *Sparkify*. The purpose of the database is to model song and log datasets (originaly stored in JSON format) with a star schema optimised for queries on song play analysis.

> **Note:** The whole exercise can be run in a docker container. See instruction below.

## Schema design and ETL pipeline

The star schema has 1 *fact* table (songplays), and 4 *dimension* tables (users, songs, artists, time). `DROP`, `CREATE`, `INSERT`, and `SELECT` queries are defined in **sql_queries.py**. **create_tables.py** uses functions `create_database`, `drop_tables`, and `create_tables` to create the database sparkifydb and the required tables.

![](sparkify_erd.png?raw=true)

Extract, transform, load processes in **etl.py** populate the **songs** and **artists** tables with data derived from the JSON song files, `data/song_data`. Processed data derived from the JSON log files, `data/log_data`, is used to populate **time** and **users** tables. A `SELECT` query collects song and artist id from the **songs** and **artists** tables and combines this with log file derived data to populate the **songplays** fact table.

## Song play example queries

Simple queries might include number of users with each membership level.

`SELECT COUNT(level) FROM users;`

Day of the week music most frequently listened to.

`SELECT COUNT(weekday) FROM time;`

Or, hour of the day music most often listened to.

`SELECT COUNT(hour) FROM time;`

<br>

### **A docker image**

I've created a docker image **postgres-student-image** on docker hub, from which you can run a container with user 'student', password 'student', and database **studentdb** (the starting point for the exercise). You do not need to install postgres (it runs in the container).

To download the image, install [docker](https://docs.docker.com/) which requires you to create a username and password. In a terminal, log into docker hub (you'll be prompted for your docker username and password)

```
docker login docker.io
```

Pull the image

```
docker pull onekenken/postgres-student-image
```

Run the container

```
docker run -d --name postgres-student-container -p 5432:5432 onekenken/postgres-student-image
```

The **create_tables.py** pre-defined connection `conn = psycopg2.connect("host=127.0.0.1 dbname=studentdb user=student password=student")` will now connect to the container.

To stop and remove the container after the exercise

```
docker stop postgres-student-container
docker rm postgres-student-container
```
