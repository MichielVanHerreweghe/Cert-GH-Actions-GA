targetScope = 'resourceGroup'

/* Parameter */

// General parameters
param projectName string
param location string
param locationShortName string
param environment string
param applicationType string

// Container App Environment parameters
param containerAppEnvironmentTags object = { }

// Container App parameters
param scaleMinReplicas int
param scaleMaxReplicas int
param containerAppTags object = { }
param cpu string
param memory string
param defaultImage string = 'nginx:latest'
// TODO: Check if this needs to be an array and if this is needed
param containerAppConfiguration ContainerAppConfiguration[] = []

/* Variables */

var containerAppEnvironmentName = 'cae-${toLower(projectName)}-${toLower(applicationType)}-${toLower(environment)}-${toLower(locationShortName)}'
var containerAppName = 'ca-${toLower(projectName)}-${toLower(applicationType)}-${toLower(environment)}-${toLower(locationShortName)}'

/* Resources */

// Container App Environment
resource containerAppEnvironment 'Microsoft.App/managedEnvironments@2023-11-02-preview' = {
  name: containerAppEnvironmentName
  location: location
  tags: containerAppEnvironmentTags
  properties:{
    
  }
  identity: {
    type: 'SystemAssigned'
  }
}

// Container App
module containerApp 'br/public:avm/res/app/container-app:0.4.0' = {
  name: '${containerAppName}-deployment'
  params: {
    environmentId: containerAppEnvironment.id
    name: containerAppName
    location: location
    scaleMinReplicas: scaleMinReplicas
    scaleMaxReplicas: scaleMaxReplicas
    tags: containerAppTags
    containers: [
      {
        image: containerAppImage(containerAppConfiguration , containerAppName, defaultImage)
        resources: {
          cpu: json(cpu)
          memory: memory
        }
      }
    ]
  }
}

/* Functions */
func containerAppImage(config ContainerAppConfiguration[], name string, defaultImage string) string =>
 !empty(filter(config, x => x.name == name)) ? filter(config, x => x.name == name)[0].image : defaultImage

 /* Types */
type ContainerAppConfiguration = {
  name: string
  image: string
}

/* Outputs */
output containerAppEnvironmentNameSystemAssignedId string = containerAppEnvironment.identity.principalId
