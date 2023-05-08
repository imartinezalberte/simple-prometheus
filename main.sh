#!/bin/bash

absolute_path=$(readlink -f "$0")
script_path=$(dirname "$absolute_path")

PROMETHEUS_VERSION=${1:-"prometheus-2.43.0.linux-amd64"}
PROMETHEUS_VERSION_NUMBER=$(echo ${PROMETHEUS_VERSION%.*} | cut -f2 -d'-')
PROMETHEUS_COMPRESSION=".tar.gz"
PROMETHEUS_PATH=${script_path}/${PROMETHEUS_VERSION}

# Install Prometheus on local
if ! [[ -d "${PROMETHEUS_PATH}" ]]; then
  wget https://github.com/prometheus/prometheus/releases/download/v${PROMETHEUS_VERSION_NUMBER}/${PROMETHEUS_VERSION}.tar.gz -O ${PROMETHEUS_PATH}${PROMETHEUS_COMPRESSION} && \
    tar -xvzf ${PROMETHEUS_PATH}${PROMETHEUS_COMPRESSION} && \
    rm -rf ${PROMETHEUS_PATH}${PROMETHEUS_COMPRESSION}
fi

cd ${PROMETHEUS_PATH} && ./prometheus --config.file="${script_path}/prometheus.yml"

