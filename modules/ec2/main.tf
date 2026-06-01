resource "aws_instance" "my_server" {
  count = var.instance_count

  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [var.security_group_id]

  user_data = <<-EOF
              #!/bin/bash

              apt update -y
              apt install docker.io -y

              systemctl start docker
              systemctl enable docker

              usermod -aG docker ubuntu

              docker pull ${var.docker_image}

              docker run -d \
                -p 80:5000 \
                --name flask-app \
                ${var.docker_image}
              EOF
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = "${var.instance_name}-${count.index + 1}"
  }
}
