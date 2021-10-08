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
    node_count = 1
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    "Environment" = "Production"
  }
}