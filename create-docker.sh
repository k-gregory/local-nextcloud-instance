#!/usr/bin/env bash
set -e

CONTAINER_NAME="nextcloud-1"
IMAGE_NAME="minimal-nginx"

# 1. Check if container exists (robust)
if docker inspect --format='{{.Name}}' "$CONTAINER_NAME" &>/dev/null; then
    echo "Container '$CONTAINER_NAME' already exists. Exiting."
    exit 0
fi

# 2. Build image
echo "Building Docker image..."
docker build -t $IMAGE_NAME docker

# 3. Run container
echo "Running container..."
docker run -d \
    --name $CONTAINER_NAME \
    -p 8080:80 \
    --restart unless-stopped \
    $IMAGE_NAME

echo "Container '$CONTAINER_NAME' is up on port 8080."
