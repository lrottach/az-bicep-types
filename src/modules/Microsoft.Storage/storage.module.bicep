//  Creator:        Lukas Rottach
//  Type:           Module
//  Creation Date:  11.09.2023
//  Description:    Create an Azure Storage Account including a subset of file shares

// Deployment Scope
targetScope = 'resourceGroup'

// ----------------------------
// Parameter
// ----------------------------

@allowed([ 'westeurope', 'switzerlandnorth' ])
param deploymentLocation string

param storageName string

@allowed([ 'Premium_LRS', 'Standard_LRS' ])
param storageSku string

@allowed([ 'StorageV2' ])
param storageKind string

@allowed([ 'TLS1_2' ])
param minimumTlsVersion string

@allowed([ 'Enabled', 'Disabled' ])
param largeFileShareState string

param shareName string
@allowed([ 'Hot', 'Cool', 'TransactionOptimized' ])

param shareAccessTier string

//
// Resources
//

// Azure Storage Account
resource storage 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageName
  location: deploymentLocation
  sku: {
    name: storageSku
  }
  kind: storageKind
  properties: {
    minimumTlsVersion: minimumTlsVersion
    largeFileSharesState: largeFileShareState
  }
}

resource fileServices 'Microsoft.Storage/storageAccounts/fileServices@2023-01-01' = {
  name: 'default'
  parent: storage
}

resource share 'Microsoft.Storage/storageAccounts/fileServices/shares@2023-01-01' = {
  name: shareName
  parent: fileServices
  properties: {
    accessTier: shareAccessTier
  }
}
