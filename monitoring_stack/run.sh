#!/usr/bin/with-contenv bashio

# Ensure Docker is running
if ! pgrep -f docker > /dev/null; then
    echo "Docker is not running. Starting Docker..."
    dockerd &
    # Wait for Docker to start
    while ! docker info >/dev/null 2>&1; do
        echo "Waiting for Docker to start..."
        sleep 1
    done
fi

# Start supervisord
exec /usr/bin/supervisord -c /etc/supervisord.conf