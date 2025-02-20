provider "aws" {
  region = "us-east-1"
}

module "ec2_instance" {
  source = "./modules/ec2_instance"
  
}

module "s3_bucket" {
  source = "./modules/s3-bucket/"

}
