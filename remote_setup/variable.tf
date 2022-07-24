variable "location" {
  type    = string
  default = "eastus"
}

variable "naming_prefix" {
  type    = string
  default = "aks-git"
}

variable "github_repository" {
  type    = string
  default = "aks-github-actions"
}
