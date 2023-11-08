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
param deploymentLocation string = 'westeurope'

@description('Name of the resource group to create')
param rgName string = 'rg-demo-types1-we'

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

module storageSolution './modules/lockbox.matrix.module.bicep' = {
  scope: rg
  name: 'depoy-demo-storage'
  params: {
    deploymentLocation: deploymentLocation
    minimumTlsVersion: 'TLS1_2'
    storageKind: 'StorageV2'
    storageName: 'stodemotypes1we'
    storageSku: 'Standard_LRS' 
    publicNetworkAccess: 'Enabled'
  }
}
