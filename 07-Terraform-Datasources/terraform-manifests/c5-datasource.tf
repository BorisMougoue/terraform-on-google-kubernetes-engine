# Terraform Datasources
# the region and project value will be pick up from the provider block
/* Datasource: Get a list of Google 
Compute zones that are UP in a region */
data "google_compute_zones" "available" {    
  status = "UP"
}

# Output value
output "compute_zones" {
  description = "List of compute zones"
  value = data.google_compute_zones.available.names
}
