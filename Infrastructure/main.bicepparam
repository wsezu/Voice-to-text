using './main.bicep'

param resourceGroups = [
  {
    location: 'francecentral'
    name: 'rg-vtt-dev-frc-001'
    tags: {
      environment: 'dev'
      project: 'voice-to-text'
      owner: 'Serge Zuidinga'
    }
  }
]

param storageAccounts = [
  {
    accessTier: 'Hot'
    allowBlobPublicAccess: false
    allowSharedKeyAccess: true
    kind: 'StorageV2'
    location: 'francecentral'
    name: 'stvttdevfrc001'
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Allow'
    }
    publicNetworkAccess: 'Enabled'
    resourceGroup: resourceGroups[0].name
    skuName: 'Standard_LRS'
  }
]
