provider "aws" {
  region = "${var.region}"
}

module "vpc" {
  source              = "terraform-aws-modules/vpc/aws"
  name                = "network"
  cidr                = "${var.cidr}"
  azs                 = "${var.azs}"
  private_subnets     = "${var.private_subnets}"
  public_subnets      = "${var.public_subnets}"
  enable_nat_gateway  = true
  single_nat_gateway  = true
  tags = {
    Owner             = "user"
    Environment       = "${var.environment}"
  }
}

module "ecs" {
  source              = "./modules/ecs"
  environment         = "production"
  vpc_id              = "${module.vpc.vpc_id}"
  availability_zones  = "${var.azs}"
  repository_name     = "devopschallenge/production"
  subnets_ids         = ["${module.vpc.private_subnets}"]
  public_subnet_ids   = ["${module.vpc.public_subnets}"]
  security_groups_ids = ["${module.vpc.default_security_group_id}"]
}

module "codepipeline" {
  source                      = "./modules/codepipeline"
  repository_url              = "${module.ecs.repository_url}"
  region                      = "${var.region}"
  ecs_service_name            = "${module.ecs.service_name}"
  ecs_cluster_name            = "${module.ecs.cluster_name}"
  run_task_subnet_id          = "${module.vpc.private_subnets[0]}"
  run_task_security_group_ids = [
    "${module.vpc.default_security_group_id}",
    "${module.ecs.security_group_id}"
  ]
  source-repository-owner      = "${var.source-repository-owner}"
  source-repository-repo       = "${var.source-repository-repo}"
  source-repository-branch     = "${var.source-repository-branch}"
  source-repository-folder     = "${var.source-repository-folder}"
}
