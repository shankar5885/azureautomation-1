$keyVaultName = "rabickel-vault2"
$resourceGroupName = "RG01"
$locationName = "West Europe"
$serverName = "rabickel-server-02"
$databaseName = "rabickel-db-02"
$databaseUsername = "rabickel-db-01-admin"


$server = Get-AzureRmSqlServer -ServerName $serverName -ResourceGroupName $resourceGroupName -ErrorVariable notPresent -ErrorAction SilentlyContinue
if ($notPresent)
{
    #Load "System.Web" assembly in PowerShell console 
    [Reflection.Assembly]::LoadWithPartialName("System.Web")
    #Calling GeneratePassword Method 
    $pwd = [System.Web.Security.Membership]::GeneratePassword(12,0)
    $secpasswd = ConvertTo-SecureString $pwd -AsPlainText -Force
    $credentials = New-Object System.Management.Automation.PSCredential ($databaseUsername, $secpasswd)
    $server = New-AzureRmSqlServer -ServerName $serverName -ResourceGroupName $resourceGroupName -Location $locationName -SqlAdministratorCredentials $credentials
}

$database = Get-AzureRmSqlDatabase -ServerName $serverName -DatabaseName $databaseName -ResourceGroupName $resourceGroupName -ErrorVariable dbNotPresent -ErrorAction SilentlyContinue
if ($dbNotPresent)
{
    $database = New-AzureRmSqlDatabase -DatabaseName $databaseName -ServerName $serverName -ResourceGroupName $resourceGroupName -RequestedServiceObjectiveName "S0"
}