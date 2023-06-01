resource "aws_launch_template" "this" {
  name                                 = "bastion-host"
  description                          = "Instance to access internal kubernetes cluster"
  instance_type                        = var.ec2_instance_type
  disable_api_stop                     = false
  disable_api_termination              = false
  ebs_optimized                        = true
  image_id                             = data.aws_ami.this.image_id
  instance_initiated_shutdown_behavior = "terminate"
  user_data                            = filebase64(data.null_data_source.this.outputs["user_data"])

  block_device_mappings {
    device_name = "/dev/sdx"

    ebs {
      volume_type = "gp3"
      volume_size = 20
      iops        = 3000
      throughput  = 500
      # encrypted             = true
      # kms_key_id            = aws_kms_key.this.arn
      delete_on_termination = true
    }
  }

  iam_instance_profile {
    name = aws_iam_instance_profile.this.name
  }

  instance_market_options {
    market_type = "spot"
    spot_options {
      spot_instance_type             = "one-time"
      instance_interruption_behavior = "terminate"
    }
  }

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_carrier_ip_address = false
    associate_public_ip_address  = false
    delete_on_termination        = true
    subnet_id                    = var.subnet[0]
    security_groups              = [aws_security_group.egress.id]
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "bastion-host"
    }
  }

  metadata_options {
    http_tokens = "required"
  }

  depends_on = [null_resource.user_data]
}