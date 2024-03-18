resource "aws_instance" "terpractice" {
    ami = var.ami_id
    instance_type = var.instance_type
    subnet_id = aws_subnet.public_subnet.id
    key_name = var.key_name
    associate_public_ip_address = true
    security_groups = [ aws_security_group.allow_tls.id ]
    tags = {
      Name = "public_instance"
    }
}

resource "aws_instance" "private_instance" {
  ami                          = var.ami_id
  instance_type                = var.instance_type
  subnet_id                    = aws_subnet.private_subnet.id
  key_name                     = var.key_name
  associate_public_ip_address  = false  # Set to false for private instance
  security_groups              = [aws_security_group.allow_tls.id]
  tags = {
    Name = "private_instance"
  }
}

