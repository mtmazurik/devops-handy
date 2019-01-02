#!/bin/bash

# WARNING! This script deletes orphaned images! (not necessarily a bad thing)
#          Orphans occure when a tag gets reused, on a subsequent build (commonly, :latest tag will do this)
# Change to 'true' to enable image delete
ENABLE_DELETE=true

# Modify for your environment
REGISTRY=nooksandcrannies
REPOSITORY=lognook

# Delete all untagged (orphaned) images
if [ "$ENABLE_DELETE" = true ]
then
    az acr repository show-manifests --name $REGISTRY --repository $REPOSITORY --query "[?tags==null].digest" -o table \
    | cut -f 1 -d ' ' | xargs -I% az acr repository delete --name $REGISTRY --image $REPOSITORY@% --yes
else
    echo "No data deleted. Set ENABLE_DELETE=true to enable image deletion."
fi