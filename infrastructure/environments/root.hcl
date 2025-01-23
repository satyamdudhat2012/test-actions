#----------------------------------------------------------------------------------------
# Terraform Remote state config
#----------------------------------------------------------------------------------------
remote_state {
  backend = "s3"
  config = {
    bucket         = local.tf_bucket
    key            = "${local.env}/terraform.tfstate"
    region         = local.aws_region
    encrypt        = true
    profile        = local.aws_profile
  }
}

locals {
  env         = get_env("TF_VAR_env")
  tf_bucket   = get_env("TF_VAR_tf_bucket")
  aws_profile = get_env("TF_VAR_aws_profile")
  aws_region  = get_env("TF_VAR_aws_region")
  repo_name   = get_env("TF_VAR_repo_name")
  prefix      = get_env("TF_VAR_prefix")
}


#----------------------------------------------------------------------------------------
# Terraform config
#----------------------------------------------------------------------------------------

terraform {
  source = "../..//stack/"


  extra_arguments "custom_vars" {
    commands = [
      "apply",
      "plan",
      "import",
      "push",
      "refresh"
    ]
  }

}