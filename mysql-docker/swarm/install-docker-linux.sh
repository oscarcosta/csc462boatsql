#!/bin/bash
#
# Install docker in Amazon Linux 2 AMI
#

sudo yum update -y

sudo amazon-linux-extras install docker -y

sudo service docker start

sudo usermod -aG docker ec2-user

sudo yum install git -y
