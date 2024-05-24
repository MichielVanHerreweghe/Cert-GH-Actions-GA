using '../main.bicep'

// General parameters
param projectName = 'CloudTravel'
param location = 'westeurope'
param locationShortName = 'weu'
param environment = 'dev'

// Container App Environment parameters

// Frontend - Container App parameters
param frontendScaleMinReplicas = 1
param frontendScaleMaxReplicas = 1
param frontendCpu = '1'
param frontendMemory = '1Gi'
param defaultImage = 'nginx:latest'
