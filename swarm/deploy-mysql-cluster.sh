#!/bin/bash

# build the docker images
cp ../boat.sql mysql-cluster/
docker build --no-cache -t mysql-cluster ./mysql-cluster/

cp -r ../web web-app/web
docker build --no-cache -t web-app ./web-app/

# deploy all
docker-compose up
