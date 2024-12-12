# Provider: google
provider "google" {
  project = var.gcp_project
  region = var.gcp_region1
}

# GKE Datasource: GKE Cluster details
# This is a dynamic way of getting the name and location of cluster
# we could have also just hardcode the values directly. static way
# since we already have a datasource from the remote state file we can get values from there.
data "google_container_cluster" "gke" {
  name     = data.terraform_remote_state.gke.outputs.gke_cluster_name
  location = data.terraform_remote_state.gke.outputs.gke_cluster_location
}

# we get endpoint and certificate from the datasource create aboved
# these ouputs are not mandatory. You can also input the endpoint and certificate directly in kubernetes provider. The value are read from the datasource created above
output "gke_cluster_details" {
  value = {
    gke_endpoint = data.google_container_cluster.gke.endpoint
    #gke_cluster_ca_certificate = data.google_container_cluster.gke.master_auth.0.cluster_ca_certificate
  }
}

# Resource: Access the configuration of the Google Cloud provider.
data "google_client_config" "default" {}

# Provider: Kubernetes
# this is a dynamic way of configuring providers. The static way is just to pass in the path of the kubeconfig file
provider "kubernetes" {
  host                   = "https://${data.google_container_cluster.gke.endpoint}"
  cluster_ca_certificate = base64decode(data.google_container_cluster.gke.master_auth.0.cluster_ca_certificate)
  token                  = data.google_client_config.default.access_token
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "gke-gcloud-auth-plugin"
    # Additional Reference: https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/using_gke_with_terraform#using-the-kubernetes-and-helm-providers
  }  
}



