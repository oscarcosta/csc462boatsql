#!/bin/bash
#
# Build, Tag and Push dock images to docker hub repositores

# oscarcosta/boat-web-app
cp -r ../web web-app/web
docker build --no-cache -t web-app ./web-app/

docker tag web-app:latest oscarcosta/boat-web-app:latest
docker push oscarcosta/boat-web-app:latest

