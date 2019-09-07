resource "aws_db_subnet_group" "rds" {
  name       = "rds_subnet_group"
  subnet_ids = ["${aws_subnet.private_a.id}", "${aws_subnet.private_b.id}"]
}

resource "aws_security_group" "rds" {
  name = "rds_sg"
  vpc_id = "${aws_vpc.main.id}"
  ingress {
    cidr_blocks = ["0.0.0.0/0"]   # TODO
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "database" {
  allocated_storage    = "20"
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "11.4"
  instance_class       = "db.t2.micro"
  name                 = "tmd"
  username             = "tmd"
  password             = "admin123" # TODO
  db_subnet_group_name = "${aws_db_subnet_group.rds.name}"
  vpc_security_group_ids = ["${aws_security_group.rds.id}"]
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]
  tags = {
    Name    = "database"
    Creator = "backend"
  }
}
