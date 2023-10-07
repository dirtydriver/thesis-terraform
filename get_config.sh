#!/bin/sh

CLUSTER_ID=$(terraform output cluster-id)
curl -X GET \
-H "Content-Type: application/json" \
-H "Authorization: Bearer ${TF_VAR_do_token}" \
"https://api.digitalocean.com/v2/kubernetes/clusters/$CLUSTER_ID/kubeconfig" \
> config
