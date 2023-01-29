data "aws_identitystore_group" "Developers" {
  identity_store_id = tolist(data.aws_ssoadmin_instances.jumpcloud.identity_store_ids)[0]

  filter {
    attribute_path  = "DisplayName"
    attribute_value = "Developers"
  }
}

## The block below maps the developers access to the master account to the defined policy

resource "aws_ssoadmin_managed_policy_attachment" "Developers_MasterEnv_Policy" {
  instance_arn       = aws_ssoadmin_permission_set.Developers_MasterEnv.instance_arn
  count              = length(var.Developers_MasterEnv_policy_arn)
  managed_policy_arn = var.Developers_MasterEnv_policy_arn[count.index]
  permission_set_arn = aws_ssoadmin_permission_set.Developers_MasterEnv.arn
}

## The block below assigns the developers access to the master account

resource "aws_ssoadmin_account_assignment" "Developers_MasterEnv" {
  instance_arn       = aws_ssoadmin_permission_set.Developers_MasterEnv.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.Developers_MasterEnv.arn

  principal_id   = data.aws_identitystore_group.Developers.group_id
  principal_type = "GROUP"

  target_id   = var.flw_master_account_id
  target_type = "AWS_ACCOUNT"
}

## The block below maps the developers access to the dev env to the defined policy

/* resource "aws_ssoadmin_managed_policy_attachment" "Developers_DevEnv_Policy" {
  instance_arn       = aws_ssoadmin_permission_set.Developers_DevEnv.instance_arn
  count              = length(var.Developers_DevEnv_policy_arn)
  managed_policy_arn = var.Developers_DevEnv_policy_arn[count.index]
  permission_set_arn = aws_ssoadmin_permission_set.Developers_DevEnv.arn
} */

## The block below maps the developers access to the control center account to the defined policy

/* resource "aws_ssoadmin_managed_policy_attachment" "Developers_ProdEnv_Policy" {
  instance_arn       = aws_ssoadmin_permission_set.Developers_ProdEnv.instance_arn
  count              = length(var.Developers_ProdEnv_policy_arn)
  managed_policy_arn = var.Developers_ProdEnv_policy_arn[count.index]
  permission_set_arn = aws_ssoadmin_permission_set.Developers_ProdEnv.arn
} */

## The block below assigns the developers access to the dev account

/* resource "aws_ssoadmin_account_assignment" "Developers_DevEnv" {
  instance_arn       = aws_ssoadmin_permission_set.Developers_DevEnv.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.Developers_DevEnv.arn

  principal_id   = data.aws_identitystore_group.Developers.group_id
  principal_type = "GROUP"

  target_id   = var.flw_development_account_id
  target_type = "AWS_ACCOUNT"
} */

## The block below assigns the developers access to the control center account

/* resource "aws_ssoadmin_account_assignment" "Developers_ProdEnv" {
  instance_arn       = aws_ssoadmin_permission_set.Developers_ProdEnv.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.Developers_ProdEnv.arn

  principal_id   = data.aws_identitystore_group.Developers.group_id
  principal_type = "GROUP"

  target_id   = var.flw_production_account_id
  target_type = "AWS_ACCOUNT"
} */
