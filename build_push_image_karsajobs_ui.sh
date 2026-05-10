#!/bin/bash

# Build the Docker image
docker build -t karsajobs-ui:latest .

# Tag the image for pushing to Github Package
docker tag karsajobs-ui:latest ghcr.io/szuryuu/a433-microservices/karsajobs-ui:latest

# login to GHCR registry.
echo $CR_PAT | docker login ghcr.io -u szuryuu --password-stdin

# push image to GHCR.
docker push ghcr.io/szuryuu/a433-microservices/karsajobs-ui:latest
