// ============================================================================
// A module to deploy Cosmos DB
// ============================================================================
//
// Author: Nho Luong 
// Skill: DevOps Engineer Lead
//

param name string = resourceGroup().name
param location string = resourceGroup().location

// Remove for resources that DONT need unique names
param suffix string = '-${substring(uniqueString(resourceGroup().name), 0, 5)}'

// ===== Variables ============================================================

// ===== Modules & Resources ==================================================

// ===== Outputs ==============================================================

//output resourceId string = foo.id
