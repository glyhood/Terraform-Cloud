data "aws_identitystore_group" "DevOps" {
  identity_store_id = tolist(data.aws_ssoadmin_instances.jumpcloud.identity_store_ids)[0]

  filter {
    attribute_path  = "DisplayName"
    attribute_value = "DevOps"
  }
}

resource "aws_ssoadmin_managed_policy_attachment" "DevOps_DevEnv_Policy" {
  instance_arn       = aws_ssoadmin_permission_set.DevOps_DevEnv.instance_arn
  count              = length(var.DevOps_DevEnv_policy_arn)
  managed_policy_arn = var.DevOps_DevEnv_policy_arn[count.index]
  permission_set_arn = aws_ssoadmin_permission_set.DevOps_DevEnv.arn
}

resource "aws_ssoadmin_managed_policy_attachment" "DevOps_ProdEnv_Policy" {
  instance_arn       = aws_ssoadmin_permission_set.DevOps_ProdEnv.instance_arn
  count              = length(var.DevOps_ProdEnv_policy_arn)
  managed_policy_arn = var.DevOps_ProdEnv_policy_arn[count.index]
  permission_set_arn = aws_ssoadmin_permission_set.DevOps_ProdEnv.arn
}

resource "aws_ssoadmin_managed_policy_attachment" "DevOps_MasterEnv_Policy" {
  instance_arn       = aws_ssoadmin_permission_set.DevOps_MasterEnv.instance_arn
  count              = length(var.DevOps_MasterEnv_policy_arn)
  managed_policy_arn = var.DevOps_MasterEnv_policy_arn[count.index]
  permission_set_arn = aws_ssoadmin_permission_set.DevOps_MasterEnv.arn
}

resource "aws_ssoadmin_account_assignment" "DevOps_DevEnv" {
  instance_arn       = aws_ssoadmin_permission_set.DevOps_DevEnv.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.DevOps_DevEnv.arn

  principal_id   = data.aws_identitystore_group.DevOps.group_id
  principal_type = "GROUP"

  target_id   = var.flw_development_account_id
  target_type = "AWS_ACCOUNT"
}

resource "aws_ssoadmin_account_assignment" "DevOps_ProdEnv" {
  instance_arn       = aws_ssoadmin_permission_set.DevOps_ProdEnv.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.DevOps_ProdEnv.arn

  principal_id   = data.aws_identitystore_group.DevOps.group_id
  principal_type = "GROUP"

  target_id   = var.flw_production_account_id
  target_type = "AWS_ACCOUNT"
}

resource "aws_ssoadmin_account_assignment" "DevOps_MasterEnv" {
  instance_arn       = aws_ssoadmin_permission_set.DevOps_MasterEnv.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.DevOps_MasterEnv.arn

  principal_id   = data.aws_identitystore_group.DevOps.group_id
  principal_type = "GROUP"

  target_id   = var.flw_master_account_id
  target_type = "AWS_ACCOUNT"
}