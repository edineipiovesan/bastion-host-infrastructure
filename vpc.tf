data "aws_subnet" "this" {
  for_each = toset(var.subnet)
  id       = each.value
}