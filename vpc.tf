data "aws_vpc" "this" {
  id = var.vpc
}

data "aws_subnet" "this" {
  for_each = toset(var.subnet)
  id       = each.value
}