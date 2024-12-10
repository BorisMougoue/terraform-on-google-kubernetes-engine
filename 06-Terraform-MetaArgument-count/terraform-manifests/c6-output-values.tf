# Terraform Output Values
/* Concepts Covered
1. For Loop with List
2. For Loop with Map
3. For Loop with Map Advanced
4. Legacy Splat Operator (latest) - Returns List
5. Latest Generalized Splat Operator - Returns the List
*/

# Get each list item separately
# by adding the count argument, the output are now list
#therefore we need to specify the index in the output block
output "vm_name_0" {
  description = "VM Name"
  value       = google_compute_instance.myapp1[0].name
}

# Get each list item separately
# this will return the name of the created instance
output "vm_name_1" {
  description = "VM Name"
  value       = google_compute_instance.myapp1[1].name
}

# Output - For Loop with List
# Aftert the : you specify the output reference
output "for_output_list" {
  description = "For Loop with List"
  value       = [for instance in google_compute_instance.myapp1 : instance.name]
}

# Output - For Loop with Map
# maps are key-value pairs
# for map we use the {} bracket. the key is instance.name and the value is instance.instance_id
output "for_output_map1" {
  description = "For Loop with Map"
  value       = { for instance in google_compute_instance.myapp1 : instance.name => instance.instance_id }
}

# Output - For Loop with Map Advanced
# we added the count (c) in the expression
# for each count (1,2), return the c = instance.name
output "for_output_map2" {
  description = "For Loop with Map - Advanced"
  value       = { for c, instance in google_compute_instance.myapp1 : c => instance.name }
}

# Output - For Loop with Map Advanced
# we added the count (c) in the expression
# for each count (1,2), return the instance.name => instance.instance_id
output "for_output_map3" {
  description = "For Loop with Map - Advanced (Instance Name and Instance ID)"
  value       = { for c, instance in google_compute_instance.myapp1 : instance.name => instance.instance_id }
}

# VM External IPs
output "vm_external_ips" {
  description = "For Loop with Map - Advanced"
  value       = { for c, instance in google_compute_instance.myapp1 : c => instance.network_interface.0.access_config.0.nat_ip }
}


# Output Legacy Splat Operator (Legacy) - Returns the List
# instead of using for loop, we can also use splat operators to return all the values in a list
# for the legacy splat operator, we use the * to return a list
output "legacy_splat_instance" {
  description = "Legacy Splat Operator"
  value       = google_compute_instance.myapp1.*.name
}

# Output Latest Generalized Splat Operator - Returns the List
# for Latest Generalized splat operator, we use the [*] to return a list
output "latest_splat_instance" {
  description = "Generalized latest Splat Operator"
  value       = google_compute_instance.myapp1[*].name
}

/* 
------- FOR SINGLE VM INSTANCE -------
# Terraform Output Values
## ATTRIBUTES
output "vm_instanceid" {
  description = "VM Instance ID"
  value = google_compute_instance.myapp1.instance_id
}

output "vm_selflink" {
  description = "VM Instance Self link"
  value = google_compute_instance.myapp1.self_link
}

output "vm_id" {
  description = "VM ID"
  value = google_compute_instance.myapp1.id
}

## ARGUMENTS
output "vm_name" {
  description = "VM Name"
  value = google_compute_instance.myapp1.name
}

output "vm_machine_type" {
  description = "VM Machine Type"
  value = google_compute_instance.myapp1.machine_type
}
*/