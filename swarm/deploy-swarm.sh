#!/bin/bash

# undeploy stack
docker stack rm boatapp

# download images
docker pull dockersamples/visualizer
#docker pull oscarcosta/boat-web-app

# create the docker network
docker network create --driver overlay --attachable cluster

# deploy all
docker stack deploy -c docker-compose.yml boatapp
