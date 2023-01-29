data "aws_identitystore_group" "SecOps" {
  identity_store_id = tolist(data.aws_ssoadmin_instances.jumpcloud.identity_store_ids)[0]

  filter {
    attribute_path  = "DisplayName"
    attribute_value = "Engineering - Information Security"
  }
}

resource "aws_ssoadmin_managed_policy_attachment" "SecOps_Admin_Policy" {
  instance_arn       = aws_ssoadmin_permission_set.SecOps_Admin.instance_arn
  count              = length(var.SecOps_Admin_policy_arn)
  managed_policy_arn = var.SecOps_Admin_policy_arn[count.index]
  permission_set_arn = aws_ssoadmin_permission_set.SecOps_Admin.arn
}

resource "aws_ssoadmin_account_assignment" "SecOps_DevEnv" {
  instance_arn       = aws_ssoadmin_permission_set.SecOps_Admin.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.SecOps_Admin.arn

  principal_id   = data.aws_identitystore_group.SecOps.group_id
  principal_type = "GROUP"

  target_id   = var.flw_development_account_id
  target_type = "AWS_ACCOUNT"
}

resource "aws_ssoadmin_account_assignment" "SecOps_ProdEnv" {
  instance_arn       = aws_ssoadmin_permission_set.SecOps_Admin.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.SecOps_Admin.arn

  principal_id   = data.aws_identitystore_group.SecOps.group_id
  principal_type = "GROUP"

  target_id   = var.flw_production_account_id
  target_type = "AWS_ACCOUNT"
}

resource "aws_ssoadmin_account_assignment" "SecOps_MasterEnv" {
  instance_arn       = aws_ssoadmin_permission_set.SecOps_Admin.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.SecOps_Admin.arn

  principal_id   = data.aws_identitystore_group.SecOps.group_id
  principal_type = "GROUP"

  target_id   = var.flw_master_account_id
  target_type = "AWS_ACCOUNT"
}

resource "aws_ssoadmin_account_assignment" "SecOps_flw_rave_account" {
  instance_arn       = aws_ssoadmin_permission_set.SecOps_Admin.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.SecOps_Admin.arn

  principal_id   = data.aws_identitystore_group.SecOps.group_id
  principal_type = "GROUP"

  target_id   = var.flw_rave_account_id
  target_type = "AWS_ACCOUNT"
}

resource "aws_ssoadmin_account_assignment" "SecOps_flw_core_account" {
  instance_arn       = aws_ssoadmin_permission_set.SecOps_Admin.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.SecOps_Admin.arn

  principal_id   = data.aws_identitystore_group.SecOps.group_id
  principal_type = "GROUP"

  target_id   = var.flw_core_account_id
  target_type = "AWS_ACCOUNT"
}

resource "aws_ssoadmin_account_assignment" "SecOps_store_domains_account" {
  instance_arn       = aws_ssoadmin_permission_set.SecOps_Admin.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.SecOps_Admin.arn

  principal_id   = data.aws_identitystore_group.SecOps.group_id
  principal_type = "GROUP"

  target_id   = var.store_domains_account_id
  target_type = "AWS_ACCOUNT"
}

resource "aws_ssoadmin_account_assignment" "SecOps_flw_confluence_account" {
  instance_arn       = aws_ssoadmin_permission_set.SecOps_Admin.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.SecOps_Admin.arn

  principal_id   = data.aws_identitystore_group.SecOps.group_id
  principal_type = "GROUP"

  target_id   = var.flw_confluence_account_id
  target_type = "AWS_ACCOUNT"
}

resource "aws_ssoadmin_account_assignment" "SecOps_flw_barter_account" {
  instance_arn       = aws_ssoadmin_permission_set.SecOps_Admin.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.SecOps_Admin.arn

  principal_id   = data.aws_identitystore_group.SecOps.group_id
  principal_type = "GROUP"

  target_id   = var.flw_barter_account_id
  target_type = "AWS_ACCOUNT"
}