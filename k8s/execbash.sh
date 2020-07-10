#!/usr/bin/env zsh
prefix="k8s exec bash"
echo "$prefix: begin\n"

app=$1
podname=`kubectl get pods -l app=${app:-web} --field-selector=status.phase=Running -o custom-columns=:metadata.name --no-headers=true | head -n 1`
kubectl exec -it $podname bash

echo "$prefix: exit\n"
