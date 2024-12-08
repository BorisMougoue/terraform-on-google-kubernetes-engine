# Resource Block: Create a single Compute Engine instance
resource "google_compute_instance" "myapp1" {
  name         = "myapp1"
  machine_type = "e2-micro"
  zone         = "us-central1-a"
  # you can directly reference the tags = ["ssh-tag","webser-tag"]
  # but the best practice is to get the value from the firewall resource using the tolist function
  tags         = [tolist(google_compute_firewall.fw_ssh.target_tags)[0], tolist(google_compute_firewall.fw_http.target_tags)[0]]
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }
  # Install Webserver; path.module means that the script is your current working dir
  metadata_startup_script = file("${path.module}/app1-webserver-install.sh")
  network_interface {
    
    subnetwork = google_compute_subnetwork.mysubnet.id
    access_config {
      # Include this section to give the VM an external IP address
    }
  }
}