data "aws_ssoadmin_instances" "jumpcloud" {}

resource "aws_ssoadmin_permission_set" "Developers_MasterEnv" {
  instance_arn     = tolist(data.aws_ssoadmin_instances.jumpcloud.arns)[0]
  name             = "Developers_MasterEnv"
  description      = "*DO-NOT-MODIFY-MANUALLY* Provides access to the developers to the master account"
  session_duration = "PT12H"
  tags = {
    Environment = "Master"
    Team        = "Developers"
  }
}

resource "aws_ssoadmin_permission_set" "DevOps_DevEnv" {
  instance_arn     = tolist(data.aws_ssoadmin_instances.jumpcloud.arns)[0]
  name             = "DevOps_DevEnv"
  description      = "*DO-NOT-MODIFY-MANUALLY* Provides access for members of the DevOps team to the development account"
  session_duration = "PT12H"
  tags = {
    Environment = "Development"
    Team        = "DevOps"
  }
}

resource "aws_ssoadmin_permission_set" "DevOps_ProdEnv" {
  instance_arn     = tolist(data.aws_ssoadmin_instances.jumpcloud.arns)[0]
  name             = "DevOps_ProdEnv"
  description      = "*DO-NOT-MODIFY-MANUALLY* Provides access for members of the DevOps team to the production account"
  session_duration = "PT12H"
  tags = {
    Environment = "Production"
    Team        = "DevOps"
  }
}

resource "aws_ssoadmin_permission_set" "DevOps_MasterEnv" {
  instance_arn     = tolist(data.aws_ssoadmin_instances.jumpcloud.arns)[0]
  name             = "DevOps_MasterEnv"
  description      = "*DO-NOT-MODIFY-MANUALLY* Provides access for members of the DevOps team to the master account"
  session_duration = "PT12H"
  tags = {
    Environment = "Master"
    Team        = "DevOps"
  }
}

resource "aws_ssoadmin_permission_set" "SecOps_Admin" {
  instance_arn     = tolist(data.aws_ssoadmin_instances.jumpcloud.arns)[0]
  name             = "SecOps_Admin"
  description      = "*DO-NOT-MODIFY-MANUALLY* Provides admin level access for members of the Security team across all AWS accounts"
  session_duration = "PT12H"
  tags = {
    Environment = "All Accounts"
    Team        = "Security"
  }
}

## The block below creates the access for developers to the development environment

/* resource "aws_ssoadmin_permission_set" "Developers_DevEnv" {
  instance_arn     = tolist(data.aws_ssoadmin_instances.jumpcloud.arns)[0]
  name             = "Developers_DevEnv"
  description      = "Provides access to the developers to the development env"
  session_duration = "PT12H"
  tags = {
    Environment = "Development"
    Team        = "Developers"
  }
} */

## The block below creates the access for developers to the control center account

/* resource "aws_ssoadmin_permission_set" "Developers_ProdEnv" {
  instance_arn     = tolist(data.aws_ssoadmin_instances.jumpcloud.arns)[0]
  name             = "Developers_ProdEnv"
  description      = "Provides access to the developers to the production env"
  session_duration = "PT12H"
  tags = {
    Environment = "Production"
    Team        = "Developers"
  }
} */