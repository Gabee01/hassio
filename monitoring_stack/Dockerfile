FROM alpine:3.14

# Install necessary packages
RUN apk add --no-cache curl supervisor

# Install Prometheus
RUN curl -LO https://github.com/prometheus/prometheus/releases/download/v2.37.0/prometheus-2.37.0.linux-amd64.tar.gz && \
    tar xvfz prometheus-2.37.0.linux-amd64.tar.gz && \
    mv prometheus-2.37.0.linux-amd64/prometheus /usr/local/bin/ && \
    mv prometheus-2.37.0.linux-amd64/promtool /usr/local/bin/ && \
    mkdir /etc/prometheus && \
    mv prometheus-2.37.0.linux-amd64/prometheus.yml /etc/prometheus/ && \
    rm -rf prometheus-2.37.0.linux-amd64 prometheus-2.37.0.linux-amd64.tar.gz

# Install Loki
RUN curl -LO https://github.com/grafana/loki/releases/download/v2.5.0/loki-linux-amd64.zip && \
    unzip loki-linux-amd64.zip && \
    mv loki-linux-amd64 /usr/local/bin/loki && \
    rm loki-linux-amd64.zip

# Install Promtail
RUN curl -LO https://github.com/grafana/loki/releases/download/v2.5.0/promtail-linux-amd64.zip && \
    unzip promtail-linux-amd64.zip && \
    mv promtail-linux-amd64 /usr/local/bin/promtail && \
    rm promtail-linux-amd64.zip

# Copy configuration files
COPY prometheus.yml /etc/prometheus/prometheus.yml
COPY loki.yml /etc/loki/loki.yml
COPY promtail.yml /etc/promtail/promtail.yml

# Copy run script
COPY run.sh /
RUN chmod a+x /run.sh

# Expose ports
EXPOSE 9090 3100

# Set up supervisord
COPY supervisord.conf /etc/supervisord.conf

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]