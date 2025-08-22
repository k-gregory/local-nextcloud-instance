FROM debian:trixie

# Install system upates, neccessities
RUN apt update && \
    apt install -y sudo python3

# Install PHP-FPM
RUN apt install -y php8.4-fpm && \
    rm -rf /var/lib/apt/lists/*

# Prepare ansible environment
# Create ansible user
RUN useradd -m -s /bin/bash ansible && usermod -aG sudo ansible
# Configure sudo
COPY ansible-nopasswd /etc/sudoers.d/ansible
RUN chmod 440 /etc/sudoers.d/ansible

# Install PHP-FPM
RUN apt install -y php8.4-fpm

# Expose PHP-FPM TCP port
EXPOSE 9000

# Run PHP-FPM in foreground
CMD ["php-fpm8.4", "-F"]
