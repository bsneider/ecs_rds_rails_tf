terraform {
  backend "remote" {
    organization = "devsecopslearning"

    workspaces {
      name = "ecs_rds_rails_tf_dev"
    }
  }
}
