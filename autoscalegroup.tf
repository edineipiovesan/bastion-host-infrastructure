locals {
  availability_zones = data.aws_subnet.this[var.subnet[0]].availability_zone
}

resource "aws_autoscaling_group" "this" {
  availability_zones      = [local.availability_zones]
  desired_capacity        = 1
  max_size                = 1
  min_size                = 1
  health_check_type       = "EC2"
  service_linked_role_arn = data.aws_iam_role.service_linked_role.arn

  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }
}

data "aws_iam_role" "service_linked_role" {
  name = "AWSServiceRoleForAutoScaling"
}