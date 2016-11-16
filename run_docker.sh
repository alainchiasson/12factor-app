#!/bin/bash
. compose.env

unset DOCKER_ENV

DOCKER_ENV="-e DATABASE_HOST=$DATABASE_HOST"
DOCKER_ENV="$DOCKER_ENV -e DATABASE_USER=$DATABASE_USER"
DOCKER_ENV="$DOCKER_ENV -e DATABASE_PASSWORD=$DATABASE_PASSWORD"
DOCKER_ENV="$DOCKER_ENV -e DATABASE_NAME=$DATABASE_NAME"
DOCKER_ENV="$DOCKER_ENV -e MYSQL_DATABASE=$MYSQL_DATABASE"
DOCKER_ENV="$DOCKER_ENV -e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD"
DOCKER_ENV="$DOCKER_ENV -e DATABASE_URL=$DATABASE_URL"


docker run $DOCKER_ENV --name $DATABASE_HOST -d mysql
docker run $DOCKER_ENV --link $DATABASE_HOST  alainchiasson/12factor-dbinit
docker run $DOCKER_ENV --link $DATABASE_HOST -p 5000:5000 -d alainchiasson/12factor
