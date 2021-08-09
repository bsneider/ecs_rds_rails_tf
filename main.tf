# Root main.tf

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

module "aws_creds" {
  source                  = "./modules/aws_creds"
  environment             = terraform.workspace
  vault_addr              = var.vault_addr
  login_approle_role_id   = var.login_approle_role_id
  login_approle_secret_id = var.login_approle_secret_id
}

# Configure the AWS Provider
provider "aws" {
  region     = var.region
  access_key = module.aws_creds.access_key
  secret_key = module.aws_creds.secret_key
  token      = module.aws_creds.token
  default_tags {
    tags = {
      Environment = terraform.workspace
      Owner       = "Ops"
      Project     = "ecs_rds_rails_tf"
    }
  }
}

module "networking" {
  source               = "./modules/networking"
  environment          = terraform.workspace
  vpc_cidr             = "10.0.0.0/16"
  public_subnets_cidr  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets_cidr = ["10.0.10.0/24", "10.0.20.0/24"]
  region               = var.region
  availability_zones   = var.availability_zones
  key_name             = "production_key"
}

module "rds" {
  source            = "./modules/rds"
  environment       = terraform.workspace
  allocated_storage = "20"
  database_name     = var.database_name
  database_username = var.database_username
  database_password = var.database_password
  subnet_ids        = module.networking.private_subnets_id
  vpc_id            = module.networking.vpc_id
  instance_class    = "db.t2.micro"
}

module "ecs" {
  source              = "./modules/ecs"
  environment         = terraform.workspace
  vpc_id              = module.networking.vpc_id
  availability_zones  = var.availability_zones
  repository_name     = "rails_terraform/production"
  subnets_ids         = module.networking.private_subnets_id
  public_subnet_ids   = module.networking.public_subnets_id
  security_groups_ids = concat([module.rds.db_access_sg_id], module.networking.security_groups_ids)
  database_endpoint   = module.rds.rds_address
  database_name       = var.database_name
  database_username   = var.database_username
  database_password   = var.database_password
  secret_key_base     = var.secret_key_base
  region              = var.region
}

