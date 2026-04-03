#!/bin/bash

# Find and delete all non-running pods in the astroshop namespace

set -euo pipefail

NAMESPACE="astroshop"

echo "Searching for non-running pods in namespace '$NAMESPACE'..."

NON_RUNNING_PODS=$(sudo kubectl get pods --namespace "$NAMESPACE" --field-selector='status.phase!=Running' --no-headers 2>/dev/null | awk '{print $1}')

if [[ -z "$NON_RUNNING_PODS" ]]; then
  echo "No non-running pods found."
  exit 0
fi

echo "The following non-running pods will be deleted:"
echo "$NON_RUNNING_PODS"
echo ""

while IFS= read -r POD; do
  echo "Deleting pod '$POD' in namespace '$NAMESPACE'..."
  sudo kubectl delete pod "$POD" --namespace "$NAMESPACE" --grace-period=0 --force
done <<< "$NON_RUNNING_PODS"

echo ""
echo "Done. All non-running pods have been deleted."
