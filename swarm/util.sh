#!/bin/bash

# docker info
# docker ps

####################
## swarm

## Init swarm
# docker swarm init --listen-addr=eth0

## Join as a manager
# docker swarm join-token manager

## Get join token
# docker swarm join-token worker

## Join as a worker
# docker swarm join \
#  --token SWMTKN-1-1fchodgswskjw1th54s735jg4sf6s1lkpxn6040phh4ximx1fp-159r72ehyu4p3il9c083vgfh1 \
#  172.31.30.87:2377

## Leave swarm
# docker swarm leave --force

####################
## node

# docker node ls

## Remove a node
# docker node rm NODE_ID

####################
## stack

# docker stack ls
# docker stack services boatapp
# docker stack ps boatapp

## Remove stack
# docker stack rm boatapp

####################
## services

# docker service ls
# docker service ps boatapp_web
# docker service inspect --pretty boatapp_web
# docker service logs boatapp_web

## Scale up a service
# docker service scale boatapp_web=2

## Remove a service
# docker service rm boatapp_web

####################
## mysql container

## Verify the mysql cluster
# docker exec -it cluster_mysql1_1 ndb_mgm -e "show"

## Import database
# docker exec -it cluster_mysql1_1 mysql -u root -p -e "$(cat ../boat.sql)"

## Connecting to MySQL Server from within the container
# docker exec -it cluster_mysql1_1 mysql -u root -p

## Container shell access
# docker exec -it cluster_mysql1_1 bash 
