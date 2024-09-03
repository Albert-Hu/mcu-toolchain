#!/usr/bin/env bash

if [ $# -ne 2 ]; then
    echo "Usage: $0 <image-name> <path-to-dockerfile>"
    exit 1
fi

IMAGE_NAME=$1
DOCKERFILE_PATH=$2

# build the docker image
docker build -t $IMAGE_NAME -f $DOCKERFILE_PATH .
