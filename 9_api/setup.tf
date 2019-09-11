provider "aws" {
  version = "~> 2.0"
  region  = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "tmd-bucket"
    key    = "9_api/state"
    region = "us-east-1"
  }
}
