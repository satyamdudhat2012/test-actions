module "github_aws_open_id"{
 source = "git::https://github.com/TechHoldingLLC/terraform-aws-github-oidc.git?ref=v1.0.3"
  role_name = "${var.prefix}-github-env-dev"
    env_repo_config = {
         "${var.env}" = local.repo_list
    }
    providers = {
        aws = aws
    }
}
locals {
  repo_list = [
    "satyamdudhat2012/test-actions"
  ]
}

resource "aws_iam_policy" "policy" {
  name = "${var.prefix}-github-actions-env-dev"
  path = "/"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : "*",
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "github_aws_oidc" {
  role       = module.github_aws_open_id.iam_role_name
  policy_arn = resource.aws_iam_policy.policy.arn
}
