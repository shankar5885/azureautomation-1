$keyVaultName = "vault1"
$resourceGroupName = "RG01"
$locationName = "Central US"

$vault = Get-AzureRmKeyVault -Name $keyVaultName -ErrorVariable notPresent -ErrorAction SilentlyContinue
if ($notPresent)
{
    # ResourceGroup doesn't exist
    $vault = New-AzureRmKeyVault -Name '$keyVaultName -ResourceGroupName $resourceGroupName -Location $locationName
}

