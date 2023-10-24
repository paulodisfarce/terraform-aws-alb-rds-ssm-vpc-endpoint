// Role EC2
resource "aws_iam_role" "ec2_role" {
  name = var.name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

//Attachment AmazonSSMManagedInstanceCore on IAM Role
resource "aws_iam_role_policy_attachment" "ec2_role_policy" {
  policy_arn = var.policy_arn
  role       = aws_iam_role.ec2_role.name
}

//Instance Profile with EC2 associate
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = var.name_profile

  role = aws_iam_role.ec2_role.name
}
