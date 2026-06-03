resource "aws_security_group" "terraform_sg" {
  name        = var.sg_name
  description = "Allow SSH and HTTP access"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH Access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr
  }

  ingress {
    description = "HTTP Access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.allowed_cidr
  }

  tags = {
    Name = var.sg_name
  }
}
