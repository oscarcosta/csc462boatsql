# Docker Swarm Boat Cluster

## Docker related files/folders

**mysql-cluster/** - mysql-cluster docker image

**web-app/** - web-app docker image

**docker-compose.yml** - docker containers configuration

## Shell scripts

**deploy-mysql-cluster.sh** - deploy mysql cluster + web app using docker compose

**deploy-swarm.sh** - deploy mysql cluster + web app using docker swarm

**install-docker.sh** - Install docker in a vm and init/join a swarm

**util.sh** - util scripts

## AWS EC2 vms

### Manager

ssh -i boatkey.pem ubuntu@ec2-54-149-179-164.us-west-2.compute.amazonaws.com

### Workers

ssh -i boatkey.pem ubuntu@ec2-52-39-164-186.us-west-2.compute.amazonaws.com

ssh -i boatkey.pem ubuntu@ec2-52-25-8-71.us-west-2.compute.amazonaws.com
