FROM alpine:3.14

# Install necessary packages
RUN apk add --no-cache \
    prometheus \
    node_exporter \
    loki \
    promtail \
    supervisor

# Copy configuration files
COPY prometheus.yml /etc/prometheus/prometheus.yml
COPY loki.yml /etc/loki/loki.yml
COPY promtail.yml /etc/promtail/promtail.yml

# Copy run script
COPY run.sh /
RUN chmod a+x /run.sh

# Expose ports
EXPOSE 9090 9100 8086 3100

# Set up supervisord
COPY supervisord.conf /etc/supervisord.conf

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]