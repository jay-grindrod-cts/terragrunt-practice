module "network" {
  source  = "terraform-google-modules/network/google"
  version = "4.1.0"

  project_id = var.project
  network_name = var.network_name
}