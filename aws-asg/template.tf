
//AMI Ubuntu 
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


//Tempplate EC2/ASG

resource "aws_launch_template" "this" {
  name     = "${var.name_template}-${terraform.workspace}"
  image_id = data.aws_ami.ubuntu.id 
  instance_type        = var.instance_type
  key_name             = var.key_name
  user_data            = base64encode("${var.ec2_user_data}")
  //ENI
  network_interfaces {
    device_index    = var.device_index
    security_groups = [var.SecurityGroup_template]
  }
  //Instance Profile(ROLE SSM)
  iam_instance_profile  {
    name = var.instance_profile_name
    }

  tag_specifications {
    resource_type = var.resource_type
    tags = {
      Name = "${var.name_template}-${terraform.workspace}" # Name for the EC2 instances
    }
  }

  
}
