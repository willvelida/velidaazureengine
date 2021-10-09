variable "resource_group_name" {
  default = "velidaaks-rg"
}

variable "node_resource_group_name" {
  default = "velidaaksnodepool-rg"
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
  default = "velidapool"
}

variable "acr_name" {
    default = "velidaacr"
}

variable "acr_resource_group_name" {
  default = "velidaacr-rg"
}

variable "log_analytics_name" {
  default = "velidaloganalytics"
}

variable "velida_resource_group" {
  default = "velidaazureengine-rg"
}

