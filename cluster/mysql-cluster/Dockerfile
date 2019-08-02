#
# https://github.com/mysql/mysql-docker/tree/mysql-cluster
#
FROM mysql/mysql-cluster

#RUN mkdir /usr/mysql-cluster

# Override default config files
COPY my.cnf /etc/
COPY mysql-cluster.cnf /etc/
COPY my_entrypoint.sh /my_entrypoint.sh
