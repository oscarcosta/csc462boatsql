#!/bin/bash

# start local registry
#docker service create --name registry --publish 5000:5000 registry:2

# build test image
docker build --no-cache -t tests ../tests/

# publish test image
docker tag web-app localhost:5000/tests
docker push localhost:5000/tests

docker service create --name tests --network cluster localhost:5000/tests
