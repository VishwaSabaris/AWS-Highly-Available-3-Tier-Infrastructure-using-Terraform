provider "aws" {
  region = var.aws_region
}
locals {
  desired_capacity = terraform.workspace == "prod" ? 3 : 1

  min_size = terraform.workspace == "prod" ? 2 : 1

  max_size = terraform.workspace == "prod" ? 5 : 2
}
module "vpc" {
  source = "./modules/vpc"

  vpc_cidr              = var.vpc_cidr
  public_subnet_1_cidr  = var.public_subnet_1_cidr
  public_subnet_2_cidr  = var.public_subnet_2_cidr
  private_subnet_1_cidr = var.private_subnet_1_cidr
  private_subnet_2_cidr = var.private_subnet_2_cidr
}

module "security_group" {
  source = "./modules/security-group"

  sg_name      = "terraform-sg"
  allowed_cidr = ["0.0.0.0/0"]
  vpc_id       = module.vpc.vpc_id
}

module "alb" {
  source = "./modules/alb"

  alb_name          = "terraform-flask-alb"
  security_group_id = module.security_group.security_group_id
  subnet_ids        = module.vpc.public_subnet_ids
  vpc_id            = module.vpc.vpc_id
}

module "asg" {
  source = "./modules/asg"

  ami_id            = var.ami_id
  instance_type     = var.instance_type
  key_name          = var.key_name
  security_group_id = module.security_group.security_group_id
  docker_image      = var.docker_image
  subnet_ids        = module.vpc.private_subnet_ids
  desired_capacity  = local.desired_capacity
  min_size          = local.min_size
  max_size          = local.max_size
  target_group_arn  = module.alb.target_group_arn
}
module "rds" {
  source = "./modules/rds"

  db_name               = var.db_name
  db_username           = var.db_username
  db_password           = var.db_password
  private_subnet_ids    = module.vpc.private_subnet_ids
  vpc_id                = module.vpc.vpc_id
  app_security_group_id = module.security_group.security_group_id
}
