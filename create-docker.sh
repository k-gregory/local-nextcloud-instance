#!/usr/bin/env sh

PHP_CONTAINER="nextcloud-php-fpm-1"
NGINX_CONTAINER="nextcloud-nginx-1"

# Exit if containers already exist
for c in "$PHP_CONTAINER" "$NGINX_CONTAINER"; do
    if docker ps -a --format '{{.Names}}' | grep -q "^$c$"; then
        echo "Container $c already exists. Exiting."
        #exit 0
    fi
done

# Build images
docker build -t nextcloud-php-fpm -f docker/php-fpm.Dockerfile docker
docker build -t nextcloud-nginx -f docker/nginx.Dockerfile docker

# Commented out because it doesn't work with NixOS/Rootless docker
# Create user-defined network so containers can talk
docker network ls --format '{{.Name}}' | grep -q '^nextcloud-net$' || docker network create nextcloud-net

# Run PHP-FPM container
docker run -d \
  --name "$PHP_CONTAINER" \
  --restart unless-stopped \
 --network nextcloud-net \
  -v nextcloud-data:/var/www/nextcloud \
  nextcloud-php-fpm
# --network nextcloud-net # Commented out because it doesn't work with NixOS/Rootless docker  

# Run Nginx container
docker run -d \
  --name "$NGINX_CONTAINER" \
  --restart unless-stopped \
  -p 80:80 \
  --network nextcloud-net \
  -v nextcloud-data:/var/www/nextcloud:ro \
  nextcloud-nginx
# --network nextcloud-net # Commented out because it doesn't work with NixOS/Rootless docker

echo "PHP-FPM and Nginx containers created and running."