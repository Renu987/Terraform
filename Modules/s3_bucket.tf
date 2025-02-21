provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket"  "my_bucket" {
  bucket = var.bucket_name
  acl    = var.acl_name

  tags = {
    Name        = "my-s3-bucket"
    }
}
