# Define the AWS provider configuration.
provider "aws" {
  region = "ap-south-1"  # Replace with your desired AWS region.
}


resource "aws_key_pair" "example" {
  key_name   = "provisioner"  # Replace with your desired key name
  public_key = file("C:/Users/Admin/.ssh/terraform1.pub") 
}

resource "aws_instance" "terpractice" {
    ami = "ami-013168dc3850ef002"
    instance_type = "t2.micro"
    key_name = "Terraform1"
    associate_public_ip_address = true
    tags = {
      Name = "public_instance"
    }
connection {
    type        = "ssh"
    user        = "ec2-user"  # Replace with the appropriate username for your EC2 instance
    # private_key = file("C:/Users/veerababu/.ssh/id_rsa")
    private_key = file("C:/Users/Admin/.ssh/terraform1.pem")  #private key path
    host        = self.public_ip
  }

  # local execution procee 
 provisioner "local-exec" {
    command = "touch file500"
   
 }
  # File provisioner to copy a file from local to the remote EC2 instance
  provisioner "file" {
    source      = "file500"  # Replace with the path to your local file
    destination = "/home/ec2-user/file10"  # Replace with the path on the remote instance
  }
  # remote execution process 
  provisioner "remote-exec" {
    inline = [
"touch file200",
"echo hello from aws >> file200",
]
 }

}