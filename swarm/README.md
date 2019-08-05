# Docker Swarm Boat Cluster

## Docker related files/folders

**mysql-cluster/** - mysql-cluster docker image

**web-app/** - web-app docker image

**docker-compose.yml** - docker containers configuration

## Shell scripts

**install-docker.sh** - Install docker in a vm and init/join a swarm

**configure-docker.sh** - Configure the docker nodes (labels)

**publish-images.sh** - Publish images in Docker Hub

**deploy-mysql-cluster.sh** - deploy mysql cluster + web app using docker compose

**deploy-swarm.sh** - deploy mysql cluster + web app using docker swarm

**util.sh** - util scripts

## AWS EC2 vms

### Manager

ssh -i boatkey.pem ec2-user@34.212.145.75

* private ip = 172.31.21.236

### Workers

ssh -i boatkey.pem ec2-user@34.220.188.80

* private ip = 172.31.30.156

ssh -i boatkey.pem ec2-user@18.237.96.62

* private ip = 172.31.28.40
