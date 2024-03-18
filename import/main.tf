resource "aws_instance" "ters" {
ami = "ami-013168dc3850ef002"
instance_type = "t2.micro"
tags = {
  Name = "Import"
}

}