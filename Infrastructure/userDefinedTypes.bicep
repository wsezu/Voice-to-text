@export()
type cosmosDb = {
  enableFreeTier: bool?
  location: string
  name: string
  sqlDatabases: [
    {
      containers: [
        {
          kind: 'Hash' | 'MultiHash'?
          name: string
          paths: array
        }
      ]?
      name: string
    }
  ]?
  resourceGroup: string
}

@export()
type site = {
  kind: 'api' | 'app' | 'app,container,windows' | 'app,linux' | 'app,linux,container' | 'functionapp' | 'functionapp,linux' | 'functionapp,linux,container' | 'functionapp,linux,container,azurecontainerapps' | 'functionapp,workflowapp' | 'functionapp,workflowapp,linux' | 'linux,api'
  location: string
  name: string
  serverFarmResourceId: string?
  siteConfig: {
    appSettings: array?
  }?
  resourceGroup: string
}

@export()
type resourceGroup = {
  location: string
  name: string
  roleAssignments: array?
  tags: object
}

@export()
type serverFarm = {
  location: string
  name: string
  resourceGroup: string
  sku: {
    name: string
  }
}

@export()
type storageAccount = {
  accessTier: 'Cold' | 'Cool' | 'Hot' | 'Premium'
  allowBlobPublicAccess: bool
  allowSharedKeyAccess: bool
  kind: 'BlobStorage' | 'BlockBlobStorage' | 'FileStorage' | 'Storage' | 'StorageV2'
  location: string
  name: string
  networkAcls: {
    bypass: 'AzureServices' | 'AzureServices, Logging' | 'AzureServices, Logging, Metrics' | 'AzureServices, Metrics' | 'Logging' | 'Logging, Metrics' | 'Metrics' | 'None'
    defaultAction: 'Allow' | 'Deny'
  }?
  publicNetworkAccess: 'Disabled' | 'Enabled'
  resourceGroup: string
  skuName: 'Premium_LRS' | 'Premium_ZRS' | 'PremiumV2_LRS' | 'PremiumV2_ZRS' | 'Standard_GRS' | 'Standard_GZRS' | 'Standard_LRS' | 'Standard_RAGRS' | 'Standard_RAGZRS' | 'Standard_ZRS' | 'StandardV2_GRS' | 'StandardV2_GZRS' | 'StandardV2_LRS' | 'StandardV2_ZRS'
}
