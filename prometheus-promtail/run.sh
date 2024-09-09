#!/usr/bin/with-contenv bashio

prometheus --config.file=/etc/prometheus/prometheus.yml &
promtail -config.file=/etc/promtail/promtail.yml