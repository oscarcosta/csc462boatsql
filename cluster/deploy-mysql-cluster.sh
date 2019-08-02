#!/bin/bash

# build the docker image
docker build --no-cache -t mysql-cluster ./mysql-cluster/

# create the docker network
#docker network create --attachable --driver overlay cluster

# deploy all
#docker stack deploy -c docker-compose.yml cluster
docker-compose up

# Commands to verify the containers
# docker ps
# docker inspect cluster_mysql1_1

# Import database
# docker exec -it cluster_mysql1_1 mysql -u root -e "$(cat ../boat.sql)"

# Connecting to MySQL Server from within the Container
# docker exec -it cluster_mysql1_1 mysql -u root

# Container Shell Access
# docker exec -it cluster_mysql1_1 bash 
