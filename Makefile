_AWS_PROFILE=sandbox
_ENV=dev
_PROJECT=satyam-weather-wear
_AWS_REGION=us-west-2
TERRAGRUNT_PATH=infrastructure/environments/dev/
REPO_NAME=th-weather-wear-infra
_PREFIX=${_PROJECT}-${_ENV}
SCRIPTS=infrastructure/scripts


.EXPORT_ALL_VARIABLES:
TF_VAR_env=$(_ENV)
TF_VAR_aws_profile=$(_AWS_PROFILE)
TF_VAR_aws_region=$(_AWS_REGION)
TF_VAR_tf_bucket=$(_PROJECT)-terraform
TF_VAR_prefix=${_PREFIX}
TF_VAR_repo_name=$(REPO_NAME)
TF_VAR_parameter_prefix=/$(_PROJECT)/$(_ENV)


init plan apply show destroy:
	@cd $(TERRAGRUNT_PATH) && terragrunt $@

tf:
	@tfswitch
	@tgswitch


apply-ci:
	@cd $(TERRAGRUNT_PATH) && terragrunt apply -auto-approve

init-upgrade:
	@cd $(TERRAGRUNT_PATH) && terragrunt init --upgrade

fmt:
	@terraform fmt --recursive
	@terragrunt hclfmt

awscli-ci:
	@./$(SCRIPTS)/awscli

tfimport:
	@cd $(TERRAGRUNT_PATH) && terragrunt import $(resource_id) $(remote_resource_id)

tftarget:
	@cd $(TERRAGRUNT_PATH) && terragrunt apply -target $(resource_id)
	
tfdestroy:
	@cd $(TERRAGRUNT_PATH) && terragrunt destroy -target $(resource_id)

mvstate:
	@cd $(TERRAGRUNT_PATH) && terragrunt state mv $(source_resource_id) $(target_resource_id)

tfstate:
	@cd $(TERRAGRUNT_PATH) && terragrunt state list
	
tfimport:
	@cd $(TERRAGRUNT_PATH) && terragrunt import $(resource_id) $(remote_resource_id)
