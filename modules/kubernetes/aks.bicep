// ============================================================================
// A module to deploy AKS cluster into a VNet with system assigned identity
// ============================================================================
//
// Author: Nho Luong 
// Skill: DevOps Engineer Lead
//

param name string = resourceGroup().name
param location string = resourceGroup().location

@description('Name of the VNet to deploy the AKS cluster into')
param netVnet string

@description('Name of subnet in the VNet')
param netSubnet string

// Leave empty to disable monitoring add on
@description('OPTIONAL: Provide a workspace ID to enable monitoring add on')
param logsWorkspaceId string = ''

@description('Cluster configuration, version, size and other details')
param config object = {
  version: '1.23.5'
  nodeSize: 'Standard_DS2_v2'
  nodeCount: 2
  nodeCountMax: 10
  maxPodsPerNode: 30
  enableOIDC: false
}

// Optional to BYO identity for the cluster
@description('OPTIONAL: Provide a MI to assign to the AKS cluster')
param clusterIdentity string = ''

// Optional to BYO identity for the kubelet (used for ACR inegration)
@description('OPTIONAL: Provide a MI to assign to the kubelet & nodes')
param kubeletIdentity object = {
  resourceId: ''
  clientId: ''
  objectId: ''
}

// ===== Variables ============================================================

var addOns = {
  // Enable monitoring add on, only if logsWorkspaceId is set
  omsagent: logsWorkspaceId != '' ? {
    enabled: true
    config: {
      logAnalyticsWorkspaceResourceID: logsWorkspaceId
    }
  } : {}
}

// Kubelet identity is used by the nodes, mainly to access ACR
var identityProfile = kubeletIdentity.resourceId != '' ? {
  kubeletidentity: kubeletIdentity
} : {}

// Cluster identity is used by the cluster, e.g. to create/update load balancers
var identityConfig = clusterIdentity != '' ? {
  type: 'UserAssigned'
  userAssignedIdentities: {
    '${clusterIdentity}': {}
  }
} : {
  type: 'SystemAssigned'
}

// ===== Modules & Resources ==================================================

resource aks 'Microsoft.ContainerService/managedClusters@2022-09-01' = {
  name: name
  location: location

  identity: identityConfig

  properties: {
    dnsPrefix: name
    kubernetesVersion: config.version

    oidcIssuerProfile: {
      enabled: config.enableOIDC
    }

    agentPoolProfiles: [
      {
        name: 'default'
        mode: 'System'
        vnetSubnetID: resourceId('Microsoft.Network/virtualNetworks/subnets', netVnet, netSubnet)
        vmSize: config.nodeSize
        enableAutoScaling: true
        count: config.nodeCount
        minCount: config.nodeCount
        maxCount: config.nodeCountMax
        maxPods: config.maxPodsPerNode
      }
    ]

    // Enable advanced networking and policy
    networkProfile: {
      networkPlugin: 'azure'
      networkPolicy: 'azure'
    }

    // Add ons are configured above, as a conditional variable object
    addonProfiles: addOns

    identityProfile: identityProfile
  }
}

// ===== Outputs ==============================================================

output clusterName string = aks.name
output clusterFQDN string = aks.properties.fqdn
output provisioningState string = aks.properties.provisioningState
