#Servers
output "nginx" {
  description = "The ID of the qa-box1"
  value       = aws_instance.nginx
}
output "app1" {
  description = "The ID of the qa-box1"
  value       = aws_instance.app1
}
output "app2" {
  description = "The ID of the qa-box1"
  value       = aws_instance.app2
}

#VPC Settings
output "vpc" {
  description = "The ID of the vpc"
  value       = aws_vpc.vpc
}
output "privatesubnet1b" {
  description = "The ID of the privatesubnet1b"
  value       = aws_subnet.privatesubnet1b
}
output "privatesubnet1a" {
  description = "The ID of the privatesubnet1a"
  value       = aws_subnet.privatesubnet1a
}
output "publicsubnet1a" {
  description = "The ID of the publicsubnet1a"
  value       = aws_subnet.publicsubnet1a
}
output "publicsubnet1b" {
  description = "The ID of the publicsubnet1b"
  value       = aws_subnet.publicsubnet1b
}
output "privatert" {
  description = "The ID of the privatert"
  value       = aws_route_table.privatert
}
output "publicrt" {
  description = "The ID of the publicrt"
  value       = aws_route_table.publicrt
}
output "igw" {
  description = "The ID of the igw"
  value       = aws_internet_gateway.igw
}
output "nat_eip" {
  description = "The ID of the nat-eip"
  value       = aws_eip.nat-eip
}
output "nat_gw" {
  description = "The ID of the natgw"
  value       = aws_nat_gateway.natgw
}