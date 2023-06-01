resource "aws_kms_key" "this" {
  description             = "Bastion host KMS key"
  is_enabled              = true
  enable_key_rotation     = true
  deletion_window_in_days = 7
}
