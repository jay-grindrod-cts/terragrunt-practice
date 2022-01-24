// Variables

locals {
  root_vars = yamldecode(file(find_in_parent_folders("vars.yaml")))
  project  = local.root_vars.project
  region   = local.root_vars.zone
  zone = local.root_vars.zone
  extra_tf_cmds = get_terraform_commands_that_need_vars()
}

// Provider

generate "provider" {
    path = "provider.tf"
    if_exists = "overwrite_terragrunt"
    contents = <<EOF
        provider "google" {
            project = local.project
            region = local.region
            zone = local.zone
        }
    EOF
}

// State

remote_state {
    backend = "gcs"
    generate = {
        path = "backend.tf"
        if_exists = "overwrite_terragrunt"
    }
    config = {
        bucket = "terragrunt-practice-state"
        prefix = path_relative_to_include()
        project  = local.project
        location = local.region
    }
}