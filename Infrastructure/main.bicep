import * as utd from './userDefinedTypes.bicep'

targetScope = 'subscription'

param cosmosdbs utd.cosmosDb[]
param resourceGroups utd.resourceGroup[]
param storageAccounts utd.storageAccount[]
param serverFarms utd.serverFarm[]
param sites utd.site[]

module rgs 'br/public:avm/res/resources/resource-group:0.4.2' = [for resourceGroup in resourceGroups: {
  name: resourceGroup.name
  params: {
    enableTelemetry: true
    location: resourceGroup.location
    name: resourceGroup.name
    roleAssignments: !empty(resourceGroup.?roleAssignments) ? resourceGroup.?roleAssignments : []
    tags: resourceGroup.tags
  }
}]

module sas 'br/public:avm/res/storage/storage-account:0.28.0' = [for storageAccount in storageAccounts: {
  dependsOn: [ rgs ]
  name: storageAccount.name
  params: {
    accessTier: storageAccount.accessTier
    allowBlobPublicAccess: storageAccount.allowBlobPublicAccess
    allowSharedKeyAccess: storageAccount.allowSharedKeyAccess
    enableTelemetry: true
    kind: storageAccount.kind
    location: storageAccount.location
    minimumTlsVersion: 'TLS1_2'
    name: storageAccount.name
    networkAcls: storageAccount.?networkAcls
    publicNetworkAccess: storageAccount.publicNetworkAccess
    requireInfrastructureEncryption: true
    skuName: storageAccount.skuName
    supportsHttpsTrafficOnly: true
    tags: { name: storageAccount.name }
  }
  scope: az.resourceGroup(storageAccount.resourceGroup)
}]

module cdbs 'br/public:avm/res/document-db/database-account:0.18.0' = [for cosmosdb in cosmosdbs: {
  dependsOn: [ rgs ]
  name: cosmosdb.name
  params: {
    databaseAccountOfferType: 'Standard'
    enableFreeTier: cosmosdb.?enableFreeTier ?? false
    enableTelemetry: true
    location: cosmosdb.location
    name: cosmosdb.name
    sqlDatabases: cosmosdb.?sqlDatabases ?? []
  }
  scope: az.resourceGroup(cosmosdb.resourceGroup)
}]

module csa 'br/public:avm/res/cognitive-services/account:0.13.2' = {
  dependsOn: [ rgs ]
  name: 'cogsvc-vtt-dev-frc-001'
  params: {
    apiProperties: {}
    kind: 'SpeechServices'
    location: 'francecentral'
    name: 'cogsvc-vtt-dev-frc-001'
    sku: 'F0'
  }
  scope: az.resourceGroup('rg-vtt-dev-frc-001')
}

module sfs 'br/public:avm/res/web/serverfarm:0.5.0' = [for serverFarm in serverFarms: {
  dependsOn: [ rgs ]
  name: serverFarm.name
  params: {
    enableTelemetry: true
    name: serverFarm.name
    location: serverFarm.location
    skuName: serverFarm.sku.name
  }
  scope: az.resourceGroup(serverFarm.resourceGroup)
}]

module fas 'br/public:avm/res/web/site:0.19.4' = [for site in sites: {
  dependsOn: [ sfs ]
  name: site.name
  params: {
    enableTelemetry: true
    kind: site.kind
    location: site.location
    name: site.name
    serverFarmResourceId: sfs[0].outputs.resourceId
    siteConfig: !(empty(site.?siteConfig)) ? site.?siteConfig : {}
  }
  scope: az.resourceGroup(site.resourceGroup)
}]
