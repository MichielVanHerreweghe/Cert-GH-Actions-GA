targetScope = 'subscription'

/* Parameters */

// General parameters
param projectName string
param location string
param locationShortName string
param environment string

// Container App Environment parameters

// Frontend - Container App parameters
param frontendScaleMinReplicas int
param frontendScaleMaxReplicas int
param frontendCpu string
param frontendMemory string
param defaultImage string = 'nginx:latest'

/* Variables */
var resourceGroupName = 'rg-${toLower(projectName)}-${toLower(environment)}-${toLower(locationShortName)}'

/* Resources */
resource resourceGroup 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: resourceGroupName
  location: location
}

// TODO: Check with two CAEs
module containerResources './modules/containerApp.bicep' = {
  scope: resourceGroup
  name: 'frontend-containerresources-deployment'
  params: {
    projectName: projectName
    location: location
    locationShortName: locationShortName
    environment: environment
    applicationType: 'frontend'
    scaleMinReplicas: frontendScaleMinReplicas
    scaleMaxReplicas: frontendScaleMaxReplicas
    cpu: frontendCpu
    memory: frontendMemory
    defaultImage: defaultImage
  }
}
