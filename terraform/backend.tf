terraform {
  backend "gcs" {
    bucket  = "ssw-590-final-tfstate"
    prefix  = "live/"
    credentials = "tf-svc-crds.json"
  }
}