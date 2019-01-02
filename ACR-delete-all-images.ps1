# WARNING! This script deletes data!
# Run only if you do not have systems
# that pull images via manifest digest.

# Change to '$TRUE' to enable image delete
$enableDelete = $TRUE

# Modify for your environment
$registry = "nooksandcrannies"
$repository = "lognook"

if ($enableDelete) {
    az acr repository show-manifests --name $registry --repository $repository --query "[?*].digest" -o tsv `
    | %{ az acr repository delete --name $registry --image $repository@$_ --yes }
} else {
    Write-Host "No data deleted. Set `$enableDelete = `$TRUE to enable image deletion."
}