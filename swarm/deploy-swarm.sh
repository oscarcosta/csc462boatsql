#!/bin/bash

# build the docker images
#cp ../boat.sql mysql-cluster/
#docker build --no-cache -t mysql-cluster ./mysql-cluster/

#cp -r ../web web-app/web
#docker build --no-cache -t web-app ./web-app/

# create the docker network
docker network create --driver overlay cluster_net

# deploy all
docker stack deploy -c docker-compose.yml boatapp
