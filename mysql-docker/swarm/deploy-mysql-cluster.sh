#!/bin/bash

# build the docker images
cp ../../boat.sql mysql-cluster/
docker build --no-cache -t mysql-cluster ./mysql-cluster/

cp -r ../../web web-app/web
docker build --no-cache -t web-app ./web-app/

# create the network
docker network create cluster

# create the docker network
docker network create cluster_net --subnet=192.168.0.0/16

# deploy all
docker-compose up
