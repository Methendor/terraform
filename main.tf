data "aws_iam_policy_document" "instance_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "instance_role" {
  name                = "instance-role"
  assume_role_policy  = data.aws_iam_policy_document.instance_assume_role_policy.json
  managed_policy_arns = [aws_iam_policy.policy_one.arn, aws_iam_policy.policy_two.arn, aws_iam_policy.policy_three.arn]
}

resource "aws_iam_policy" "policy_one" {
  name = "policy-1"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["ec2:Describe*"]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_policy" "policy_two" {
  name = "policy-2"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["s3:*"]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_policy" "policy_three" {
  name = "policy-3"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["ssmmessages:CreateControlChannel","ssmmessages:CreateDataChannel", "ssmmessages:OpenControlChannel", "ssmmessages:OpenDataChannel", "ssm:*"]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "instance_profile"
  role = aws_iam_role.instance_role.name
}

resource "aws_s3_bucket" "website_bucket" {
  bucket = "${lower(var.stack_name)}-${lower(var.environment_name)}-website-bucket"
  acl    = "private"

  tags = {
    Name        = "${lower(var.stack_name)}-${lower(var.environment_name)}-website-bucket"
    Environment = var.environment_name
  }
}

resource "aws_s3_bucket_object" "object1" {
    for_each = fileset("website/", "*")
    bucket = aws_s3_bucket.website_bucket.id
    key = each.value
    source = "website/${each.value}"
    etag = filemd5("website/${each.value}")
}