variable "Developers_MasterEnv_policy_arn" {
  type = list(string)
  default = [
    "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess",
    "arn:aws:iam::aws:policy/AWSCodeDeployReadOnlyAccess",
    "arn:aws:iam::aws:policy/AmazonSESReadOnlyAccess",
    "arn:aws:iam::aws:policy/AmazonSQSReadOnlyAccess",
    "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess",
    "arn:aws:iam::aws:policy/AmazonAPIGatewayAdministrator",
    "arn:aws:iam::aws:policy/IAMReadOnlyAccess",
    "arn:aws:iam::aws:policy/AmazonRDSReadOnlyAccess",
    "arn:aws:iam::aws:policy/AWSElasticBeanstalkReadOnly"
  ]
}

data "aws_iam_policy_document" "Developers_MasterEnv_Custom_Policy" {
  statement {
    sid = "1"
    actions = [
      "cloudformation:CreateStack"
    ]
    resources = ["arn:aws:cloudformation:us-east-1:*:stack/barter-lambda-*"]
  }

  statement {
    sid = "2"
    actions = [
      "iam:CreateUser",
      "iam:CreateRole",
      "iam:DeleteRole",
      "iam:PutRolePolicy",
      "iam:DeleteRolePolicy"
    ]
    resources = ["arn:aws:iam::*:role/barter-lambda-*"]
  }

  statement {
    sid = "3"
    actions = [
      "ses:SendEmail"
    ]
    resources = ["arn:aws:ses:us-east-1:902118332415:identity/noreply@getbarter.co"]
  }
}


resource "aws_ssoadmin_permission_set_inline_policy" "Developers_MasterEnv_Custom_Policy" {
  inline_policy      = data.aws_iam_policy_document.Developers_MasterEnv_Custom_Policy.json
  instance_arn       = aws_ssoadmin_permission_set.Developers_MasterEnv.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.Developers_MasterEnv.arn
}

/* variable "Developers_DevEnv_policy_arn" {
  type = list(string)
  default = [
    "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess",
    "arn:aws:iam::aws:policy/AWSCodeDeployReadOnlyAccess",
    "arn:aws:iam::aws:policy/AmazonSESReadOnlyAccess",
    "arn:aws:iam::aws:policy/AmazonSQSReadOnlyAccess",
    "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess",
    "arn:aws:iam::aws:policy/AmazonAPIGatewayAdministrator",
    "arn:aws:iam::aws:policy/IAMReadOnlyAccess",
    "arn:aws:iam::aws:policy/AmazonRDSReadOnlyAccess",
    "arn:aws:iam::aws:policy/AWSElasticBeanstalkReadOnly"
  ]
}

data "aws_iam_policy_document" "Developers_DevEnv_Custom_Policy" {
  statement {
    sid = "1"
    actions = [
      "cloudformation:CreateStack"
    ]
    resources = ["arn:aws:cloudformation:us-east-1:*:stack/barter-lambda-*"]
  }

  statement {
    sid = "2"
    actions = [
      "iam:CreateUser",
      "iam:CreateRole",
      "iam:DeleteRole",
      "iam:PutRolePolicy",
      "iam:DeleteRolePolicy"
    ]
    resources = ["arn:aws:iam::*:role/barter-lambda-*"]
  }

  statement {
    sid = "3"
    actions = [
      "ses:SendEmail"
    ]
    resources = ["arn:aws:ses:us-east-1:902118332415:identity/noreply@getbarter.co"]
  }
}


resource "aws_ssoadmin_permission_set_inline_policy" "Developers_DevEnv_Custom_Policy" {
  inline_policy      = data.aws_iam_policy_document.Developers_DevEnv_Custom_Policy.json
  instance_arn       = aws_ssoadmin_permission_set.Developers_DevEnv.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.Developers_DevEnv.arn
}

variable "Developers_ProdEnv_policy_arn" {
  type = list(string)
  default = [
    "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess",
    "arn:aws:iam::aws:policy/AWSCodeDeployReadOnlyAccess",
    "arn:aws:iam::aws:policy/AmazonSESReadOnlyAccess",
    "arn:aws:iam::aws:policy/AmazonSQSReadOnlyAccess",
    "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess",
    "arn:aws:iam::aws:policy/AmazonAPIGatewayAdministrator",
    "arn:aws:iam::aws:policy/IAMReadOnlyAccess",
    "arn:aws:iam::aws:policy/AmazonRDSReadOnlyAccess",
    "arn:aws:iam::aws:policy/AWSElasticBeanstalkReadOnly"
  ]
}
data "aws_iam_policy_document" "Developers_ProdEnv_Custom_Policy" {
  statement {
    sid = "1"
    actions = [
      "cloudformation:CreateStack"
    ]
    resources = ["arn:aws:cloudformation:us-east-1:*:stack/barter-lambda-*"]
  }

  statement {
    sid = "2"
    actions = [
      "iam:CreateUser",
      "iam:CreateRole",
      "iam:DeleteRole",
      "iam:PutRolePolicy",
      "iam:DeleteRolePolicy"
    ]
    resources = ["arn:aws:iam::*:role/barter-lambda-*"]
  }

  statement {
    sid = "3"
    actions = [
      "ses:SendEmail"
    ]
    resources = ["arn:aws:ses:us-east-1:902118332415:identity/noreply@getbarter.co"]
  }
}

resource "aws_ssoadmin_permission_set_inline_policy" "Developers_ProdEnv_Custom_Policy" {
  inline_policy      = data.aws_iam_policy_document.Developers_ProdEnv_Custom_Policy.json
  instance_arn       = aws_ssoadmin_permission_set.Developers_ProdEnv.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.Developers_ProdEnv.arn
} */