variable "repository_url" {
  description = "The url of the ECR repository"
}

variable "region" {
  description = "The region to use"
}

variable "ecs_cluster_name" {
  description = "The cluster that we will deploy"
}

variable "ecs_service_name" {
  description = "The ECS service that will be deployed"
}

variable "run_task_subnet_id" {
  description = "The subnet Id where single run task will be executed"
}

variable "run_task_security_group_ids" {
  type        = "list"
  description = "The security group Ids attached where the single run task will be executed"
}

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