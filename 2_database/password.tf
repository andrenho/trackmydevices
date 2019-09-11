resource "random_password" "db_password" {
  length           = 16
  special          = false
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
