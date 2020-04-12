locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  env = local.environment_vars.locals.environment
  region = local.environment_vars.locals.region
  aws_profile = local.environment_vars.locals.aws_profile
}

terraform {
  source = "github.com/cmgm15/tf-fargate//fargate?ref=0.1.0"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  cicd_user = true
  cicd_environments = [
      "dev",
      "qa",
  ]
  logs_retention_in_days = 5
  certificate_arn = "arn:aws:acm:us-east-1:474598587144:certificate/064caf34-6886-4a5f-ac43-9ae41b42158b"
  internal = "false"
  health_check = "/health_check"
  aws_profile = local.aws_profile
  region = local.region
  tags = {
      environment = local.env,
    application = "web-app",
    responsible = "cmgomez"
  }
  app = "web-app"
  environment = local.env
  container_port = "8080"
  vpc = "vpc-0f39a14b3bd69d968"
  private_subnets = "subnet-0961e939220e0aea6,subnet-0e47256c4dcd6dd88,subnet-06bf68eef096c5f07,subnet-0a515772a3bcd46c6"
  public_subnets = "subnet-0992e6d4b52bad709,subnet-053bfc18614bdd208,subnet-0745f961d0a90fcd9,subnet-054534354576e7902"
}
