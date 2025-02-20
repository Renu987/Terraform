provider "aws" {
  region = "us-east-1"
}

module "ec2_instance" {
  source = "./ec2_instance"
  
}

module "s3_bucket" {
  source = "./s3-bucket"

}
