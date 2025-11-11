import * as utd from './userDefinedTypes.bicep'

targetScope = 'subscription'

param resourceGroups utd.resourceGroup[]
param storageAccounts utd.storageAccount[]

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
  }
  scope: az.resourceGroup(storageAccount.resourceGroup)
}]
