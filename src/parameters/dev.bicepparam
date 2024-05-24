using '../main.bicep'

// General parameters
param projectName = 'CloudTravel'
param location = 'westeurope'
param locationShortName = 'weu'
param environment = 'dev'

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
