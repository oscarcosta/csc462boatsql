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

ssh -i boatkey.pem ubuntu@35.162.107.88

* private ip = 172.31.29.253

### Workers

ssh -i boatkey.pem ubuntu@54.245.193.17

* private ip = 172.31.26.64

ssh -i boatkey.pem ubuntu@18.236.164.63

* private ip = 172.31.17.237
