FROM mysql/mysql-cluster

COPY ./mysql-cluster.cnf /etc/mysql-cluster.cnf

ENTRYPOINT ["ndb_mgmd"]
