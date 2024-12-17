 variable "vpc_cidr" {
    description = "cidr value"
    type = string
    default = "10.0.0.0/16"
   
 }

variable "environment" {
    description = "environment"
    type = string
    default = "staging"
  
}

variable "public_subnet_cidr" {
    description = "public_subnet_cidr"
    type = string
    default = "10.0.1.0/24"
  
}


variable "availability_zones" {
    description = "AZ"
    default = ["ap-south-1a","ap-south-1b"]
     
}
variable "private_subnet_cidr" {
    description = "public_subnet_cidr"
    default = ["10.0.2.0/24","10.0.3.0/24"]
}