using '../main.bicep'

// General parameters
param projectName = 'CloudTravel'
param location = 'northeurope'
param locationShortName = 'neu'
param environment = 'stg'

// Container App Environment parameters

// Container App parameters
param containerAppConfigurations = [
  {
    applicationType: 'frontend'
    scaleMinReplicas: 1
    scaleMaxReplicas: 1
    cpu: '1'
    memory: '2Gi'
    defaultImage: 'nginx-latest' 
  }
  {
    applicationType: 'backend'
    scaleMinReplicas: 1
    scaleMaxReplicas: 3
    cpu: '1'
    memory: '2Gi'
    defaultImage: 'nginx-latest' 
  }
]
