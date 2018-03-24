#!/bin/sh
# ktx preview window helper

set -eu

selected=$1

IFS=';' read -ra context <<< "$(kubectl config view -o jsonpath="{range .contexts[?(@.name == '${selected}')].context}{@.cluster};{@.user};{@.namespace};{end}")"
cluster=${context[0]}
user=${context[1]}
namespace=${context[2]}

server=$(kubectl config view -o jsonpath="{.clusters[?(@.name == '${cluster}')].cluster.server}")

echo "=== ${selected} ===\n"
echo "Cluster ${cluster};Server ${server};User ${user};Namespace ${namespace};" | tr ';' "\n" | column -t