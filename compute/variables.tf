variable "key_pair_name" {
    type = string
    default = "terraform_ec2_key"
}

variable "sg_bastion" {
    type = string
}

variable "PublicSubnetA" {
    type = string
}

variable "PublicSubnetB" {
    type = string
}

variable "PublicSubnetC" {
    type = string
}

variable "sg_appServers" {
    type = string
}

variable "AppA" {
    type = string
}

variable "AppB" {
    type = string
}

variable "AppC" {
    type = string
}