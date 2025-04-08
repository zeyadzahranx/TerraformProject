data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"] # Official AWS AMI owner

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}
