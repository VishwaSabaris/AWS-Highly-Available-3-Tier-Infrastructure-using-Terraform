variable "aws_region" {
  type = string
}

variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "key_name" {
  type = string
}

variable "instance_name" {
  type = string
}

variable "docker_image" {
  type = string
}
variable "instance_count" {
  type = number
}
variable "subnet_ids" {
  type = list(string)
}
