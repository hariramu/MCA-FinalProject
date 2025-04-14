resource "aws_autoscaling_group" "asg" {
  name                      = "web-asg"
  vpc_zone_identifier       = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id]
  desired_capacity          = 1
  min_size                  = 1
  max_size                  = 3
  health_check_type         = "EC2"
  health_check_grace_period = 300
  launch_template {
    id      = aws_launch_template.lt.id
    version = "$Latest"
  }
  target_group_arns = [aws_lb_target_group.tg.arn]
}

resource "aws_autoscaling_policy" "scale_up" {
  name                   = "scale-up-policy"
  scaling_adjustment     = 3
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 60
  autoscaling_group_name = aws_autoscaling_group.asg.name
}
