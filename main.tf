# https://github.com/kawsark/azure-terraform-workshop/tree/master/challenges/03-azurevm

provider "azurerm" {
  version = "= 1.4"
}

terraform {
  required_version = ">=0.11.7"
}

variable "name" {
  default = "jray"
}

variable "location" {
  default = "eastus"
}

resource "azurerm_resource_group" "main" {
  name     = "${var.name}-rg"
  location = "${var.location}"
}

resource "azurerm_virtual_network" "main" {
  name                = "${var.name}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = "${azurerm_resource_group.main.location}"
  resource_group_name = "${azurerm_resource_group.main.name}"
}

resource "azurerm_subnet" "main" {
  name                 = "${var.name}-subnet"
  resource_group_name  = "${azurerm_resource_group.main.name}"
  virtual_network_name = "${azurerm_virtual_network.main.name}"
  address_prefix       = "10.0.1.0/24"
}
