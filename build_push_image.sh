#!/bin/bash

# build Docker image
docker build -t item-app:v1 .

# list local Docker images
docker image ls

# tag image for GHCR.
docker tag item-app:v1 ghcr.io/szuryuu/a433-microservices/item-app:v1

# login to GHCR registry.
echo $CR_PAT | docker login ghcr.io -u szuryuu --password-stdin

# push image to GHCR.
docker push ghcr.io/szuryuu/a433-microservices/item-app:v1
