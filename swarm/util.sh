#!/bin/bash

####################
## swarm

## Init swarm
# docker swarm init --listen-addr=eth0

## Join as a manager
# docker swarm join-token manager

## Join as a worker
# docker swarm join \
#  --token SWMTKN-1-1fchodgswskjw1th54s735jg4sf6s1lkpxn6040phh4ximx1fp-159r72ehyu4p3il9c083vgfh1 \
#  172.31.30.87:2377

## Leave swarm
# docker swarm leave --force


####################
## node

## List nodes
# docker node ls


####################
## stack

## List deployed stack
# docker stack ls

## Show stack details
# docker stack services boatapp
# docker stack ps boatapp

## Remove stack
# docker stack rm boatapp


####################
## service

## Show/list services details
# docker service ls
# docker service ps boatapp_web


####################
## containers

## Verify the containers
# docker ps
# docker inspect cluster_mysql1_1

## Verify the mysql cluster
# docker exec -it cluster_mysql1_1 ndb_mgm -e "show"

## Import database
# docker exec -it cluster_mysql1_1 mysql -u root -p -e "$(cat ../boat.sql)"

## Connecting to MySQL Server from within the container
# docker exec -it cluster_mysql1_1 mysql -u root -p

## Container shell access
# docker exec -it cluster_mysql1_1 bash 
