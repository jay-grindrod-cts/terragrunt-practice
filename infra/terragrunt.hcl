// Variables

locals {
  root_vars = yamldecode(file(find_in_parent_folders("vars.yaml")))
  project  = local.root_vars.project
  region   = local.root_vars.region
  zone = local.root_vars.zone
  state_bucket = local.root_vars.state_bucket
}

// Inputs

inputs = merge(
  yamldecode(file(find_in_parent_folders("vars.yaml"))),
  yamldecode(file(find_in_parent_folders("env.yaml")))
)

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
        path = "${get_parent_terragrunt_dir()}/backend.tf"
        if_exists = "skip"
    }
    config = {
        bucket = local.state_bucket
        project  = local.project
        location = local.region
    }
}