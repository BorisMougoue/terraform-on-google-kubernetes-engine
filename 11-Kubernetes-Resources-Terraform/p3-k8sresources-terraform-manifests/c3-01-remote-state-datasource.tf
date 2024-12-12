
# Terraform Remote State Datasource
# we want to access the remote state of the previous project to get some information
data "terraform_remote_state" "gke" {
  backend = "gcs"  # standard value for GCP remote backent
  config = {
    bucket = "terraform-on-gcp-gke-boris"  # the bucket in which the state file is stored
    prefix = "dev/gke-cluster-public"
  }  
}
# we can now output the cluster_name and cluster_location from the data source. 
# we added .outputs in the command because the cluster_name is displayed as an output value in the state file (view the remote state content)
output "p1_gke_cluster_name" {
  value = data.terraform_remote_state.gke.outputs.gke_cluster_name
}

output "p1_gke_cluster_location" {
  value = data.terraform_remote_state.gke.outputs.gke_cluster_location
}
