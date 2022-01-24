module "network" {
  source  = "tfr:///terraform-google-modules/network/google?version=4.0.1"
  
  network_name = var.network_name
}