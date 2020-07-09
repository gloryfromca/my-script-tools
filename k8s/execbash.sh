#!/usr/bin/env zsh

echo "Begin"

app=$1
podname=`kubectl get pods -l app=${app:-web} --field-selector=status.phase=Running -o custom-columns=:metadata.name --no-headers=true | head -n 1`
kubectl exec -it $podname bash

echo "Done"
