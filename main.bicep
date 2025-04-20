// Bicep template to create a Storage Account with various configurations
@description('The name of the storage account')
param storageAccountName string

@description('The storage account location.')
param location string = 'japaneast'

@description('Storage Account type')
@allowed([
  'Standard_LRS'
  'Standard_ZRS'
  'Standard_GRS'
  'Standard_GZRS'
  'Standard_RAGRS'
  'Standard_RAGZRS'
])
param storageAccountType string

@description('Is Hierarchical Namespace Enabled? (true or false)')
@allowed([
  true
  false
])
param isHnsEnabled bool

@description('Storage Account accessTier (HOT or COOL)')
@allowed([
  'Hot'
  'Cool'
])
param accessTier string

@description('deleteRetentionPolicy enabled (true or false)')
@allowed([
  true
  false
])
param deleteRetentionPolicyEnabled bool

@description('deleteRetentionPolicy days')
param deleteRetentionPolicyDays int 

@description('containerDeleteRetentionPolicy enabled (true or false)')
@allowed([
  true
  false
])
param containerDeleteRetentionPolicyEnabled bool

@description('containerDeleteRetentionPolicy days')
param containerDeleteRetentionPolicyDays int 

resource sa 'Microsoft.Storage/storageAccounts@2022-09-01' = {
// The following prameters from input parameters
  name: storageAccountName
  location: location
  sku: {
    name: storageAccountType
  }
  kind: 'StorageV2'
  properties: {
// The following prameters from input parameters
    isHnsEnabled: isHnsEnabled
    accessTier: accessTier
// The following parameters are hardcoded
    dnsEndpointType: 'Standard'
    allowedCopyScope: 'AAD'
    defaultToOAuthAuthentication: false
    publicNetworkAccess: 'Disabled'
    allowCrossTenantReplication: false
    isSftpEnabled: false
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: false
    allowSharedKeyAccess: true
    largeFileSharesState: 'Enabled'
    networkAcls: {
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Deny'
    }
    supportsHttpsTrafficOnly: true
    encryption: {
      requireInfrastructureEncryption: false
      services: {
        file: {
          keyType: 'Account'
          enabled: true
        }
        blob: {
          keyType: 'Account'
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
  }
}

resource sa_blobServices_name_default 'Microsoft.Storage/storageAccounts/blobServices@2024-01-01' = {
  parent: sa
  name: 'default'
  properties: {
    containerDeleteRetentionPolicy: {
// The following prameters from input parameters
      enabled: containerDeleteRetentionPolicyEnabled
      days: containerDeleteRetentionPolicyEnabled ? containerDeleteRetentionPolicyDays : null
    }
    cors: {
      corsRules: []
    }
    deleteRetentionPolicy: {
      allowPermanentDelete: false
// The following prameters from input parameters
      enabled: deleteRetentionPolicyEnabled 
      days: deleteRetentionPolicyEnabled ? deleteRetentionPolicyDays : null
    }
  }
}

resource sa_fileServices_name_default 'Microsoft.Storage/storageAccounts/fileServices@2024-01-01' = {
  parent: sa
  name: 'default'
  properties: {
    protocolSettings: {
      smb: {}
    }
    cors: {
      corsRules: []
    }
    shareDeleteRetentionPolicy: {
      enabled: false
    }
  }
}

resource sa_queueServices_name_default 'Microsoft.Storage/storageAccounts/queueServices@2024-01-01' = {
  parent: sa
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource sa_tableServices_name_default 'Microsoft.Storage/storageAccounts/tableServices@2024-01-01' = {
  parent: sa
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

output storageAccountName string = storageAccountName
output storageAccountId string = sa.id
