#!/bin/bash

# docker info
# docker ps

####################
## node

# docker node ls

## Remove nodes
# docker node rm NODE_ID
# docker node rm `docker node ls -q`

####################
## stack

# docker stack ls
# docker stack services boatapp
# docker stack ps boatapp
# docker stack ps --format "{{.Name}} {{.Node}} {{.Error}}" --no-trunc boatapp

## Remove stack
# docker stack rm boatapp

####################
## services

# docker service ls
# docker service ps boatapp_web

# docker service inspect --pretty boatapp_web
# docker service logs boatapp_web
# docker service logs -f boatapp_management

## Scale up a service
# docker service scale boatapp_web=2

## Remove service
# docker service rm boatapp_web
# docker service rm `docker service ls -q`

####################
## mysql container

# docker container ls

## Verify the mysql cluster
# docker exec -it cluster_mysql1_1 ndb_mgm -e "show"

## Import database
# docker exec -it cluster_mysql1_1 mysql -u root -p -e "$(cat ../boat.sql)"

## Connecting to MySQL Server from within the container
# docker exec -it cluster_mysql1_1 mysql -u root -p

## Container shell access
# docker exec -it cluster_mysql1_1 bash 

# docker exec boatapp_management getent hosts ndb1 
