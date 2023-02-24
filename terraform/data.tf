data "google_billing_account" "account" {
  billing_account = var.billing_account_id
}

data "google_project" "project" {
}