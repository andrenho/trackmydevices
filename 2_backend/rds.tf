resource "aws_db_subnet_group" "rds" {
  name       = "rds_subnet_group"
  subnet_ids = ["${aws_subnet.public_a.id}", "${aws_subnet.public_b.id}"]
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

resource "random_password" "db_password" {
  length           = 16
  special          = false
}

resource "aws_db_instance" "database" {
  allocated_storage    = "20"
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "11.4"
  instance_class       = "db.t2.micro"
  name                 = "tmd"
  username             = "tmd"
  password             = "${random_password.db_password.result}"
  db_subnet_group_name = "${aws_db_subnet_group.rds.name}"
  vpc_security_group_ids = ["${aws_security_group.rds.id}"]
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]
  tags = {
    Name    = "database"
    Creator = "backend"
  }
}

resource "aws_route53_record" "rds" {
  zone_id = "${data.aws_route53_zone.main.zone_id}"
  name    = "db.tmd.gamesmith.co.uk."
  type    = "CNAME"
  ttl     = 300
  records = ["${aws_db_instance.database.address}"]
}

resource "aws_ssm_parameter" "db_password" {
  name        = "db_password"
  description = "RDS database password"
  type        = "SecureString"
  value       = "${random_password.db_password.result}"
  tags = {
    Name    = "db_password"
    Creator = "backend"
  }
}
