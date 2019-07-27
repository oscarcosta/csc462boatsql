#!/bin/bash

# Parameters:
PASSWORD='MyPass!2'
CLUSTER='cluster'


# download the MySQL Server Docker Image
echo "# Downloading the docker image..."

docker pull mysql/mysql-cluster


# create the internal docker network
echo "# Creating docker networkd..."

docker network inspect $CLUSTER &> /dev/null || docker network create $CLUSTER --subnet=192.168.0.0/16


# start the management nodes
echo "# Starting management nodes..."

MGM='management1'
docker run -d --net=$CLUSTER --name=$MGM --ip=192.168.0.2 --volume=$(pwd)/mysql-cluster.cnf:/etc/mysql-cluster.cnf mysql/mysql-cluster ndb_mgmd

MGM='management2'
docker run -d --net=$CLUSTER --name=$MGM --ip=192.168.0.3 --volume=$(pwd)/mysql-cluster.cnf:/etc/mysql-cluster.cnf mysql/mysql-cluster ndb_mgmd

# start the data nodes
echo "# Starting data nodes..."

NODE=ndb1
docker run -d --net=$CLUSTER --name=$NODE --ip=192.168.0.10 --volume=$(pwd)/my.cnf:/etc/my.cnf mysql/mysql-cluster ndbd
#docker run -d --net=$CLUSTER --name=ndb1 --ip=192.168.0.3 mysql/mysql-cluster ndbd

NODE=ndb2
docker run -d --net=$CLUSTER --name=$NODE --ip=192.168.0.11 --volume=$(pwd)/my.cnf:/etc/my.cnf mysql/mysql-cluster ndbd
#docker run -d --net=$CLUSTER --name=ndb2 --ip=192.168.0.4 mysql/mysql-cluster ndbd

# start the MySQL server api nodes
echo "# Starting sql nodes..."

SERVER=mysql1
docker run -d --net=$CLUSTER --name=$SERVER --ip=192.168.0.20 -e MYSQL_ROOT_PASSWORD=$PASSWORD --volume=$(pwd)/my.cnf:/etc/my.cnf mysql/mysql-cluster mysqld
#docker run -d --net=$CLUSTER --name=$SERVER --ip=192.168.0.10 -p 3306:3306 -e MYSQL_ROOT_PASSWORD=$PASSWORD mysql/mysql-cluster mysqld
#docker run -d --net=$CLUSTER --name=$SERVER --ip=192.168.0.10 -e MYSQL_RANDOM_ROOT_PASSWORD=true mysql/mysql-cluster mysqld

SERVER=mysql2
docker run -d --net=$CLUSTER --name=$SERVER --ip=192.168.0.21 -e MYSQL_ROOT_PASSWORD=$PASSWORD --volume=$(pwd)/my.cnf:/etc/my.cnf mysql/mysql-cluster mysqld
#docker run -d --net=$CLUSTER --name=$SERVER --ip=192.168.0.10 -p 3306:3306 -e MYSQL_ROOT_PASSWORD=$PASSWORD mysql/mysql-cluster mysqld
#docker run -d --net=$CLUSTER --name=$SERVER --ip=192.168.0.10 -e MYSQL_RANDOM_ROOT_PASSWORD=true mysql/mysql-cluster mysqld


# wait the server start
echo "# Please, hold on until the system initializes..."
sleep 30


# change the mysql root password
#temp_pass=$(docker logs $SERVER 2>&1 | grep 'PASSWORD' | awk '{print $5}')
#docker exec -d $SERVER mysql --user=root --password=$temp_pass -e $(echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$PASSWORD';")

echo "# Configuring server credentials..."
# grant remote access for root (TODO why isn't working?)
docker exec -d $SERVER mysql --user=root --password=$PASSWORD -e "CREATE USER 'root'@'%' IDENTIFIED BY '$PASSWORD';"
docker exec -d $SERVER mysql --user=root --password=$PASSWORD -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%';"
docker exec -d $SERVER mysql --user=root --password=$PASSWORD -e "FLUSH PRIVILEGES;"
#SELECT host, user FROM mysql.user;

echo "# Finalizing..."
# check cluster status
docker run -it --net=$CLUSTER --volume=$(pwd)/mysql-cluster.cnf:/etc/mysql-cluster.cnf mysql/mysql-cluster ndb_mgm -e "show"


# Connecting to MySQL Server from within the Container
#docker exec -it mysql1 mysql -uroot -p


# Container Shell Access
#docker exec -it mysql1 bash 
