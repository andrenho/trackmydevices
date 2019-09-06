resource "aws_s3_bucket" "b" {
  bucket = "tmd-bucket"
  acl    = "private"
  force_destroy = true

  tags = {
    Creator = "tf"
  }
}
