#!/bin/bash

# Commands to verify the containers
# docker ps
# docker inspect cluster_mysql1_1

# Commands to verify cluster
# docker exec -it cluster_mysql1_1 ndb_mgm -e "show"

# Import database
# docker exec -it cluster_mysql1_1 mysql -u root -p -e "$(cat ../boat.sql)"

# Connecting to MySQL Server from within the Container
# docker exec -it cluster_mysql1_1 mysql -u root -p

# Container Shell Access
# docker exec -it cluster_mysql1_1 bash 