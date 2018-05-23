# AWS Location
region                        = "us-east-1"
azs                           = ["us-east-1a", "us-east-1b"]
# VPC
cidr                          = "10.0.0.0/16"
private_subnets               = ["10.0.1.0/24", "10.0.2.0/24"]
public_subnets                = ["10.0.10.0/24", "10.0.20.0/24"]
# Git App
source-repository-owner       = "jonatasrenan"
source-repository-repo        = "docker-ha-examples"
source-repository-branch      = "master"
source-repository-folder      = "terraform"
# App
environment                   = "production"