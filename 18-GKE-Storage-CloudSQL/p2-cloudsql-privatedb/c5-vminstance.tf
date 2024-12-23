# Firewall Rule: SSH . this will enable us to SSH into the instance
resource "google_compute_firewall" "fw_ssh" {
  name = "fwrule-allow-ssh22"
  allow {
    ports    = ["22"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  network       = data.terraform_remote_state.gke.outputs.vpc_id
  priority      = 1000
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh-tag"]
}

# we want to test if a VM in our custom VPC can access the Cloud SQL database
# that is why we create this VM. 
#If the connection is sucessful, the kubernetes workload will also be able to access the database
# Resource Block: Create a single Compute Engine instance
resource "google_compute_instance" "myapp1" {
  name         = "mysql-client"
  machine_type = "e2-micro"
  zone         = "us-central1-a"
  tags        = [tolist(google_compute_firewall.fw_ssh.target_tags)[0]]
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }
  # Install Webserver
  metadata_startup_script = file("${path.module}/mysql-client-install.sh")
  network_interface {
    subnetwork = data.terraform_remote_state.gke.outputs.mysubnet_id
    access_config {
      # Include this section to give the VM an external IP address
    }
  }
}

output "vm_public_ip" {
  value = google_compute_instance.myapp1.network_interface.0.access_config.0.nat_ip
}