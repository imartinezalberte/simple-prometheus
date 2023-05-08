#!/bin/bash

DOCKER_CONTAINER=prometheus
DOCKER_IMAGE=hello-prometheus:0.0.1

docker image build --file ./Dockerfile --tag ${DOCKER_IMAGE} .
docker container run --rm --name ${DOCKER_CONTAINER} -p 8080:8080 --detach ${DOCKER_IMAGE}

