terraform {
  backend "s3" {
    bucket         = "new-statefile"
    key            = "w10/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    use_lockfile = false
    //dynamodb_table = "state-lock"
  }
}
