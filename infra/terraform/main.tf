module "vpc" {
  source = "./modules/vpc"

  project_name = var.project_name
}

module "rds" {
  source = "./modules/rds"

  project_name          = var.project_name
  private_subnet_ids    = module.vpc.private_subnet_ids
  db_security_group_id  = "sg-xxxx" # replace later
  db_username           = "admin"
  db_password           = "change-me"
}

module "ecs" {
  source = "./modules/ecs"

  project_name         = var.project_name
  container_image      = "nginx"
  execution_role_arn   = "arn:aws:iam::xxxx:role/ecsTaskExecutionRole"
  private_subnet_ids   = module.vpc.private_subnet_ids
  ecs_security_group_id = "sg-xxxx"
}

# Future modules (planned)
# module "ecs" { ... }
# module "rds" { ... }