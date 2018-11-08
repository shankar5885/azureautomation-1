$keyVaultName = "rabickel-vault2"
$resourceGroupName = "RG01"
$locationName = "North Europe"
$serverName1 = "rabickel-server-01"
$serverName2 = "rabickel-server-02"
$databaseName = "rabickel-db-01"
$databaseUsername = "rabickel-db-01-admin"
$failovergroupname = "rabickel-sql-failover-1"



# Establish Active Geo-Replication
$database = Get-AzureRmSqlDatabase -DatabaseName $databaseName -ResourceGroupName $resourceGroupName -ServerName $serverName1
$database | New-AzureRmSqlDatabaseSecondary -PartnerResourceGroupName $resourceGroupName -PartnerServerName $serverName2 -AllowConnections "All"

# Initiate a planned failover
# $database = Get-AzureRmSqlDatabase -DatabaseName $databasename -ResourceGroupName $resourceGroupName -ServerName $serverName2
# $database | Set-AzureRmSqlDatabaseSecondary -PartnerResourceGroupName $resourceGroupName -Failover

# Monitor Geo-Replication config and health after failover
# $database = Get-AzureRmSqlDatabase -DatabaseName $databasename -ResourceGroupName $resourceGroupName -ServerName $serverName2
# $database | Get-AzureRmSqlDatabaseReplicationLink -PartnerResourceGroupName $resourceGroupName -PartnerServerName $serverName1



$failovergroup = New-AzureRMSqlDatabaseFailoverGroup `
      –ResourceGroupName $resourceGroupName `
      -ServerName $serverName1 `
      -PartnerServerName $serverName2  `
      –FailoverGroupName $failovergroupname `
      –FailoverPolicy Automatic `
      -GracePeriodWithDataLossHours 2

Add-AzureRmSqlDatabaseToFailoverGroup  -Database $database -ResourceGroupName $resourceGroupName -ServerName $serverName1 -FailoverGroupName $failovergroupname