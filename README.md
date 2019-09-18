# Teamcity

A docker-compose setup to start up 1 Teamcity server and 3 agents in local for testing

## First time setup

This repository includes 2 additional docker-compose files to setup gogs (local git server) and artifactory

First, determine whether you just want to install TeamCity, TeamCity + Gogs, or TeamCity + Gogs + Artifactory

In `.env` file, there are 3 lines for `COMPOSE_FILE` corresponding to the 3 configurations above. Uncomment the line that you want. This environment variable will let docker-compose know what are the files that it should look into by default. This is to avoid you having to specify `-f` option multiple times in each docker-compose command.

Then run:

```
docker-compose up -d
```

### Configure TeamCity:

- Download Postgres jdbc driver from [https://jdbc.postgresql.org/download.html#current](https://jdbc.postgresql.org/download.html#current):

```
./scripts/download-postgres-driver.sh
```

- Navigate to http://localhost:8111
- Leave the default value for data directory, click Proceed
- In Database Connection Setup, choose Postgres and fill in following details:

```
Database host: db
Database name: teamcity
Username: postgres
Password: postgrespw
```

### Configure Gogs

- Navigate to http://localhost:3000
- Fill in following details:

```
Database Type: PostgreSQL
Host: db:5432
User: postgres
Password: password.123
Database Name: gogs
```

Fill in `Admin Account Settings` at the bottom of the page

- Click `Install Gogs`

Note: to push repository from host machine to gogs through ssh:
- Log in to gogs at http://localhost:3000
- Add host machine public key to settings page
- Create new repository in gogs
- Add git remote:

```
git remote add gogs ssh://git@localhost:10022/[user]/[repo]
```

- Execute

```
git push gogs master
```

### Log in to Artifactory

- Navigate to http://localhost:8081
- Default username: `admin`, default password: `password`

## Additional Notes

This repo uses a single postgres container that contains 3 separate databases for TeamCity, Gogs and Artifactory. The script to create Gogs and Artifactory database (TeamCity database is created by default) is at `db/create-schema.sh` and is mounted into postgres container at `/docker-entrypoint-initdb.d`. All the scripts at this location will be run automatically by postgres when starting up.
