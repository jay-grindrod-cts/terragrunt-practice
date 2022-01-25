module "vpc" {
  source  = "terraform-google-modules/network/google//modules/vpc"
  version = "~> 2.0.0"

  network_name = var.network_name
  auto_create_subnetworks = true
}