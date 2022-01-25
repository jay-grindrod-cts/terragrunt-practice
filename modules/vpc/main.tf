module "network" {
  source  = "terraform-google-modules/network/google"
  version = "4.1.0"

  project_id = var.project
  network_name = var.network_name
  subnets = [        {
            subnet_name           = var.subnet_name
            subnet_ip             = "10.10.10.0/24"
            subnet_region         = var.region
        }
  ]
}