variable "environment" {
  description = "The environment"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet ids"
}

variable "vpc_id" {
  description = "The VPC id"
}

//variable "allowed_security_group_id" {
//  description = "The allowed security group id to connect on RDS"
//}

variable "allocated_storage" {
  default     = "20"
  description = "The storage size in GB"
}

variable "instance_class" {
  description = "The instance type"
}

variable "multi_az" {
  default     = false
  description = "Muti-az allowed?"
}

variable "database_name" {
  description = "The database name"
}

variable "database_username" {
  description = "The username of the database"
}

variable "database_password" {
  description = "The password of the database"
}

variable "rds_engine_version" {
  description = "if defaults are set then minor version will auto increment in patching window"
  type        = string
  default     = "9.6.6"
}

variable "rds_engine" {
  description = "RDS engine version mysql or postgres"
  type        = string
  default     = "postgres"
}

variable "db_port" {
  type        = number
  default     = 5432
  description = "Default port for access to db instance. For postgres that is 5432"
}
