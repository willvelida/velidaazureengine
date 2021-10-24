terraform {
    required_providers {
      azurerm = {
        source = "hashicorp/azurerm"
        version = "~>2.0"
      }
    }
    backend "azure" {
      resource_group_name = "velidarg"
      storage_account_name = "velidaterraform"
      container_name = "velidaakstfstate"
      key = "terraform.tfstate"
    }
}

provider "azurerm" {
  features {}
}

module "resource_group" {
    source = "../../modules/resource_group"
    resource_group_name = var.resource_group_name
    resource_group_location = var.resource_group_location
    resource_group_tags = {
        "Terraform" = "true"
        "Resource-Specific" = "true"
    }  
}

data "azurerm_container_registry" "acr" {
  name = var.acr_name
  resource_group_name = var.acr_resource_group_name
}

data "azurerm_log_analytics_workspace" "loganalytics" {
  name = var.log_analytics_name
  resource_group_name = var.velida_resource_group
}

resource "azurerm_log_analytics_solution" "containerinsights" {
  solution_name = "ContainerInsights"
  location = data.azurerm_log_analytics_workspace.loganalytics.location
  resource_group_name = data.azurerm_log_analytics_workspace.loganalytics.resource_group_name
  workspace_resource_id = data.azurerm_log_analytics_workspace.loganalytics.id
  workspace_name = data.azurerm_log_analytics_workspace.loganalytics.name

  plan {
    publisher = "Microsoft"
    product = "OMSGallery/ContainerInsights"
  }
}

resource "azurerm_kubernetes_cluster" "cluster" {
  name = var.velida_k8s_cluster_name
  location = module.resource_group.location
  resource_group_name = module.resource_group.name
  dns_prefix = var.velida_k8s_dns_prefix
  node_resource_group = "nodegroup-rg"
  automatic_channel_upgrade = "stable" 

  default_node_pool {
    name = var.velida_k8s_node_pool_name
    vm_size = "Standard_B2s"
    node_count = 3
  }

  identity {
    type = "SystemAssigned"
  }

  role_based_access_control {
    enabled = true
  }

  addon_profile {
    oms_agent {
      enabled = true
      log_analytics_workspace_id = data.azurerm_log_analytics_workspace.loganalytics.id
    }
    http_application_routing {
      enabled = true
    }
  }

  tags = {
    "Environment" = "Production"
  }
}

resource "azurerm_role_assignment" "kubweb_to_acr" {
  scope = data.azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id = azurerm_kubernetes_cluster.cluster.kubelet_identity[0].object_id
}