variable "region" {
  description = "Region that the instances will be created"
  default     = "us-east-2"
}

/*====
environment specific variables
======*/

variable "database_name" {
  description = "The database name for Production"
}

variable "database_username" {
  description = "The username for the Production database"
}

variable "database_password" {
  description = "The user password for the Production database"
  validation {
    condition     = length(var.database_password) > 8
    error_message = "Error creating DB Instance: InvalidParameterValue: The parameter MasterUserPassword is not a valid password because it is shorter than 8 characters."
  }
}

variable "secret_key_base" {
  description = "The Rails secret key for production"
}

variable "domain" {
  default = "The domain of your application"
}

variable "rabbit_name" {
  description = "A random environment"
}

variable "tf_workspace" {
  description = "Environment for the application"
}

variable "availability_zones" {
  type        = list(string)
  description = "a comma-separated list of availability zones, defaults to all AZ of the region, if set to something other than the defaults, both private_subnets and public_subnets have to be defined as well"
  default     = ["us-east-2a", "us-east-2b"]
}

variable "login_approle_role_id" {
  description = "role id for vault approle to generate aws creds"
  type        = string
  sensitive   = true
}
variable "login_approle_secret_id" {
  description = "secret id for vault approle to generate aws creds"
  type        = string
  sensitive   = true
}
variable "vault_addr" {
  description = "address of vault instance"
  type        = string
  sensitive   = true
}
