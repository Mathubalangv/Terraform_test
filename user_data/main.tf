provider "aws" {
}

resource "aws_instance" "terpractice" {
    ami = "ami-013168dc3850ef002"
    instance_type = "t2.micro"
    user_data = file("test.sh")
    }
    