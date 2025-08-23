FROM debian:trixie

# Install system upates, neccessities
RUN apt update && \
    apt install -y sudo inetutils-ping python3

# Install Apache2
RUN apt install -y apache2 && \
    rm -rf /var/lib/apt/lists/*

# Prepare ansible environment
# Create ansible user
RUN useradd -m -s /bin/bash ansible && usermod -aG sudo ansible
# Configure sudo
COPY ansible-nopasswd /etc/sudoers.d/ansible
RUN chmod 440 /etc/sudoers.d/ansible


EXPOSE 8080
# Run Apache in the foreground
CMD ["apache2ctl", "-D", "FOREGROUND"]
