# Teamcity

A docker-compose setup to start up 1 Teamcity server and 3 agents in local for testing

## First time setup

```
docker-compose up
```

- Download Postgres jdbc driver from [https://jdbc.postgresql.org/download.html#current](https://jdbc.postgresql.org/download.html#current):

```
./scripts/download-postgres-driver.sh
```

- Navigate to http://localhost:8111
- Leave the default value for data directory, click Proceed
- In Database Connection Setup, choose Postgres and fill in following details:

```
Database host: server-db
Database name: postgres
Username: postgres
Password: postgrespw
```


