
resource "aws_instance" "terrpractice" {
ami =data.aws_ami.amzlinux.id
instance_type = "t2.micro"
subnet_id = data.aws_subnet.public_subnet.id
security_groups = [data.aws_security_group.allow_tls.id]
tags = {
  Name = "instance from datatf"
}
  
}