variable "workernode_ami" {
  description = "AMI ID for the Jenkins server"
  type        = string
  default     = "ami-09b0a86a2c84101e1"
}

variable "instance_type" {
  description = "Instance type for the Jenkins server"
  type        = string
  default     = "t2.micro"
}


variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "private_subnet_id" {
  description = "The ID of the public subnet"
  type        = list(string)
}



variable "security_group_id" {
  description = "The ID of the security group"
  type        = string
}
