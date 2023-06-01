################
## PROVIDER   ##
################
variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "us-east-1"
}

################
## NETWORKING ##
################
variable "vpc" {
  type        = string
  description = "VPC"
}

variable "subnet" {
  type        = list(string)
  description = "Subnets"
}

################
## COMPUTING ##
################
variable "ec2_instance_type" {
  type        = string
  description = "EC2 instance type"
}
