// ------------------------------------------------------------------------------------
//  Creator:        Lukas Rottach
//  Type:           Main
//  Creation Date:  01.11.2023
//  Description:    Create an Azure Storage Account including a subset of file shares
// ------------------------------------------------------------------------------------

// Deployment Scope
targetScope = 'subscription'


// ----------------------------
// Parameter
// ----------------------------

@allowed(['westeurope', 'switzerlandnorth'])
param deploymentLocation string

param rgName string

// ----------------------------
// Resource
// ----------------------------

resource rg 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: rgName
  location: deploymentLocation
}

// ----------------------------
// Modules
// ----------------------------

module storageSolution './modules/Microsoft.Storage/storage.module.bicep' = {
  scope: rg
  name: 'depoy-demo-storage'
  params: {
    deploymentLocation: deploymentLocation
    largeFileShareState: 'Enabled'
    minimumTlsVersion: 'TLS1_2'
    shareAccessTier: 'Cool'
    shareName: 'share1'
    storageKind: 'StorageV2'
    storageName: 'storage1dcodemo200'
    storageSku: 'Standard_LRS'
  }
}
