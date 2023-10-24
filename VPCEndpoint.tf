#resource "aws_ec2_instance_connect_endpoint" "this" {
 # subnet_id          = flatten(aws_subnet.private.*.id)[0]
 # security_group_ids = [aws_security_group.sg-asg.id]
 # preserve_client_ip = false
#}