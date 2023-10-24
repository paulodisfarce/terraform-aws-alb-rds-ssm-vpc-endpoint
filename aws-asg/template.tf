# Create IAM role for EC2 instance
resource "aws_iam_role" "ec2_role" {
  name = "EC2_SSM_Role_TF"

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

# Attach AmazonSSMManagedInstanceCore policy to the IAM role
resource "aws_iam_role_policy_attachment" "ec2_role_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.ec2_role.name
}

# Create an instance profile for the EC2 instance and associate the IAM role
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "EC2_SSM_Instance_Profile"

  role = aws_iam_role.ec2_role.name
}


data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_launch_template" "this" {
  name     = "${var.name_template}-${terraform.workspace}"
  image_id = data.aws_ami.ubuntu.id #"ami-041feb57c611358bd"
  #data.aws_ami.ubuntu.id
  instance_type        = var.instance_type
  key_name             = var.key_name
  user_data            = base64encode("${var.ec2_user_data}")
  //ENI
  network_interfaces {
    device_index    = var.device_index
    security_groups = [var.SecurityGroup_template]
  }
  iam_instance_profile  {
    name = aws_iam_instance_profile.ec2_instance_profile.name
    }

  tag_specifications {
    resource_type = var.resource_type
    tags = {
      Name = "${var.name_template}-${terraform.workspace}" # Name for the EC2 instances
    }
  }

  
}
