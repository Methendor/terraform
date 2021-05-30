variable "aws_region" {
    description     = "aws region to be used for all objects"
    default         = "eu-west-2"
}

variable "ami" {
    description     = "the amazon Machine Image to be used to create the ec2 instances"
    default         = "ami-080a9d82842161a72"
}

variable "instance_type" {
    description     = "the instance type to be used for ec2 instances"
    default         = "t2.nano"
}

variable "stack_name" {
    description     = "common prefix for all resource names"
    default         = "alan"
}

variable "environment_name" {
    description     = "name of the environment to deploy into. set by vars/*/env_vars.tfvars"
    default         = ""
}