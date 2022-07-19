terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.12.0"
    }
  }
    required_version = ">= 1.0.10"
}
  provider "azurerm" {
  features {}
}
resource "azurerm_resource_group" "aksdemo" {
  name     = var.resource_group_name
  location = var.region_name
}
resource "azurerm_virtual_network" "aksdemo" {
  name                = "east-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.aksdemo.location
  resource_group_name = azurerm_resource_group.aksdemo.name
}
resource "azurerm_subnet" "aksdemo" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.aksdemo.name
  virtual_network_name = azurerm_virtual_network.aksdemo.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_container_registry" "acr" {
  name                = var.ACR_name
  resource_group_name = azurerm_resource_group.aksdemo.name
  location            = azurerm_resource_group.aksdemo.location
  sku                 = "Premium"
  admin_enabled       = false
  
}

resource "azurerm_kubernetes_cluster" "aksdemo" {
  name                = "kube1"
  location            = azurerm_resource_group.aksdemo.location
  resource_group_name = azurerm_resource_group.aksdemo.name
  dns_prefix          = "aksdemo"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.aksdemo.kube_config.0.client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.aksdemo.kube_config_raw

  sensitive = true
}

resource "azurerm_mysql_server" "aksdemo" {
  name                = "aks-mysqlserver"
  location            = azurerm_resource_group.aksdemo.location
  resource_group_name = azurerm_resource_group.aksdemo.name

  administrator_login          = "delacct"
  administrator_login_password = "H@Sh1CoR3!"

  sku_name   = "GP_Gen5_2"
  storage_mb = 5120
  version    = "5.7"

  auto_grow_enabled                 = true
  backup_retention_days             = 7
  geo_redundant_backup_enabled      = true
  infrastructure_encryption_enabled = true
  public_network_access_enabled     = false
  ssl_enforcement_enabled           = true
  ssl_minimal_tls_version_enforced  = "TLS1_2"
}

resource "azurerm_mysql_database" "example" {
  name                = "hplus"
  resource_group_name = azurerm_resource_group.aksdemo.name
  server_name         = azurerm_mysql_server.aksdemo.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}
