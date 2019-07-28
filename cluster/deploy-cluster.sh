#!/bin/bash

# build the docker images
docker build -t management ./management/
docker build -t ndb ./ndb/
docker build -t mysql ./mysql/

# create the docker network
docker network create --attachable --driver overlay cluster

# deploy all
docker stack deploy -c docker-compose.yml cluster
