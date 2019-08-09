#!/bin/bash

# Parameters:
PASSWORD='MyPass!2'
CLUSTER='cluster'

# download the MySQL Server Docker Image
echo "# Downloading the docker image..."

docker pull mysql/mysql-cluster

cp -r ../web web-app/web
docker build --no-cache -t web-app ./web-app/

# create the internal docker network
echo "# Creating docker networkd..."

docker network create $CLUSTER --subnet=192.168.0.0/16

# start the management nodes
echo "# Starting management nodes..."

MGM='management1'
docker run -d --net=$CLUSTER --name=$MGM --ip=192.168.0.2 --volume=$(pwd)/mysql-cluster.cnf:/etc/mysql-cluster.cnf mysql/mysql-cluster ndb_mgmd

# start the data nodes
echo "# Starting data nodes..."

NODE='ndb1'
docker run -d --net=$CLUSTER --name=$NODE --ip=192.168.0.10 --volume=$(pwd)/my.cnf:/etc/my.cnf mysql/mysql-cluster ndbd
#docker run -d --net=$CLUSTER --name=ndb1 --ip=192.168.0.3 mysql/mysql-cluster ndbd

NODE='ndb2'
docker run -d --net=$CLUSTER --name=$NODE --ip=192.168.0.11 --volume=$(pwd)/my.cnf:/etc/my.cnf mysql/mysql-cluster ndbd
#docker run -d --net=$CLUSTER --name=ndb2 --ip=192.168.0.4 mysql/mysql-cluster ndbd

# start the MySQL server api nodes
echo "# Starting sql nodes..."

SERVER='mysql1'
docker run -d --net=$CLUSTER --name=$SERVER --ip=192.168.0.20 -e MYSQL_ROOT_PASSWORD=$PASSWORD --volume=$(pwd)/my.cnf:/etc/my.cnf mysql/mysql-cluster mysqld
#docker run -d --net=$CLUSTER --name=$SERVER --ip=192.168.0.10 -e MYSQL_ROOT_PASSWORD=$PASSWORD mysql/mysql-cluster mysqld
#docker run -d --net=$CLUSTER --name=$SERVER --ip=192.168.0.10 -e MYSQL_RANDOM_ROOT_PASSWORD=true mysql/mysql-cluster mysqld

# wait the cluster to start
echo "# Please, hold on until the cluster initializes..."
sleep 10

# change the mysql root password
#temp_pass=$(docker logs $SERVER 2>&1 | grep 'PASSWORD' | awk '{print $5}')
#docker exec -d $SERVER mysql --user=root --password=$temp_pass -e $(echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$PASSWORD';")

# Configure the user credentials
echo "# Configuring server credentials..."

docker exec -d $SERVER mysql --user=root --password=$PASSWORD -e "CREATE USER 'root'@'%' IDENTIFIED BY '$PASSWORD';"
docker exec -d $SERVER mysql --user=root --password=$PASSWORD -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%';"
docker exec -d $SERVER mysql --user=root --password=$PASSWORD -e "FLUSH PRIVILEGES;"
#SELECT host, user FROM mysql.user;

# Create the database
echo "# Create BoatDB..."

docker exec -d $SERVER mysql --user=root --password=$PASSWORD -e "$(cat ../boat.sql)"

# start the web application
echo " Starting web application..."

docker run -d --net=$CLUSTER --name='web' --ip=192.168.0.30 -p 3000:3000 -e MYSQL_host=192.168.0.20 -e MYSQL_database=boatdb -e MYSQL_user=root -e MYSQL_password=$PASSWORD -e CSV_filename=data.csv web-app

echo "# Finalizing..."
# check cluster status

docker run -it --net=$CLUSTER --volume=$(pwd)/mysql-cluster.cnf:/etc/mysql-cluster.cnf mysql/mysql-cluster ndb_mgm -e "show"
docker ps

# Connecting to MySQL Server from within the Container
#docker exec -it mysql1 mysql -uroot -p

# Container Shell Access
#docker exec -it mysql1 bash 
