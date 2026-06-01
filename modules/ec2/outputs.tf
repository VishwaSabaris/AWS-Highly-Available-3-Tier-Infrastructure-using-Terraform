output "instance_ids" {
  value = aws_instance.my_server[*].id
}

output "public_ips" {
  value = aws_instance.my_server[*].public_ip
}
