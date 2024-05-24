targetScope = 'subscription'

/* Parameters */

// General parameters
param projectName string
param location string
param locationShortName string
param environment string

// Container App parameters
param containerAppConfigurations containerAppConfiguration[]

/* Variables */
var resourceGroupName = 'rg-${toLower(projectName)}-${toLower(environment)}-${toLower(locationShortName)}'

/* Resources */
resource resourceGroup 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: resourceGroupName
  location: location
}

module containerResources './modules/containerApp.bicep' = [for (containerAppConfiguration, index) in containerAppConfigurations: {
  scope: resourceGroup
  name: '${containerAppConfiguration.applicationType}-containerresources-deployment'
  params: {
    projectName: projectName
    location: location
    locationShortName: locationShortName
    environment: environment
    applicationType: containerAppConfiguration.applicationType
    scaleMinReplicas: containerAppConfiguration.scaleMinReplicas
    scaleMaxReplicas: containerAppConfiguration.scaleMaxReplicas
    cpu: containerAppConfiguration.cpu
    memory: containerAppConfiguration.memory
    defaultImage: containerAppConfiguration.defaultImage
  }
}]

/* Types */
type containerAppConfiguration = {
  @description('The type of the application. Example: webapp, api, etc.')
  applicationType: string
  @description('The minimum number of replicas for the container.')
  scaleMinReplicas: int
  @description('The maxium number of replicas for the container.')
  scaleMaxReplicas: int
  @description('The amount of CPU to allocate to the container. Example: 1, 0.5, etc.')
  cpu: string
  @description('The amount of memory to allocate to the container. Example: 1, 0.5, etc. Should always be 2 times the amount of CPU.')
  memory: string
  @description('The default image to use for the container. Example: nginx, mcr.microsoft.com/azure-app-service/nginx:latest, etc.')
  defaultImage: string
}
