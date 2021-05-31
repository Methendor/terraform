variable "aws_region" {
    description     = "aws region to be used for all objects"
    default         = "eu-west-2"
}

variable "ami" {
    description     = "the amazon Machine Image to be used to create the ec2 instances"
    default         = ""
}

variable "instance_type" {
    description     = "the instance type to be used for ec2 instances"
    default         = ""
}

variable "single_nat_gateway" {
    description     = "boolean to specify multiple NAT gateways or a single NAT gateway"
    default         = ""
}

variable "desired_asg_instances" {
    description     = "The number of instances the ASG will deploy"
    default         = ""
}

variable "stack_name" {
    description     = "common prefix for all resource names"
    default         = "methendor"
}

variable "environment_name" {
    description     = "name of the environment to deploy into. set by vars/*/env_vars.tfvars"
    default         = ""
}