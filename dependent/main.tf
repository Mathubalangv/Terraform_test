resource "aws_instance" "terrpractice_depent" {
    ami = "ami-013168dc3850ef002"
    instance_type = "t2.micro"
    key_name = "Terraform1"
  
}

resource "aws_s3_bucket" "terrpractice_depent" {
  bucket = "jdkshg"
  depends_on = [ aws_instance.terrpractice_depent ]
}