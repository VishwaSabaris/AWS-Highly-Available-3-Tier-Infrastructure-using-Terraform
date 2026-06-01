resource "aws_launch_template" "app_lt" {
  name_prefix   = "terraform-flask-lt-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [var.security_group_id]

  user_data = base64encode(<<-EOF
              #!/bin/bash

              apt update -y
              apt install docker.io -y

              systemctl start docker
              systemctl enable docker

              docker pull ${var.docker_image}

              docker run -d \
                -p 80:5000 \
                --name flask-app \
                ${var.docker_image}
              EOF
  )

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "asg-flask-server"
    }
  }
}

resource "aws_autoscaling_group" "app_asg" {
  name                = "terraform-flask-asg"
  desired_capacity    = var.desired_capacity
  min_size            = var.min_size
  max_size            = var.max_size
  vpc_zone_identifier = var.subnet_ids
  target_group_arns   = [var.target_group_arn]

  launch_template {
    id      = aws_launch_template.app_lt.id
    version = "$Latest"
  }

  health_check_type         = "ELB"
  health_check_grace_period = 300

  tag {
    key                 = "Name"
    value               = "asg-flask-server"
    propagate_at_launch = true
  }
}
resource "aws_autoscaling_policy" "cpu_target_tracking" {
  name                   = "cpu-target-tracking"
  autoscaling_group_name = aws_autoscaling_group.app_asg.name
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 50.0
  }
}
