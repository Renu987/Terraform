resource "aws_instance" "webserver1" {
  ami                    = "ami-053a45fff0a704a47"
  instance_type          = "t2.micro"
  }
resource "aws_s3_bucket" "example" {
  bucket = "renukaterraform2025project"
}
