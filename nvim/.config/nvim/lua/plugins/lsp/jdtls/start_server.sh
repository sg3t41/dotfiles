#!/bin/bash

# Get the directory of this script to use as the build context.
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Build the Docker image
echo "Building the jdtls Docker image..."
docker build -t jdtls-server "$DIR"

# Stop any existing container with the same name
echo "Stopping existing container if running..."
docker stop jdtls-server &> /dev/null || true
docker rm jdtls-server &> /dev/null || true

# Run the Docker container
echo "Starting the jdtls container..."
# ポートを2087で公開し、カレントディレクトリをコンテナの/workspaceにマウントします
docker run --name jdtls-server -d -p 2087:2087 -v "$(pwd)":/workspace jdtls-server

echo "JDTLS server started on port 2087."