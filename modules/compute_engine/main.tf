resource "google_compute_instance" "compute_instance" {
    name = var.compute_instance_name
    machine_type = var.machine_type
    boot_disk {
      initialize_params {
        image = "ubuntu-os-cloud/ubuntu-2004-lts"
      }
    }
    network_interface {
      network = var.network_name
    }
}