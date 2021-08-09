terraform {
  backend "remote" {
    organization = "devsecopslearning"

    workspaces {
      prefix = "ecs_rds_rails_tf_"
    }
  }
}
