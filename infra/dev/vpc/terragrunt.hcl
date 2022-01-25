// Variables

locals {
  root_vars = yamldecode(file(find_in_parent_folders("vars.yaml")))
  vars = yamldecode(file(find_in_parent_folders("env.yaml")))
  version = local.vars.version
  repo_owner = local.root_vars.repo_owner
}

// Terraform

terraform {
  source = "git::ssh://git@github.com/${local.repo_owner}/terragrunt-practice.git//modules/vpc?ref=${local.version}"
}

// Inputs

inputs = {
  network_name = "terragrunt-test-vpc"
}

// Include

include "root" {
  path = find_in_parent_folders()
}