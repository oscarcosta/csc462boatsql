#!/bin/bash
#
# Install docker in Ubuntu AMI
#

sudo apt update -q

sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

sudo apt update -q

sudo apt-cache policy docker-ce

sudo apt install -y docker-ce

sudo usermod -aG docker ubuntu

sudo systemctl enable docker

sudo systemctl start docker
