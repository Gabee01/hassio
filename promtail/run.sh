#!/usr/bin/with-contenv bashio

# Get the configured log level
LOG_LEVEL=$(bashio::config 'log_level')

# Get the Loki URL from the configuration
LOKI_URL=$(bashio::config 'client.url')

# Generate the Promtail configuration file
cat << EOF > /etc/promtail/promtail.yaml
server:
  http_listen_port: 9080
  grpc_listen_port: 0

positions:
  filename: /data/positions.yaml

clients:
  - url: ${LOKI_URL}

scrape_configs:
  - job_name: system
    static_configs:
    - targets:
        - localhost
      labels:
        job: varlogs
        __path__: /var/log/*log
EOF

# Run Promtail with the generated configuration
exec promtail \
    --config.file=/etc/promtail/promtail.yaml \
    --log.level=${LOG_LEVEL}
