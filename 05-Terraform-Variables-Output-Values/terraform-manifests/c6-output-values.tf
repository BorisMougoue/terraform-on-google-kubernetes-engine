# Terraform Output Values
# #ATTRIBUTES Reference
output "vm_instanceid" {
  description = "vm_instanceid"
  value = google_compute_instance.myapp1.instance_id
}
  
output "vm_external_ip" {
  description = "vm external IP"
  value = google_compute_instance.myapp1.network_interface.0.access_config.0.nat_ip
}  

## Argument Reference
output "vm_machine_type" {
  description = "vm machine type"
  value = google_compute_instance.myapp1.machine_type
}

output "vm_name" {
  description = "VM Name"
  value = google_compute_instance.myapp1.name
}