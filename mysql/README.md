# MySQL Cluster

## VMs Environment

### Manager

Private IP: 172.31.52.186

Remote access: ssh -i boatkey.pem ubuntu@54.184.34.52

### Data Nodes

#### Node 1

Private IP: 

Remote access: ssh -i boatkey.pem ubuntu@

#### Node 2

Private IP: 

Remote access: ssh -i boatkey.pem ubuntu@

### MySQL/API Nodes

Private IP: 

Remote access: ssh -i boatkey.pem ubuntu@

## Instalation (Ubuntu Linux 18.04)

https://dev.mysql.com/doc/mysql-apt-repo-quick-guide/en/#repo-qg-apt-cluster-install

* Download the MySQL APT Repository:

wget https://dev.mysql.com/get/mysql-apt-config_0.8.13-1_all.deb

* Install the downloaded release package:

sudo dpkg -i mysql-apt-config_0.8.13-1_all.deb

* During the instalation of the release package select the installations option, in this case only the Mysql Cluster 7.6.

* Update the package information:

sudo apt-get update

* Install the components for SQL nodes:

sudo apt-get install mysql-cluster-community-server

You will be asked to provide a password for the root user for your SQL node

* Install the executables for management nodes:

sudo apt-get install mysql-cluster-community-management-server

* Install the executables for data nodes:

sudo apt-get install mysql-cluster-community-data-node

## Configuration

https://dev.mysql.com/doc/refman/8.0/en/mysql-cluster-install-configuration.html

https://www.digitalocean.com/community/tutorials/how-to-create-a-multi-node-mysql-cluster-on-ubuntu-18-04

### Configuring the data nodes and SQL nodes

* Config file

sudo vim /etc/my.cnf

* Data dir

sudo vim mkdir /usr/local/mysql/data

* Startup script

sudo vim /etc/systemd/system/ndbd.service

sudo systemctl enable ndbd

### Configuring the management node

* Config file

sudo mkdir /var/lib/mysql-cluster

sudo vim /var/lib/mysql-cluster/config.ini

* Startup script

sudo vim /etc/systemd/system/ndb_mgmd.service

sudo systemctl enable ndb_mgmd
