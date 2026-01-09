#!/bin/bash
set -e

# Installs Caddy web server on Ubuntu (22.04+, modern deb repo configs)

# Ensure apt deps and curl/gpg
sudo apt-get update -y
sudo apt-get install -y curl gpg

# Keyring setup
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://dl.cloudsmith.io/public/caddy/stable/gpg.key | \
  sudo gpg --dearmor -o /etc/apt/keyrings/caddy.gpg
sudo chmod a+r /etc/apt/keyrings/caddy.gpg

# Add Caddy repo (if not already present)
CADDY_SRC="/etc/apt/sources.list.d/caddy-stable.list"
if ! grep -q "dl.cloudsmith.io/public/caddy" "$CADDY_SRC" 2>/dev/null ; then
  echo "deb [signed-by=/etc/apt/keyrings/caddy.gpg] https://dl.cloudsmith.io/public/caddy/stable/deb/debian any-version main" | \
    sudo tee "$CADDY_SRC" > /dev/null
fi

sudo apt-get install -y caddy

echo "Caddy installed!"

# Example minimal Caddyfile:
sudo tee << 'EOF' > /etc/caddy/CaddyFile 

:80 {
  reverse_proxy localhost:2368
}

EOF

sudo systemctl reload caddy