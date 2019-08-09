#!/bin/bash
#
# Build, Tag and Push dock images to docker hub repositores

# oscarcosta/boat-web-app
rm -rf web-app/web/
cp -r ../web web-app/web
docker build --no-cache -t web-app ./web-app/

docker tag web-app oscarcosta/boat-web-app:latest
docker push oscarcosta/boat-web-app:latest
