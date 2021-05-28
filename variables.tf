variable "aws_region" {
  default = "eu-west-2"
}

variable "ami" {
    default = "ami-080a9d82842161a72"
}

variable "key_name" {
  default = "terraform-key"
}

variable "instance_type" {
    default = "t2.nano"
}

variable "instance_count" {
    default = 1
}

variable "stack_name" {
  description = "common prefix for all resource names"
  default = "alan"
}

variable "environment_name" {
  description = "name of the environment to deploy into"
  default = ""
}