FROM debian:trixie

# Install PHP-FPM and common extensions
RUN apt-get update && \
    apt-get install -y php8.4-fpm && \
    rm -rf /var/lib/apt/lists/*

# Create ansible user
RUN useradd -m -s /bin/sh ansible

# Expose PHP-FPM TCP port
EXPOSE 9000

# Run PHP-FPM in foreground
CMD ["php-fpm8.4", "-F"]
