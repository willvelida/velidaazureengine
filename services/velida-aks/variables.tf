variable "resource_group_name" {
  default = "velidaacr-rg"
}

variable "resource_group_location" {
  default = "australiaeast"
}

variable "velida_k8s_cluster_name" {
    default = "velidaaks"
}

variable "velida_k8s_dns_prefix" {
  default = "velidaaks"
}

variable "velida_k8s_node_pool_name" {
  default = "velidaaksnodepool"
}

