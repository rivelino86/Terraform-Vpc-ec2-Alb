terraform {
  backend "s3" {
    bucket         = "veves3"
    key            = "week10/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "state-lock"
  }
}
