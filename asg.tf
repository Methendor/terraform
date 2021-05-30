### AUTO SCALING GROUP ###

# set up the configuration for any instances that will be created as per the auto scaling group
# the instance will be configured as per the chosen ami and instance type
# once created, the startup.sh file will be executed, passing it the required variables
resource "aws_launch_configuration" "asg-launch-config" {
    image_id                    = var.ami
    instance_type               = var.instance_type
    security_groups             = [aws_security_group.ec2_sg.id]
    iam_instance_profile        = aws_iam_instance_profile.instance_profile.name

    user_data                   = templatefile("startup.sh", { server_name = "${lower(var.stack_name)}-${lower(var.environment_name)}-ec2-asg" })

    lifecycle {
        create_before_destroy   = true
    }
}

# create the auto scaling group with the above launch configuration.
# the asg will attempt to create the desired_capacity amount of instances in the private subnets by monitoring the load balancer
resource "aws_autoscaling_group" "asg" {
    name_prefix                 = "${lower(var.stack_name)}-${lower(var.environment_name)}-"
    launch_configuration        = aws_launch_configuration.asg-launch-config.id
    vpc_zone_identifier         = module.vpc.private_subnets
    min_size                    = 1
    max_size                    = 5
    desired_capacity            = 1
    health_check_grace_period   = 300

    health_check_type           = "ELB"
    target_group_arns           = [aws_lb_target_group.alb_tg.arn]
    
    tag {
        key                     = "Name"
        value                   = "${lower(var.stack_name)}-${lower(var.environment_name)}-asg"
        propagate_at_launch     = true
    }
}