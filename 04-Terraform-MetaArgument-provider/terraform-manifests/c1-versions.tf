# Terraform Settings Block
terraform {
  required_version = ">= 1.8"
  required_providers {
    google = {
      source = "hashicorp/google"
      version = ">= 5.34.0"
    }
  }
}

# Terraform Provider-1: us-central1
provider "google" {
  project = "fluid-axis-444106-d7"
  region = "us-central1"
  alias = "us-central1"    
}

# Terraform Provider-2: europe-west1
provider "google" {
  project = "fluid-axis-444106-d7" 
  region = "europe-west1"
  alias = "europe-west1"    
}