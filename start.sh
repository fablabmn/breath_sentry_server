#!/usr/bin/env bash

set -euo pipefail

usage() {
    echo "Usage:"
    echo "  $0 <site-address> <email> <duckdns-subdomain> <duckdns-token>"
    echo
    echo "Example:"
    echo "  $0 mydomain.com admin@example.com mysubdomain xxxxxxxxxxxxxxxxx"
    exit 1
}

# Check arguments
if [ "$#" -ne 4 ]; then
    echo "Error: invalid number of arguments."
    usage
fi

SITE_ADDRESS="$1"
EMAIL="$2"
DUCKDNS_SUBDOMAIN="$3"
DUCKDNS_TOKEN="$4"

# Detect container runtime
if command -v docker >/dev/null 2>&1 && docker compose version >/dev/null 2>&1; then
    COMPOSE_CMD="docker compose"
elif command -v podman >/dev/null 2>&1 && podman compose version >/dev/null 2>&1; then
    COMPOSE_CMD="podman compose"
else
    echo "Error: neither Docker Compose nor Podman Compose was found."
    echo "Please install Docker or Podman before running this script."
    exit 1
fi

echo "Using container runtime: $COMPOSE_CMD"

echo "Generating .env file..."

cat > .env <<EOF
SITE_ADDRESS=$SITE_ADDRESS
EMAIL=$EMAIL
DUCKDNS_SUBDOMAIN=$DUCKDNS_SUBDOMAIN
DUCKDNS_TOKEN=$DUCKDNS_TOKEN
EOF

echo "Configuration:"
echo "  Site Address     : $SITE_ADDRESS"
echo "  Email            : $EMAIL"
echo "  DuckDNS Subdomain: $DUCKDNS_SUBDOMAIN"
echo

echo "Starting services..."

$COMPOSE_CMD up -d

echo
echo "Installation completed successfully."
