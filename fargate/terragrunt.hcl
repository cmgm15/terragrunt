locals {
  region   = "us-east-1"
  aws_profile  = "dataentropia"      
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket         = "web-app-tf-state"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.region
    profile        = local.aws_profile
  }
}
