#!/usr/bin/env bash
export VERSION=${1:-5.0.1-SNAPSHOT}
echo $VERSION
export DOCKER_TAG=$VERSION
export IMAGE_NAME="entando/engine-api:$VERSION"
export DOCKERFILE_PATH="$(dirname $0)/Dockerfile"
source hooks/build
#docker push 172.30.1.1:5000/entando/engine-api:$VERSION
