variable "aws_region" {
  description = "The AWS region to create resources in"
  type        = string
  default     = "ap-south-1"
}

variable "aws_access_key" {
  description = "AWS Access Key"
  type        = string
  sensitive   = true
}

variable "aws_secret_key" {
  description = "AWS Secret Key"
  type        = string
  sensitive   = true
}
variable "vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}
