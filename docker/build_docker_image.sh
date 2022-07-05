#!/bin/bash

# exit immediately on failure, or if an undefined variable is used
set -eux

BASE_TAG="latest"
BASE_IMAGE="rocm/pytorch:$BASE_TAG"

IMAGE_VERSION="v0.1.1"
DOCKER_IMAGE="rocm/fbgemm-private:${BASE_TAG}_${IMAGE_VERSION}"

DOCKER_BUILD_ARGS=" \
  --build-arg BASE_IMAGE=$BASE_IMAGE \
"

DOCKERFILE=Dockerfile

docker build -t $DOCKER_IMAGE -f $DOCKERFILE $DOCKER_BUILD_ARGS .
