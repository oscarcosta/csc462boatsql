# Docker Swarm Boat Cluster

## Docker related files/folders

**mysql-cluster/** - mysql-cluster docker image

**web-app/** - web-app docker image

**docker-compose.yml** - docker containers configuration

## Shell scripts

**install-docker.sh** - Install docker in a vm and init/join a swarm

**configure-docker.sh** - Configure the docker nodes (labels)

**deploy-mysql-cluster.sh** - deploy mysql cluster + web app using docker compose

**deploy-swarm.sh** - deploy mysql cluster + web app using docker swarm

**util.sh** - util scripts

## AWS EC2 vms

### Manager

ssh -i boatkey.pem ubuntu@ec2-54-149-179-164.us-west-2.compute.amazonaws.com

* public ip = 54.149.179.164
* private ip = 172.31.30.87

### Workers

ssh -i boatkey.pem ubuntu@ec2-52-39-164-186.us-west-2.compute.amazonaws.com

* public ip = 52.39.164.186
* private ip = 172.31.31.54

ssh -i boatkey.pem ubuntu@ec2-52-25-8-71.us-west-2.compute.amazonaws.com

* public ip = 52.25.8.71
* private ip = 172.31.22.142
