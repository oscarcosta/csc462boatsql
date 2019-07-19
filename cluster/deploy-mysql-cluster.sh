#!/bin/bash

# Parameters:
PASSWORD='MyPass!2'
CLUSTER='cluster'

# download the MySQL Server Docker Image
docker pull mysql/mysql-cluster

# create the internal docker network
docker network inspect $CLUSTER &> /dev/null || docker network create $CLUSTER --subnet=192.168.0.0/16

# start the management node
MGM='management1'
[[ $(docker ps --filter "name=^/$MGM$" --format '{{.Names}}') == $MGM ]] || \
    docker run -d --net=$CLUSTER --name=$MGM --ip=192.168.0.2 mysql/mysql-cluster ndb_mgmd

# start the data nodes
NODE=ndb1
[[ $(docker ps --filter "name=^/$NODE$" --format '{{.Names}}') == $NODE ]] || \
    docker run -d --net=$CLUSTER --name=$NODE --ip=192.168.0.3 mysql/mysql-cluster ndbd
#docker run -d --net=$CLUSTER --name=ndb1 --ip=192.168.0.3 mysql/mysql-cluster ndbd

NODE=ndb2
[[ $(docker ps --filter "name=^/$NODE$" --format '{{.Names}}') == $NODE ]] || \
    docker run -d --net=$CLUSTER --name=$NODE --ip=192.168.0.4 mysql/mysql-cluster ndbd
#docker run -d --net=$CLUSTER --name=ndb2 --ip=192.168.0.4 mysql/mysql-cluster ndbd

# start the MySQL server api node
SERVER=mysql1
[[ $(docker ps --filter "name=^/$SERVER$" --format '{{.Names}}') == $SERVER ]] || \
    docker run -d --net=$CLUSTER --name=$SERVER --ip=192.168.0.10 -p 3306:3306 -e MYSQL_ROOT_PASSWORD=$PASSWORD mysql/mysql-cluster mysqld
#docker run -d --net=$CLUSTER --name=$SERVER --ip=192.168.0.10 -p 3306:3306 -e MYSQL_ROOT_PASSWORD=$PASSWORD mysql/mysql-cluster mysqld
#docker run -d --net=$CLUSTER --name=$SERVER --ip=192.168.0.10 -e MYSQL_RANDOM_ROOT_PASSWORD=true mysql/mysql-cluster mysqld

# wait the server start
sleep 10

# change the mysql root password
#temp_pass=$(docker logs $SERVER 2>&1 | grep 'PASSWORD' | awk '{print $5}')
#docker exec -d $SERVER mysql --user=root --password=$temp_pass -e $(echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$PASSWORD';")

# grant remote access for root (TODO why isn't working?)
docker exec -d $SERVER mysql --user=root --password=$PASSWORD -e "CREATE USER 'root'@'%' IDENTIFIED BY '$PASSWORD';"
docker exec -d $SERVER mysql --user=root --password=$PASSWORD -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%';"
docker exec -d $SERVER mysql --user=root --password=$PASSWORD -e "FLUSH PRIVILEGES;"
#SELECT host, user FROM mysql.user;

# check cluster status
docker run -it --net=$CLUSTER mysql/mysql-cluster ndb_mgm -e "show"

# TODO use custom mysql cnf files to setup the nodes according
# TODO delete artifacts that already exists before create new ones
# TODO create cleaning script
