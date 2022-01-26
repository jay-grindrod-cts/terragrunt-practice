// Dependency

dependency "vpc" {
  config_path = "../vpc"
}

// Variables

locals {
  root_vars  = yamldecode(file(find_in_parent_folders("vars.yaml")))
  vars       = yamldecode(file(find_in_parent_folders("env.yaml")))
  version    = local.vars.version
  repo_owner = local.root_vars.repo_owner
}

// Terraform

terraform {
  source = "git::ssh://git@github.com/${local.repo_owner}/terragrunt-practice.git//modules/compute_engine?ref=${local.version}"
}

// Inputs

inputs = {
  compute_instance_name = "terragrunt-test-vm"
  machine_type          = "e2-small"
  network_name          = dependency.vpc.outputs.network_name
}

// Include

include "root" {
  path = find_in_parent_folders()
}