resource "aws_s3_bucket" "b" {
  bucket = "tmd-deploy"
  acl    = "private"
  force_destroy = true
}
