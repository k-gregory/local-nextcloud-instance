FROM debian:trixie

# Install system upates and neccessities
RUN apt update && \      
    apt install -y sudo python3    

# Install nginx
RUN apt install -y nginx inetutils-ping && \
    rm -rf /var/lib/apt/lists/*    

# Prepare ansible environment
# Create ansible user
RUN useradd -m -s /bin/bash ansible && usermod -aG sudo ansible
# Configure sudo
COPY ansible-nopasswd /etc/sudoers.d/ansible
RUN chmod 440 /etc/sudoers.d/ansible

EXPOSE 80

# Start nginx in foreground to keep container alive
CMD ["nginx", "-g", "daemon off;"]
