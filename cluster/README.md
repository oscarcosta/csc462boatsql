# MySQL Cluster

## Content

- **deploy-mysql-cluster.sh** Script to create a 'local' MySQL NDB Cluster using docker.
- **mysql-cluster.cnf** and **my.cnf** MySQL config files

## References

### MySQL

- MySQL Server on Docker
https://dev.mysql.com/doc/refman/5.7/en/linux-installation-docker.html

- MySQL Team (Oracle) docker image
  - https://hub.docker.com/r/mysql/mysql-server
  - https://github.com/mysql/mysql-docker

- Docker Team docker image
  - https://hub.docker.com/_/mysql
  - https://github.com/docker-library/mysql

### NDB Cluster

- MySQL NDB Cluster documentation
https://dev.mysql.com/doc/refman/5.7/en/mysql-cluster.html

- Experimental MySQL Cluster docker images
  - https://hub.docker.com/r/mysql/mysql-cluster
  - https://github.com/mysql/mysql-docker/tree/mysql-cluster

### InnoDB Cluster *(alternative?)*

- MySQL InnoDB Cluster documentation
https://dev.mysql.com/doc/refman/5.7/en/mysql-innodb-cluster-userguide.html

- MySQL Router docker image for InnoDB Cluster
  - https://hub.docker.com/r/mysql/mysql-router
  - https://github.com/mysql/mysql-docker/tree/mysql-router

- Comparison between both
https://dev.mysql.com/doc/refman/5.7/en/mysql-cluster-compared.html

### Something to consider

- Using MySQL as a Document Store (likewise MongoDB?)
https://dev.mysql.com/doc/refman/5.7/en/document-store.html
