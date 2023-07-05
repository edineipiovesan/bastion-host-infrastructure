resource "aws_iam_instance_profile" "this" {
  name = "BastionInstanceProfile"
  role = aws_iam_role.role.name
}

data "aws_iam_policy_document" "role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "role" {
  name               = "BastionRole"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.role.json
}

data "aws_iam_policy" "ssm" {
  name = "AmazonEC2RoleforSSM"
}

resource "aws_iam_role_policy_attachment" "ssm-attach" {
  role       = aws_iam_role.role.name
  policy_arn = data.aws_iam_policy.ssm.arn
}


resource "aws_iam_policy" "eks" {
  name        = "eks-full-access"
  path        = "/"
  description = "Full EKS access"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "eks:*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks-attach" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.eks.arn
}
