resource "aws_security_group" "egress" {
  name        = "egress-traffic"
  description = "Allow outbound traffic"
  vpc_id      = var.vpc

  egress {
    description      = "Enable full internet access"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}