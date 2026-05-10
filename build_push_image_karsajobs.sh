#!/bin/bash

# Build the Docker image
docker build -t karsajobs:latest .

# Tag the image for pushing to Github Package
docker tag karsajobs:latest ghcr.io/szuryuu/a433-microservices/karsajobs:latest

# login to GHCR registry.
echo $CR_PAT | docker login ghcr.io -u szuryuu --password-stdin

# push image to GHCR.
docker push ghcr.io/szuryuu/a433-microservices/karsajobs:latest
