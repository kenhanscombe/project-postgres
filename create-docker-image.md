# Create a postgres docker image

Create a postgres docker image with user 'student' password 'student'.

## Files to build image

Create Dockerfile

```{sql}
FROM postgres
ENV POSTGRES_PASSWORD postgres 
COPY init.sql /docker-entrypoint-initdb.d/
```

<br>

Create init.sql file

```{sql}
DROP DATABASE IF EXISTS studentdb;
CREATE DATABASE studentdb;

CREATE USER student
WITH SUPERUSER PASSWORD 'student';

GRANT ALL PRIVILEGES ON DATABASE studentdb TO student;
```

<br>

To build from **Dockerfile** and **init.sql** and run from local build image

```{bash}
docker build -t postgres-student-image .

docker run -d --name postgres-student-container -p 5432:5432 postgres-student-image
```

<br>

## Build and push image to docker hub

Login

```{bash}
docker login docker.io
```

<br>

Build image and tag with docker username for relative path

```{bash}
docker build -t postgres-student-image .
docker tag postgres-student-image onekenken/postgres-student-image
docker login docker.io
docker push onekenken/postgres-student-image
```

<br>

Pull and run from docker hub retrieved image

```{bash}
docker pull onekenken/postgres-student-image

docker run -d --name postgres-student-container -p 5432:5432 onekenken/

postgres-student-image
```

<br>

[Image at docker hub](https://hub.docker.com/r/onekenken/postgres-student-image) address.

<br>

To rinse and repeat

```{bash}
docker stop postgres-student-container
docker rm postgres-student-container
docker rmi postgres-student-image
```
