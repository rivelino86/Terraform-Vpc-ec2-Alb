# resource "aws_security_group" "sg1" {
#   name        = "Testing-sg1"
#   description = "Allow ssh and httpd"
#   vpc_id      = aws_vpc.vpc1.id


#   ingress {
#     description = "allow http"
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   tags = {
#     env = "Dev"
#   }


# }
# resource "aws_security_group" "sg2" {
#   name        = "Terraform-sg-lb"
#   description = "Allow ssh and httpd"
#   vpc_id      = aws_vpc.vpc1.id


#   ingress {
#     description = "allow http"
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   tags = {
#     env = "Dev"
#   }
# }



resource "aws_security_group" "sg1" {
  name        = "Testing-sg1"
  description = "Allow SSH from trusted IPs and HTTP from specific sources"
  vpc_id      = aws_vpc.vpc1.id

  # Ingress - restricted to specific IPs (replace with your trusted IPs)
  ingress {
    description = "Allow HTTP from trusted IPs"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]  # Replace with your internal subnet or trusted IP
  }

  ingress {
    description = "Allow SSH from admin IPs"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["203.0.113.10/32"]  # Replace with your admin public IP
  }

  # Egress - limit to necessary destinations
  egress {
    description = "Allow all outbound traffic within VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/16"]  # Internal traffic only
  }

  tags = {
    env = "Dev"
  }
}

resource "aws_security_group" "sg2" {
  name        = "Terraform-sg-lb"
  description = "Allow HTTP from internet and restricted SSH"
  vpc_id      = aws_vpc.vpc1.id

  # Ingress - only HTTP from the internet if needed
  ingress {
    description = "Allow HTTP from public"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Required for public-facing LB
  }

  # Optional: restrict SSH to admin IPs
  ingress {
    description = "Allow SSH from admin IPs"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["203.0.113.10/32"]  # Replace with your admin public IP
  }

  # Egress - restrict to internal network if possible
  egress {
    description = "Allow outbound traffic to internal network"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/16"]  # Replace if external access needed
  }

  tags = {
    env = "Dev"
  }
}
