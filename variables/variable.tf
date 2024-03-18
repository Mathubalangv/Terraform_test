variable "ami_id" {
  description = "The ID of the AMI to use for the EC2 instances"
  default     = "ami-013168dc3850ef002"
}

variable "instance_type" {
  description = "The type of EC2 instance to launch"
  default     = "t2.micro"
}

variable "key_name" {
  description = "The name of the key pair to use for SSH access"
  default     = "Terraform1"
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr_block" {
  description = "The CIDR block for the public subnet"
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr_block" {
  description = "The CIDR block for the private subnet"
  default     = "10.0.2.0/24"
}

variable "region" {
  description = "The AWS region where the resources will be created"
  default     = "ap-south-1"
}

variable "access_key" {
  description = "The AWS access key"
}

variable "secret_key" {
  description = "The AWS secret key"
}
variable "public_route_cidr_block" {
  description = "CIDR block for the public route table"
  default     = "0.0.0.0/0"
}
