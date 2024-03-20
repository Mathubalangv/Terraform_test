resource "aws_instance" "terpractice" {
  ami           = "ami-013168dc3850ef002"
  instance_type = "t2.micro"             # Old instance type
  key_name      = "Terraform1"
  subnet_id     = "subnet-0e6fc104ccf1cc7f6"     # Old subnet ID


  lifecycle {
    prevent_destroy = false   #Terraform will error when it attempts to destroy a resource when this is set to true
  }
}
