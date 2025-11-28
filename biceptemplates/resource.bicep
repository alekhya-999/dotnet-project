targetScope = 'resourceGroup'

@description('Name of the App Service Plan')
param appServicePlanName string

@description('Name of the Web App')
param webAppName string

@description('Location')
param location string

@description('App Service Plan SKU')
param skuName string = 'B1'

// Windows App Service Plan
resource appServicePlan 'Microsoft.Web/serverfarms@2023-12-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: 'B1'
    tier: 'Basic'
    size: skuName
    capacity: 1
  }
  kind: 'app'
}

// Windows Web App
resource webApp 'Microsoft.Web/sites@2023-12-01' = {
  name: webAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      netFrameworkVersion: 'v8.0'
      alwaysOn: true
    }
  }
}
