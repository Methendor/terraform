# auto scaling group launch configuration
resource "aws_launch_configuration" "asg-launch-config" {
    image_id        = var.ami
    instance_type   = var.instance_type
    security_groups = [aws_security_group.ec2_sg.id]
    key_name        = var.key_name
    iam_instance_profile = aws_iam_instance_profile.instance_profile.name

    user_data       = templatefile("update_index.sh", { server_name = "${lower(var.stack_name)}-${lower(var.environment_name)}-ec2-asg", bucket_name = aws_s3_bucket.website_bucket.bucket })

    lifecycle {
    create_before_destroy = true
    }
}

# auto scaling group
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
        key                 = "Name"
        value               = "${lower(var.stack_name)}-${lower(var.environment_name)}-asg"
        propagate_at_launch = true
    }
}