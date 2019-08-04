#!/bin/bash
#
# Install docker in AWS EC2 instance
#

sudo apt update -q

sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

sudo apt update -q

sudo apt-cache policy docker-ce

sudo apt install -y docker-ce

sudo systemctl enable docker

sudo usermod -aG docker ${USER}

# init swarm manager
# docker swarm init --listen-addr=eth0

# init aditional swarm manager
# docker swarm join-token manager

# init swarm worker
# docker swarm join \
#  --token SWMTKN-1-1fchodgswskjw1th54s735jg4sf6s1lkpxn6040phh4ximx1fp-159r72ehyu4p3il9c083vgfh1 \
#  172.31.30.87:2377
