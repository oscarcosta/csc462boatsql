#!/bin/bash

# Parameters:
PASSWORD='MyPass!2'
CLUSTER='cluster'

# download the MySQL Server Docker Image
docker pull mysql/mysql-cluster

# create the internal docker network
docker network create $CLUSTER --subnet=192.168.0.0/16

# start the management node 
docker run -d --net=$CLUSTER --name=management1 --ip=192.168.0.2 mysql/mysql-cluster ndb_mgmd

# start the data nodes
docker run -d --net=$CLUSTER --name=ndb1 --ip=192.168.0.3 mysql/mysql-cluster ndbd
docker run -d --net=$CLUSTER --name=ndb2 --ip=192.168.0.4 mysql/mysql-cluster ndbd

# start the MySQL server api node
SERVER=mysql1
docker run -d --net=$CLUSTER --name=$SERVER --ip=192.168.0.10 -e MYSQL_RANDOM_ROOT_PASSWORD=true mysql/mysql-cluster mysqld

# change the mysql root password
temp_pass=$(docker logs $SERVER 2>&1 | grep 'PASSWORD' | awk '{print $5}')
docker exec -d $SERVER mysql --user=root --password=$temp_pass -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$PASSWORD';"

# check cluster status
docker run -it --net=$CLUSTER mysql/mysql-cluster ndb_mgm -e "show"

# TODO use custom mysql cnf files to setup the nodes according
# TODO delete artifacts that already exists before create new ones
# TODO create cleaning script

