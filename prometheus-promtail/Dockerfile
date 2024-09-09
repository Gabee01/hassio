FROM alpine:3.14

# Install necessary packages
RUN apk add --no-cache curl supervisor prometheus

# Install Promtail
RUN curl -LO https://github.com/grafana/loki/releases/download/v2.5.0/promtail-linux-amd64.zip && \
    unzip promtail-linux-amd64.zip && \
    mv promtail-linux-amd64 /usr/local/bin/promtail && \
    rm promtail-linux-amd64.zip

# Copy configuration files
COPY prometheus.yml /etc/prometheus/prometheus.yml
COPY promtail.yml /etc/promtail/promtail.yml
COPY supervisord.conf /etc/supervisord.conf

# Copy run script
COPY run.sh /
RUN chmod a+x /run.sh

# Expose ports
EXPOSE 9090 9080

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]