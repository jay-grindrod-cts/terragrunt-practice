// Variables

locals {
  root_vars = yamldecode(file(find_in_parent_folders("vars.yaml")))
  project  = local.root_vars.project
  region   = local.root_vars.zone
  zone = local.root_vars.zone
}

// Provider

generate "provider" {
  path      = "${get_parent_terragrunt_dir()}/provider.tf"
  if_exists = "skip"
  contents  = file(find_in_parent_folders("provider.tf"))
}

// Versions

generate "versions" {
  path      = "${get_parent_terragrunt_dir()}/versions.tf"
  if_exists = "skip"
  contents  = file(find_in_parent_folders("versions.tf"))
}

// State

remote_state {
    backend = "gcs"
    generate = {
        path = "backend.tf"
        if_exists = "skip"
    }
    config = {
        bucket = "terragrunt-practice-state"
        prefix = path_relative_to_include()
        project  = local.project
        location = local.region
    }
}