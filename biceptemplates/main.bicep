targetScope = 'subscription'

param rgName string
param location string = 'eastus'
param appServicePlanName string
param webAppName string

// Create Resource Group
resource rg 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: rgName
  location: location
}

// Deploy Windows Web App into that RG
module webAppMod 'resource.bicep' = {
  name: 'deployWindowsWebApp'
  scope: rg
  params: {
    appServicePlanName: appServicePlanName
    webAppName: webAppName
    location: location
  }
}
