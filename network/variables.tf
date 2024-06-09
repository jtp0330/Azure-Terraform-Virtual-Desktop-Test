variable "admin_username" {
  type        = string
  description = "default admin username created during vm deployment."
}

variable "admin_password" {
  type        = string
  description = "default admin password created during vm deployment."
}

module "root" {
  source         = "./.."
  admin_username = var.admin_username
  admin_password = var.admin_password
}
