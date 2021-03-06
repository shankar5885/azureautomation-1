$keyVaultName = "rabickel-vault2"
$resourceGroupName = "RG01"
$locationName = "Central US"
$resourceName = "restosave"

$vault = Get-AzureRmKeyVault -Name $keyVaultName -ErrorVariable notPresent -ErrorAction SilentlyContinue
if (!$vault.VaultName)
{
   $vault = New-AzureRmKeyVault -Name $keyVaultName -ResourceGroupName $resourceGroupName -Location $locationName
}

#Load "System.Web" assembly in PowerShell console 
[Reflection.Assembly]::LoadWithPartialName("System.Web")
#Calling GeneratePassword Method 
$pwd = [System.Web.Security.Membership]::GeneratePassword(32,0)

$secretvalue = ConvertTo-SecureString $pwd -AsPlainText -Force
Set-AzureKeyVaultSecret -VaultName $keyVaultName -Name $resourceName -SecretValue $secretvalue

return $vault
#(Get-AzureKeyVaultSecret -vaultName $keyVaultName -name $resourceName).SecretValueText