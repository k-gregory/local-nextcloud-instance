#!/usr/bin/env sh

APACHE_CONTAINER="nextcloud-apache2-1"

# Exit if containers already exist
for c in "$APACHE_CONTAINER"; do
    if docker ps -a --format '{{.Names}}' | grep -q "^$c$"; then
        echo "Container $c already exists. Exiting."
        #exit 0
    fi
done

# Build images
docker build -t nextcloud-php-fpm -f docker/php-fpm.Dockerfile docker
docker build -t nextcloud-nginx -f docker/nginx.Dockerfile docker
docker build -t nextcloud-apache2 -f docker/apache2.Dockerfile docker

# Run Apache2
docker run -d \
  --name "$APACHE_CONTAINER" \
  --restart unless-stopped \
  -p 8080:8080 \
  -p 8000:80 \
  nextcloud-apache2

echo "Apache2 container created and running."