variable "public_key_path" {
  description = <<DESCRIPTION
Path to the SSH public key to be used for authentication.
Ensure this keypair is added to your local SSH agent so provisioners can
connect.
Example: ~/.ssh/terraform.pub
DESCRIPTION
  default     = "~/.ssh/"
}

variable "key_name_1" {
  description = "Desired name of AWS key pair"
  default     = "msiconolfi-aws"
}

variable "aws_region" {
  description = "AWS region to launch servers."
  default     = "ca-central-1"
}
# Tagging Variables
variable "environment-tag" {
  default = "testing"
}
variable "project-tag" {
  default = "Test"
}
variable "owner-tag" {
  default = "MS"
}

#Instance Related Variables
variable "instancetype" {
  default = "t3a.micro"
}

variable "ami" {
  default = "ami-0d0eaed20348a3389"
}

variable "zone_id" {
  default = "Z3TGD4QDDDTP37"
}
