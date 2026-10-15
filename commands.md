 docker run -d --name sql_cc -e POSTGRES_PASSWORD=postgres -p 5432:5432 postgres:18



 docker exec -it sql_cc psql -U postgres


  CREATE DATABASE chaicode_ecom_db;