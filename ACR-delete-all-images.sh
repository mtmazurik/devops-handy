#!/bin/bash

# WARNING! This script deletes data!  All images in ACR Repository will be deleted!

# Change to 'true' to enable image delete
ENABLE_DELETE=true

# Modify for your environment
REGISTRY=nooksandcrannies
REPOSITORY=lognook

# Delete all untagged (orphaned) images
if [ "$ENABLE_DELETE" = true ]
then
    az acr repository show-manifests --name $REGISTRY --repository $REPOSITORY  -o tsv \
    | xargs -I% az acr repository delete --name $REGISTRY --image $REPOSITORY@% --yes
else
    echo "No data deleted. Set ENABLE_DELETE=true to enable image deletion."
fi