#!/bin/bash

# start local registry
docker service create --name registry --publish 5000:5000 registry:2

# build image
rm -rf web-app/web/
cp -r ../web web-app/web
docker build --no-cache -t web-app ./web-app/

# publish image
docker tag web-app localhost:5000/web-app
docker push localhost:5000/web-app

#docker service create --name imgservice localhost:5000/web-app
