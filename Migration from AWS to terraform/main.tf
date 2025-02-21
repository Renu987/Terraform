provider "aws" {
  region = "us-east-1"
}

import {
  
  id = "i-0136b804296d5a6b4" #ec2-instnaceid

  to = aws_instance.example
}
