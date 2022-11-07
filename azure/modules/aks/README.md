# empc-br-terraform-modules - Azure Kubernetes Service

## Create a Kubernetes cluster with Log Analytics and Monitoring

This Terraform module deploys a Kubernetes cluster on [Azure Kubernetes Service](https://azure.microsoft.com/en-us/products/kubernetes-service/) and adds support for monitoring with Log Analytics.

## Usage in Terraform
```hcl
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "empc-test-rg"
  location = "eastus"
}

module "aks" {
  source = "github.com/empc-br/empc-br-terraform-modules/aks"

  prefix                 = "test"
  resource_group_name    = azurerm_resource_group.test.name
  cluster_name           = "aks-cluster-test"
  default_node_pool_name = "default"
  dns_prefix             = "test"
  node_count             = 3

  tags = {
    environment = "test"
    owner       = "empc-br"
  }

  log_analytics_workspace_enabled = true

  depends_on = [azurerm_resource_group.test]
}
```

## Requirements

| Name      | Version  |
|-----------|----------|
| terraform | >=1.3    |
| azurem    | >= 3.0.2 |

## Providers

| Name      | Version  |
|-----------|----------|
| azurem    | >= 3.0.2 |

## Resources
| Name                                                                                                                                     | Type        |
|------------------------------------------------------------------------------------------------------------------------------------------|-------------|
|[azurerm_kubernetes_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster)          | resource    |
|[azurerm_log_analytics_workspace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace)| resource    |
|[azurerm_log_analytics_solution](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_solution)  | resource    |
|[azurerm_resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group)               | data source |

## Inputs
| Name                                        	| Description                                                                                                                                                                                                                                                                                                	| Type                                	| Default           	| Required 	|
|---------------------------------------------	|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	|-------------------------------------	|-------------------	|----------	|
| prefix                                      	| The prefix for the resources created in the specified Azure Resource Group.                                                                                                                                                                                                                                	| string                              	|                   	| Yes      	|
| resource_group_name                         	| The name of resource group to use in AKS.                                                                                                                                                                                                                                                                  	| string                              	|                   	| Yes      	|
| cluster_name                                	| The name of the cluster on AKS.                                                                                                                                                                                                                                                                            	| string                              	|                   	| Yes      	|
| dns_prefix                                  	| DNS prefix specified when creating the managed cluster.                                                                                                                                                                                                                                                    	| string                              	| null              	| No       	|
| kubernetes_version                          	| Version of Kubernetes specified when creating the AKS managed cluster.                                                                                                                                                                                                                                     	| string                              	| null              	| No       	|
| private_cluster_enabled                     	| This provides a Private IP Address for the Kubernetes API on the Virtual Network where the Kubernetes Cluster is located.                                                                                                                                                                                  	| bool                                	| false             	| No       	|
| public_network_access_enabled               	| Whether public network access is allowed for this Kubernetes Cluster.                                                                                                                                                                                                                                      	| bool                                	| true              	| No       	|
| api_server_authorized_ip_ranges             	| The IP ranges to allow for incoming traffic to the server nodes.                                                                                                                                                                                                                                           	| set(string)                         	| null              	| No       	|
| default_node_pool_name                      	| The name which should be used for the default Kubernetes Node Pool.                                                                                                                                                                                                                                        	| string                              	|                   	| Yes      	|
| vm_size                                     	| The size of the Virtual Machine.                                                                                                                                                                                                                                                                           	| string                              	| "Standard_DS2_v2" 	| Yes      	|
| enable_auto_scaling                         	| Should the Kubernetes Auto Scaler be enabled for this Node Pool.                                                                                                                                                                                                                                           	| bool                                	| false             	| No       	|
| max_count                                   	| If enable_auto_scaling is set to true, then the following fields can also be configured. Maximum number of nodes in a pool.                                                                                                                                                                                	| number                              	| null              	| Yes      	|
| min_count                                   	| If enable_auto_scaling is set to true, then the following fields can also be configured. Minimum number of nodes in a pool.                                                                                                                                                                                	| number                              	| null              	| Yes      	|
| node_count                                  	| If enable_auto_scaling is set to true or false, node_count is mandatory. The initial number of nodes which should exist in this Node Pool.                                                                                                                                                                 	| number                              	| 2                 	| Yes      	|
| availability_zones                          	| A list of Availability Zones across which the Node Pool should be spread. Changing this forces a new resource to be created.                                                                                                                                                                               	| list(string)                        	| null              	| No       	|
| enable_host_encryption                      	| Should the nodes in the Default Node Pool have host encryption enabled.                                                                                                                                                                                                                                    	| bool                                	| false             	| No       	|
| enable_node_public_ip                       	| Should nodes in this Node Pool have a Public IP Address? Defaults to false.                                                                                                                                                                                                                                	| bool                                	| false             	| No       	|
| max_pods                                    	| The maximum number of pods that can run on each agent. Changing this forces a new resource to be created.                                                                                                                                                                                                  	| number                              	| null              	| No       	|
| only_critical_addons_enabled                	| Enabling this option will taint default node pool with `CriticalAddonsOnly=true:NoSchedule` taint. Changing this forces a new resource to be created.                                                                                                                                                      	| bool                                	| null              	| No       	|
| ultra_ssd_enabled                           	| Used to specify whether the UltraSSD is enabled in the Default Node Pool. Defaults to false.                                                                                                                                                                                                               	| bool                                	| false             	| No       	|
| vnet_subnet_id                              	| The ID of a Subnet where the Kubernetes Node Pool should exist. Changing this forces a new resource to be created.                                                                                                                                                                                         	| string                              	| null              	| No       	|
| network_plugin                              	| Network plugin to use for networking. Can't be nullable.                                                                                                                                                                                                                                                   	| string                              	| "kubenet"         	| Yes      	|
| network_policy                              	| Sets up network policy to be used with Azure CNI. Network policy allows us to control the traffic flow between pods. Currently supported values are calico and azure. Changing this forces a new resource to be created.                                                                                   	| string                              	| null              	| No       	|
| pod_cidr                                    	| The CIDR to use for pod IP addresses. This field can only be set when network_plugin is set to kubenet. Changing this forces a new resource to be created.                                                                                                                                                 	| string                              	| null              	| No       	|
| docker_bridge_cidr                          	| IP address (in CIDR notation) used as the Docker bridge IP address on nodes. Changing this forces a new resource to be created.                                                                                                                                                                            	| string                              	| null              	| No       	|
| dns_service_ip                              	| IP address within the Kubernetes service address range that will be used by cluster service discovery (kube-dns). Changing this forces a new resource to be created.                                                                                                                                       	| string                              	| null              	| No       	|
| service_cidr                                	| The Network Range used by the Kubernetes service. Changing this forces a new resource to be created.                                                                                                                                                                                                       	| string                              	| null              	| No       	|
| identity_type                               	| The type of identity used for the managed cluster. Conflict with `client_id` and `client_secret`. Possible values are `SystemAssigned`, `UserAssigned`, `SystemAssigned, UserAssigned`(to enable both). If `UserAssigned` or `SystemAssigned, UserAssigned` is set, an `identity_ids` must be set as well. 	| string                              	| "SystemAssigned"  	| No       	|
| tags                                        	| Any tags that should be present on the AKS cluster resources.                                                                                                                                                                                                                                              	| map(string)                         	| {}                	| No       	|
| location                                    	| Location of cluster or log analytics, if not defined it will be read from the resource-group                                                                                                                                                                                                               	| string                              	|                   	| Yes      	|
| cluster_log_analytics_workspace_name        	| The name of the Analytics workspace.                                                                                                                                                                                                                                                                       	| string                              	| null              	| No       	|
| log_analytics_solution_id                   	| Existing azurerm_log_analytics_solution ID. Providing ID disables creation of azurerm_log_analytics_solution.                                                                                                                                                                                              	| string                              	| null              	| No       	|
| log_analytics_workspace                     	| Existing azurerm_log_analytics_workspace to attach azurerm_log_analytics_solution. Providing the config disables creation of azurerm_log_analytics_workspace.                                                                                                                                              	| object({id = string name = string}) 	| null              	| No       	|
| log_analytics_workspace_resource_group_name 	| Resource group name to create azurerm_log_analytics_solution.                                                                                                                                                                                                                                              	| string                              	| null              	| No       	|
| log_analytics_workspace_enabled             	| Enable the integration of azurerm_log_analytics_workspace and azurerm_log_analytics_solution: https://docs.microsoft.com/en-us/azure/azure-monitor/containers/container-insights-onboard                                                                                                                   	| bool                                	| True              	| Yes      	|
| log_analytics_workspace_sku                 	| The SKU (pricing level) of the Log Analytics workspace. For new subscriptions the SKU should be set to PerGB2018.                                                                                                                                                                                          	| string                              	| "PerGB2018"       	| No       	|
| log_retention_in_days                       	| The retention period for the logs in days.                                                                                                                                                                                                                                                                 	| number                              	| 30                	| Yes      	|

## Testing
---
```bash
$ cd ./tests
$ go test -v -timeout 30m aks_test.go
```