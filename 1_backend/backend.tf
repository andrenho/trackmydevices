resource "aws_s3_bucket" "b" {
  bucket = "tmd-bucket"
  acl    = "private"

  tags = {
    Creator = "tf"
  }
}
