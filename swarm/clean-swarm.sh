#!/bin/bash

echo "Removing boatapp stack..."
docker stack rm boatapp

echo "Removing all images..."
docker rmi -f `docker images -qa`

echo "Removing all volumes..."
docker volume rm $(docker volume ls -q)
