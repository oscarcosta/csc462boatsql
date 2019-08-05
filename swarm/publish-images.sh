#!/bin/bash

# build the docker images
cp ../boat.sql mysql-cluster/
docker build --no-cache -t mysql-cluster ./mysql-cluster/

cp -r ../web web-app/web
docker build --no-cache -t web-app ./web-app/

# tag and publish the images
docker tag mysql-cluster:latest oscarcosta/boat-mysql-cluster:latest
docker push oscarcosta/boat-mysql-cluster:latest

docker tag web-app:latest oscarcosta/boat-web-app:latest
docker push oscarcosta/boat-web-app:latest
