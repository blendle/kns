#!/bin/sh
# ktx preview window helper

set -eu

selected=$1

declare -a context=($(kubectl config view -o jsonpath="{range .contexts[?(@.name == '${selected}')].context}{@.cluster} {@.user} {@.namespace} {end}"))

if [ ${#context[@]} -eq 0 ];
then
  echo "Context not found"
  exit 1
fi

cluster=${context[0]}
user=${context[1]}

if [ ${#context[@]} -gt 2 ]; then
  namespace=${context[2]}
else
  namespace="none"
fi

server=$(kubectl config view -o jsonpath="{.clusters[?(@.name == '${cluster}')].cluster.server}")

echo "=== ${selected} ===\n"
echo "Cluster ${cluster};Server ${server};User ${user};Namespace ${namespace};" | tr ';' "\n" | column -t