#!/bin/bash

# create the docker network
docker network create --driver overlay cluster_net

# deploy all
#docker stack deploy -c docker-compose-gatekeeper.yml boatapp
docker stack deploy -c docker-compose.yml boatapp

# undeploy
# docker stack rm boatapp