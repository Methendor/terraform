### VPC ###
# create the vpc with 3 private subnets and 3 public subnets.   1 of each in each availability zone
# also create a single NAT gateway to allow the instances in the private subnet to access the internet
# the NAT will have an Elastic IP created for it automatically
# (it is also possible to create a separate NAT for each private subnet to increase availability)
module "vpc" {
    source                  = "terraform-aws-modules/vpc/aws"

    name                    = "${lower(var.stack_name)}-${lower(var.environment_name)}-vpc"
    cidr                    = "10.0.0.0/16"

    azs                     = data.aws_availability_zones.available.names
    private_subnets         = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
    public_subnets          = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

    enable_nat_gateway      = true
    single_nat_gateway      = var.single_nat_gateway
    one_nat_gateway_per_az  = false  
}