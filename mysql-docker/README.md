# MySQL Cluster

## Content

- **deploy-mysql-cluster.sh** Script to create a 'local' MySQL NDB Cluster using docker.
- **mysql-cluster.cnf** and **my.cnf** MySQL config files

## Deployment

- If necessary clear the previous deployed artifacts running **clear-docker.sh**
- Execute **deploy-mysql-cluster.sh**
- If the server does not allow external connection by default,
  - Login into mysql via docker: **docker exec -ti mysql1 mysql --user=root -p**
  - Execute the following script:

  ```sql
  CREATE USER 'root'@'%' IDENTIFIED BY '[root_password]';
  GRANT ALL PRIVILEGES ON *.* TO 'root'@'%';
  FLUSH PRIVILEGES;
  SELECT host, user FROM mysql.user;
  ```

- The mysql docker server is configured to expose the **port 3306** to the host machine,
so it is possible to connect to it using **localhost** or server ip **192.168.0.10**
- Execute **boat.sql** on the server to build the datatabase

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
