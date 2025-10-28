variable "instance_type" {
    type = string
    default = "t3.micro"
}

variable "region" {
    type = string
    default = "eu-north-1"
}

variable "instance_count" {
    type = number
    default = 3
}

variable "key_name" {
    type = string
    default = "opentofu-amad-key"
}

variable "ssh_public_key_path" {
    type = string
    default = "~/.ssh/id_rsa.pub"
}

#variable "ami" {
#  type = string
#  default = "ami-07e075f00c26b085a"
#}