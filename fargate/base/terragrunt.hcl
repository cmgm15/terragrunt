locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("general.hcl"))
  region = local.environment_vars.locals.region
  aws_profile = local.environment_vars.locals.aws_profile
}

terraform {
  source = "github.com/cmgm15/tf-fargate//base?ref=0.1.0"
}

inputs = {
  region = local.region
  aws_profile = local.aws_profile
  owner = "cmgomez"
  app = "web-app"
  tags = {
    application = "web-app",
    responsible = "cmgomez"
  }
}
