module "network" {
  source  = "tfr:///terraform-google-modules/network/google?version=4.0.1"
  
  project_id = var.project
  network_name = var.network_name
}