#!/bin/bash

# mysql-cluster
cp ../boat.sql mysql-cluster/
docker build --no-cache -t mysql-cluster ./mysql-cluster/

docker tag mysql-cluster:latest oscarcosta/boat-mysql-cluster:latest
docker push oscarcosta/boat-mysql-cluster:latest


# web-app
cp -r ../web web-app/web
docker build --no-cache -t web-app ./web-app/

docker tag web-app:latest oscarcosta/boat-web-app:latest
docker push oscarcosta/boat-web-app:latest


# gatekeeper
docker build --no-cache -t gatekeeper ./gatekeeper/

docker tag gatekeeper:latest oscarcosta/gatekeeper:latest
docker push oscarcosta/gatekeeper:latest
