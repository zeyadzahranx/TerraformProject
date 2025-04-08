terraform {
  backend "s3" {
    bucket         = "zeyad-s-dev-backend" 
    key            = "dev/terraform.tfstate"
    region         = "us-east-1" # the default region
    dynamodb_table = "zeyad-s-dev-lock" 
    encrypt        = true
  }
}