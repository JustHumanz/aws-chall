
variable "vpc_cidr" {
    default = "10.0.0.0/16"
    description = "Default CIDR"
}

variable "public_subnet_cidr" {
    description = "Public Subnet CIDR "
    default = "10.0.0.0/24"
}

variable "private_subnet_cidr" {
    description = "Private Subnet CIDR"
    default = "10.0.1.0/24"
}

variable "pubkey" {
  
}