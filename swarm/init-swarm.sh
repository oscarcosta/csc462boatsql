#!/bin/bash

## Init or join a swarm

 docker swarm init --listen-addr 172.31.29.253 \
 --advertise-addr 172.31.29.253 \
 --data-path-addr 172.31.29.253

# docker swarm join-token worker

docker swarm join \
 --listen-addr 172.31.26.64 \
 --advertise-addr 172.31.26.64 \
 --data-path-addr 172.31.26.64 \
 --token SWMTKN-1-1i9pdihfdgwzq4lsfdvmdghtlkxabhf7ahjgk0fftouwlu0z0x-dxze072pclv68hpjp2ioxey3y \
 172.31.29.253:2377

docker swarm join \
 --listen-addr 172.31.17.237 \
 --advertise-addr 172.31.17.237 \
 --data-path-addr 172.31.17.237 \
 --token SWMTKN-1-1i9pdihfdgwzq4lsfdvmdghtlkxabhf7ahjgk0fftouwlu0z0x-dxze072pclv68hpjp2ioxey3y \
 172.31.29.253:2377

## Leave swarm
# docker swarm leave --force

## Configure nodes labels
docker node update --label-add type=services ip-172-31-29-253
docker node update --label-add type=data ip-172-31-26-64
docker node update --label-add type=data ip-172-31-17-237