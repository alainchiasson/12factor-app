#!/bin/bash
#
# Get proper environment
. compose.env

# Run the in a series of self setup docker containers.
docker-compose down && docker-compose up

docker-compose down
