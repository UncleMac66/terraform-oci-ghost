#!/bin/bash
# Cloud-init script for Ubuntu to install Docker and run Ghost

set -e

# in case there's a dns resolve error
sudo systemctl restart systemd-resolved

sleep 10

# Update and install prerequisites
apt-get update -y
apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Add Docker’s official GPG key & repo
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

systemctl enable --now docker

# Add ubuntu user to docker group
if id ubuntu &>/dev/null; then
  usermod -aG docker ubuntu
fi

# Open ports if ufw is active
if systemctl is-active ufw &>/dev/null && ufw status | grep -q active; then
  ufw allow 22/tcp
  ufw allow 443/tcp
  ufw allow 80/tcp
  ufw enable
  ufw reload
fi

install-caddy.sh

mkdir ~/ghost
cp docker-compose.yml ~/ghost
cp install-caddy.sh ~/ghost
cp ghost-init.sh ~/ghost
cd ~/ghost

docker compose up -d 
