# Teamcity

A docker-compose setup to start up 1 Teamcity server and 3 agents in local for testing

## Table of Contents

* [First time setup](#first-time-setup)
    * [Configure TeamCity:](#configure-teamcity)
    * [Configure Gogs](#configure-gogs)
        * [Push repository from host machine to gogs through ssh:](#push-repository-from-host-machine-to-gogs-through-ssh)
        * [Gogs utilities scripts](#gogs-utilities-scripts)
    * [Log in to Artifactory](#log-in-to-artifactory)
* [Additional Notes](#additional-notes)


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
- Click Register, fill in information to create an admin account, .e.g.

    ```
    Username: gogs
    Email: gogs@email.com
    Password: password.123
    ```

- Log in

#### Push repository from host machine to gogs through ssh:

```
./scripts/upload-public-key.sh  # upload default public key from host machine to Gogs
./scripts/create-git-repo.sh repo-name  # create repo in Gogs
git remote add gogs ssh://git@localhost:10022/[user]/[repo]
git push gogs master
```

#### Gogs utilities scripts

If you prefer command-line over Gogs UI, there are several shell scripts in `scripts` folder to automate the most common operations with Gogs:

- `./scripts/generate-token.sh`: this will create an access token with name `default-access-token` in Gogs to perform operations using Gogs REST API. This script is used internally by the 2 scripts below.
- `./scripts/create-git-repo.sh some-repo`: create git repo in Gogs
- `./scripts/upload-public-key.sh`: upload your default public key at `~/.ssh/id_rsa.pub` to Gogs server. This is so that you can push to Gogs from your host machine using SSH.

These scripts assume following tools are available in your system:

- [jq](https://stedolan.github.io/jq/)
- curl

### Log in to Artifactory

- Navigate to http://localhost:8081
- Default username: `admin`, default password: `password`

## Additional Notes

This repo uses a single postgres container that contains 3 separate databases for TeamCity, Gogs and Artifactory. The script to create Gogs and Artifactory database (TeamCity database is created by default) is at `db/create-schema.sh` and is mounted into postgres container at `/docker-entrypoint-initdb.d`. All the scripts at this location will be run automatically by postgres when starting up.
