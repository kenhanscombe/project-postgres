FROM postgres
ENV POSTGRES_PASSWORD postgres 
COPY init.sql /docker-entrypoint-initdb.d/