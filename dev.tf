###########################################
############# EC2 Instances ###############
###########################################
resource "aws_instance" "nginx" {
  ami                         = var.ami
  instance_type               = var.instancetype
  disable_api_termination     = false
  ebs_optimized               = true
  monitoring                  = true
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.publicsubnet1a.id
  key_name                    = var.key_name_1
  user_data                   = file("install-nginx-lb.sh")
  volume_tags = {
    Name = "nginx"
  }
  vpc_security_group_ids = [
    aws_security_group.web_sg.id,
    aws_security_group.internal_sg.id,
  ]
  credit_specification {
    cpu_credits = "unlimited"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo hostnamectl set-hostname node-${aws_instance.nginx.tags.Name}",
    ]
  }
  connection {
    type        = "ssh"
    user        = "ubuntu"
    password    = ""
    host        = aws_instance.nginx.public_ip
    private_key = file("~/.ssh/msiconolfi-aws.pem")
  }
  tags = {
    Name        = "nginx"
    environment = var.environment-tag
    project     = var.project-tag
    owner       = var.owner-tag
  }
}

resource "aws_instance" "app1" {
  ami                     = var.ami
  instance_type           = var.instancetype
  disable_api_termination = false
  ebs_optimized           = true
  monitoring              = true
  associate_public_ip_address = true
  subnet_id               = aws_subnet.publicsubnet1a.id
  key_name                = var.key_name_1
  user_data               = file("install.sh")
  volume_tags = {
    Name = "app1"
  }
  vpc_security_group_ids = [
    aws_security_group.web_sg.id,
    aws_security_group.internal_sg.id,
  ]
  credit_specification {
    cpu_credits = "unlimited"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo hostnamectl set-hostname node-${aws_instance.app1.tags.Name}",
    ]
  }
  connection {
    type        = "ssh"
    user        = "ubuntu"
    password    = ""
    host        = aws_instance.app1.public_ip
    private_key = file("~/.ssh/msiconolfi-aws.pem")
  }
  tags = {
    Name        = "app1"
    environment = var.environment-tag
    project     = var.project-tag
    owner       = var.owner-tag
  }
}
resource "aws_instance" "app2" {
  ami                     = var.ami
  instance_type           = var.instancetype
  disable_api_termination = false
  ebs_optimized           = true
  monitoring              = true
  associate_public_ip_address = true
  subnet_id               = aws_subnet.publicsubnet1b.id
  key_name                = var.key_name_1
  user_data               = file("install.sh")
  volume_tags = {
    Name = "app2"
  }
  vpc_security_group_ids = [
    aws_security_group.web_sg.id,
    aws_security_group.internal_sg.id,
  ]
  credit_specification {
    cpu_credits = "unlimited"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo hostnamectl set-hostname node-${aws_instance.app2.tags.Name}",
    ]
  }
  connection {
    type        = "ssh"
    user        = "ubuntu"
    password    = ""
    host        = aws_instance.app2.public_ip
    private_key = file("~/.ssh/msiconolfi-aws.pem")
  }
  tags = {
    Name        = "app2"
    environment = var.environment-tag
    project     = var.project-tag
    owner       = var.owner-tag
  }
}