provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "./modules/vpc"

  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]

  availability_zones   = ["ap-south-1a", "ap-south-1b"]
}

module "security_group" {
  source = "./modules/security-group"

  vpc_id = module.vpc.vpc_id
}

module "alb" {
  source = "./modules/alb"

  vpc_id         = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnets
  alb_sg_id      = module.security_group.alb_sg_id
}

module "launch_template" {
  source = "./modules/launch-template"

  ami_id      = "ami-02eb0c2388ee999f9"   # YOU MUST REPLACE
  ec2_sg_id   = module.security_group.ec2_sg_id
}

module "autoscaling" {
  source = "./modules/autoscaling"

  launch_template_id = module.launch_template.launch_template_id
  private_subnets    = module.vpc.public_subnets
  target_group_arn   = module.alb.target_group_arn
}

#New line
