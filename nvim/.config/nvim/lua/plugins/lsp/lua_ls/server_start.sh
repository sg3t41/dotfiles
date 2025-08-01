#!/bin/bash
set -e

# Build the docker image
docker build -t lua-language-server .

# Stop and remove the existing container if it exists
if [ "$(docker ps -q -f name=lua-language-server-container)" ]; then
	docker stop lua-language-server-container
fi
if [ "$(docker ps -aq -f name=lua-language-server-container)" ]; then
	docker rm lua-language-server-container
fi

# Run the docker container
docker run -d --restart always -p 8888:8888 --name lua-language-server-container lua-language-server
