###########################################
########### Security Group Rabbit #########
###########################################

resource "aws_security_group" "internal_sg" {
  name        = "Internal Application"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.vpc.id
  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name        = "Private Subnet 1b"
    environment = var.environment-tag
    project     = var.project-tag
    owner       = var.owner-tag
  }
}

resource "aws_security_group" "web_sg" {
  name        = "Web Application"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.vpc.id
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["24.50.34.58/32"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name        = "Private Subnet 1b"
    environment = var.environment-tag
    project     = var.project-tag
    owner       = var.owner-tag
  }
}