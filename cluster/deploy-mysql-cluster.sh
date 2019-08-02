#!/bin/bash

# build the docker images
docker build --no-cache -t mysql-cluster ./mysql-cluster/

cp -r ../web web-app/web
docker build --no-cache -t web-app ./web-app/

# create the docker network
#docker network create --attachable --driver overlay cluster

# deploy all
#docker stack deploy -c docker-compose.yml cluster
docker-compose up

# Commands to verify the containers
# docker ps
# docker inspect cluster_mysql1_1

# Commands to verify cluster
# docker exec -it cluster_mysql1_1 ndb_mgm -e "show"

# Import database
# docker exec -it cluster_mysql1_1 mysql -u root -e "$(cat ../boat.sql)"

# Connecting to MySQL Server from within the Container
# docker exec -it cluster_mysql1_1 mysql -u root

# Container Shell Access
# docker exec -it cluster_mysql1_1 bash 
