data "aws_iam_policy_document" "service_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::257254804006:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "service_role" {
  name               = "ServiceRoleForAutoScaling"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.service_role.json
}

data "aws_iam_policy" "autoscaling" {
  name = "AutoScalingFullAccess"
}

resource "aws_iam_role_policy_attachment" "autoscaling-attach" {
  role       = aws_iam_role.service_role.name
  policy_arn = data.aws_iam_policy.autoscaling.arn
}

data "aws_iam_policy" "kms" {
  name = "AWSKeyManagementServicePowerUser"
}

resource "aws_iam_role_policy_attachment" "kms-attach" {
  role       = aws_iam_role.service_role.name
  policy_arn = data.aws_iam_policy.kms.arn
}

