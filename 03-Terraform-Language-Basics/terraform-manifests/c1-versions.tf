# Terraform Settings Block
# run the command ctrl + space to see the possible top level blocks
terraform {
  required_version = ">=1.8.5"
  required_providers {
    google = {
      source = "hashicorp/google"
      version = ">=6.12.0"
    }
  }
  }


# Terraform Provider Block
provider "google" {
  project = "fluid-axis-444106-d7" # PROJECT_ID
  region = "us-central1"
  
}

