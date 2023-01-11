#!/usr/bin/env zsh

# Pull latest image for our needs
if [[ -n "$1" && "$1" = "pull" ]]; then
    #docker pull imperatortheo/rsync-ssh:latest # Alpine with sshpass
    docker pull debian:latest # Debian, installing the rest in Dockerfile
    exit 0
fi

# Regenerate docker build
if [[ -n "$1" && "$1" = "build" ]]; then
    docker build -t rainfall .
    exit 0
fi

# clean up containers
if [[ -n "$1" && "$1" = "delete" ]]; then
    docker container prune -f
    exit 0
fi

# clean up containers and delete the image
if [[ -n "$1" && "$1" = "delete" ]]; then
    docker container prune -f
    docker image rm rainfall:latest
    exit 0
fi

# run docker
if [[ -n "$1" && "$1" = "run" ]]; then
    docker run -it -v $(pwd):/rainfall rainfall zsh
    exit 0
fi

echo "Usage: ./dk.sh {pull | build | clean | delete | run}"
