# get a list of the available az's
data "aws_availability_zones" "available" {
    state = "available"
}