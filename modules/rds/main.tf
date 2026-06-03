resource "aws_security_group" "rds_sg" {
  name        = "terraform-rds-sg"
  description = "Allow MySQL access from app servers"
  vpc_id      = var.vpc_id

  ingress {
    description     = "MySQL from App Security Group"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [var.app_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-rds-sg"
  }
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "terraform-rds-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "terraform-rds-subnet-group"
  }
}

resource "aws_db_instance" "mysql" {
  identifier             = "terraform-mysql-db"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  publicly_accessible    = false
  skip_final_snapshot    = true

  tags = {
    Name = "terraform-mysql-db"
  }
}
