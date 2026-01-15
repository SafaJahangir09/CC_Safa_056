variable "region" {
  default = "me-central-1"
}

variable "availability_zone" {
  default = "me-central-1a"
}

variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
  default = "10.0.1.0/24"
}

variable "env_prefix" {
  default = "labproj"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "public_key_path" {
  default = "~/.ssh/id_ed25519.pub"
}

variable "private_key_path" {
  default = "~/.ssh/id_ed25519"
}

