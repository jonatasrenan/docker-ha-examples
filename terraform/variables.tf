# AWS
variable "region" {
  description = "Região que os recursos serão provisionados"
}
variable "azs" {
  type        = "list"
  description = "Zona de disponibilidades que serão utilizadas"
}

# VPC
variable cidr {
  description = "CIDR"
}
variable private_subnets {
  type        = "list"
  description = "Private Subnets"
}
variable public_subnets {
  type        = "list"
  description = "Public Subnets"
}

# Git App
variable "source-repository-owner" {
  description = "Owner from Source Repository"
}

variable "source-repository-repo" {
  description = "Repository from Source Repository"
}

variable "source-repository-branch" {
  description = "Branch from Source Repository"
}

variable "source-repository-folder" {
  description = "Dockerfile Folder from Source Repository"
}

# App
variable environment {
  description = "Environment"
}
variable "domain" {
  default = "App Domain"
}