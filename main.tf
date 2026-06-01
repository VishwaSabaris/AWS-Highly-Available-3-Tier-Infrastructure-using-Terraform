provider "aws" {
  region = var.aws_region
}

module "security_group" {
  source = "./modules/security-group"

  sg_name      = "terraform-sg"
  allowed_cidr = ["0.0.0.0/0"]
}

module "alb" {
  source = "./modules/alb"

  alb_name          = "terraform-flask-alb"
  security_group_id = module.security_group.security_group_id
  subnet_ids        = var.subnet_ids
}

module "asg" {
  source = "./modules/asg"

  ami_id            = var.ami_id
  instance_type     = var.instance_type
  key_name          = var.key_name
  security_group_id = module.security_group.security_group_id
  docker_image      = var.docker_image
  subnet_ids        = var.subnet_ids
  target_group_arn  = module.alb.target_group_arn
  desired_capacity  = 2
  min_size          = 1
  max_size          = 3
}
