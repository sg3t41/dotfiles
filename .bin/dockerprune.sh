#!/bin/bash

docker system prune -f > /dev/null
docker container prune -f > /dev/null

CONTAINERS=$(docker ps -a -q)
if [ -n "$CONTAINERS" ]; then
    docker rm -f $CONTAINERS > /dev/null 2>&1
fi

docker image prune -f > /dev/null

IMAGES=$(docker images -a -q)
if [ -n "$IMAGES" ]; then
    docker rmi -f $IMAGES > /dev/null 2>&1
fi

docker volume prune -f > /dev/null
docker network prune -f > /dev/null
docker builder prune -f > /dev/null
