

$resourceGroupName = "RG01"
$resourceGroup = Get-AzureRmResourceGroup -Name $resourceGroupName -ErrorVariable notPresent -ErrorAction SilentlyContinue
if ($notPresent)
{
    $resourceGroup = New-AzureRmResourceGroup -Name $resourceGroupName
    #Load "System.Web" assembly in PowerShell console 
}