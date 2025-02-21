provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "renuka" {
  instance_type = "t2.micro"
  ami = "ami-085ad6ae776d8f09c" # change this
  
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = "renu-sample-24" # change this
}


