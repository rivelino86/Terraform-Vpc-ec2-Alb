variable "ENVIRONMENT" {
  default = "dev"
  type = string
}

variable "REGION" {
  default = "us-east-1"
  type = string

}

variable "INSTANCE_TYPE" {
  type = string
  default = "t2.micro"

}