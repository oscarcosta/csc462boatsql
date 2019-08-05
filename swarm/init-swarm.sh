#!/bin/bash

## Init or join a swarm

 docker swarm init --listen-addr 172.31.21.236 \
 --advertise-addr 172.31.21.236 \
 --data-path-addr 172.31.21.236

# docker swarm join-token worker

docker swarm join \
 --listen-addr 172.31.30.156 \
 --advertise-addr 172.31.30.156 \
 --data-path-addr 172.31.30.156 \
 --token SWMTKN-1-4f1ek1ibhduxd83touxjbq1qmrywjjb4182g6tib74m564vshf-0wv6x5pvlca0ifgq31z2r3k2p \
 172.31.21.236:2377

docker swarm join \
 --listen-addr 172.31.28.40 \
 --advertise-addr 172.31.28.40 \
 --data-path-addr 172.31.28.40 \
 --token SWMTKN-1-4f1ek1ibhduxd83touxjbq1qmrywjjb4182g6tib74m564vshf-0wv6x5pvlca0ifgq31z2r3k2p \
 172.31.21.236:2377

## Leave swarm
# docker swarm leave --force

## Configure nodes labels
docker node update --label-add type=services ip-172-31-21-236.us-west-2.compute.internal
docker node update --label-add type=data ip-172-31-30-156.us-west-2.compute.internal
docker node update --label-add type=data ip-172-31-28-40.us-west-2.compute.internal