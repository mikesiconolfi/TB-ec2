resource "aws_route53_record" "app1-dns" {
  zone_id = var.zone_id
  name    = "web1.siconolfi.ca"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.app1.public_ip]
}
resource "aws_route53_record" "app2-dns" {
  zone_id = var.zone_id
  name    = "web2.siconolfi.ca"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.app2.public_ip]
}
resource "aws_route53_record" "nginx-dns" {
  zone_id = var.zone_id
  name    = "nginx.siconolfi.ca"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.nginx.public_ip]
}