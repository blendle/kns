#!/bin/sh
# ktx preview window helper

set -eu

selected=$1

context=$(kubectl config view -o jsonpath="{range .contexts[?(@.name == '${selected}')].context}{@.cluster};{@.user};{@.namespace}{end}")
cluster=$(echo "${context}" | cut -d ';' -f 1)
user=$(echo "${context}" | cut -d ';' -f 2)
namespace=$(echo "${context}" | cut -d ';' -f 3)

server=$(kubectl config view -o jsonpath="{.clusters[?(@.name == '${cluster}')].cluster.server}")

echo "=== ${selected} ==="
echo
echo "Cluster ${cluster};Server ${server};User ${user};Namespace ${namespace};" | tr ';' '\n' | column -t
