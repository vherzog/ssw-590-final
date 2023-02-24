variable "credentials_path" {
  description = "path to GCP SA credentials"
  default = "REPLACE_ME"
}
variable "project_id" {
  description = "project id"
  default = "REPLACE_ME"
}

variable "billing_account_id" {
  description = "billing account id"
  default = "REPLACE_ME"
}

variable "notification_email_address" {
  description = "email address to notify on budget"
  default = "REPLACE_ME"
}

variable "region" {
  description = "region"
  default = "us-east1"
}

variable "gke_username" {
  default     = ""
  description = "gke username"
}

variable "gke_password" {
  default     = ""
  description = "gke password"
}

variable "gke_num_nodes" {
  default     = 1
  description = "number of gke nodes"
}