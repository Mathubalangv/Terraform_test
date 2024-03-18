output "public" {
    value = aws_instance.terpractice.public_ip
    sensitive = true
  
}
output "private" {
    value = aws_instance.terpractice.private_ip
  
}