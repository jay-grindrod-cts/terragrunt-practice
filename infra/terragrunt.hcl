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
  path      = "provider.tf"
  if_exists = "skip"
  contents  = <<EOF
provider "google" {
  project = local.project
  region = local.region
  zone = local.zone
}
EOF
}

// Versions

generate "versions" {
  path      = "versions.tf"
  if_exists = "skip"
  contents  = <<EOF
terraform {
  required_providers {
    google = {
      version = ">= 4.7.0"
      source = "hashicorp/google"
    }
  }
}
EOF
}

// State

remote_state {
    backend = "gcs"
    generate = {
        path = "backend.tf"
        if_exists = "skip"
    }
    config = {
        bucket = local.state_bucket
        prefix = path_relative_to_include()
        project  = local.project
        location = local.region
    }
}