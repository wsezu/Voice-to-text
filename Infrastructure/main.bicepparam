using './main.bicep'

param cosmosdbs = [
  {
    name: 'cosclu-vtt-dev-frc-001'
    location: resourceGroups[0].location
    resourceGroup: resourceGroups[0].name
    enableFreeTier: true
    sqlDatabases: [
      {
        name: 'VoiceToTextDB'
        containers: [
          {
            kind: 'Hash'
            name: 'Metadata'
            paths: [ '/id' ]
          }
        ]
      }
    ]
  }
]

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
    name: 'rcstvttdevfrc001'
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Allow'
    }
    publicNetworkAccess: 'Enabled'
    resourceGroup: resourceGroups[0].name
    skuName: 'Standard_LRS'
  }
]

param serverFarms = [
  {
    name: 'asp-vtt-dev-frc-001'
    location: resourceGroups[0].location
    sku: { name: 'Y1' }
    resourceGroup: resourceGroups[0].name
  }
]

param sites = [
  {
    kind: 'functionapp'
    location: resourceGroups[0].location
    name: 'func-vtt-dev-frc-001'
    resourceGroup: resourceGroups[0].name
  }
]
