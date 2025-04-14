resource "aws_launch_template" "lt" {
  name          = "web-launch-template"
  image_id      = "ami-002f6e91abff6eb96" # Replace with Amazon Linux 2023 AMI ID
  instance_type = "t2.micro"
  key_name      = "Hari"

  network_interfaces {
    subnet_id       = aws_subnet.subnet_1.id
    security_groups = [aws_security_group.alb_sg.id]
    associate_public_ip_address = true
        
  }
  user_data=base64encode(file("userdata.sh"))
  iam_instance_profile {
    
    name = aws_iam_instance_profile.ssm_profile.name
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "WebInstance"
    }
  }
}
