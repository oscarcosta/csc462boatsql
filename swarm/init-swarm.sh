#!/bin/bash

## Init or join a swarm

 docker swarm init --listen-addr 172.31.48.221 \
 --advertise-addr 172.31.48.221 \
 --data-path-addr 172.31.48.221

# docker swarm join-token worker

docker swarm join \
 --listen-addr 172.31.48.110 \
 --advertise-addr 172.31.48.110 \
 --data-path-addr 172.31.48.110 \
 --token WORKER_TOKEN \
 172.31.48.221:2377

## Leave swarm
# docker swarm leave --force

