#create VPC
resource "aws_vpc" "terpractice" {
  cidr_block = var.vpc_cidr_block  # Define the CIDR block for the VPC
  tags = {
    Name = "MyVPC"  # Tag the VPC with a name for identification
  }
}

#create subnets
# Public Subnet
resource "aws_subnet" "public_subnet" {
  cidr_block = var.public_subnet_cidr_block  # Define the CIDR block for the public subnet
  vpc_id     = aws_vpc.terpractice.id  # Reference the VPC to associate the subnet with
  map_public_ip_on_launch = true  # Enable auto-assignment of public IP addresses for instances launched in this subnet
}

# Private Subnet
resource "aws_subnet" "private_subnet" {
  cidr_block = var.private_subnet_cidr_block  # Define the CIDR block for the private subnet
  vpc_id     = aws_vpc.terpractice.id  # Reference the VPC to associate the subnet with
}

#create route table and provide path IG to RT (edit routes)
# Public Route Table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.terpractice.id  # Reference the VPC to associate the route table with

  route {
    cidr_block = var.public_route_cidr_block  # Define the destination CIDR block for the route (all traffic)
    gateway_id = aws_internet_gateway.terpractice.id  # Reference the Internet Gateway to route internet-bound traffic
  }
}

# Private Route Table
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.terpractice.id  # Reference the VPC to associate the route table with
}

#associate RT to subnets
# Associate Public Route Table with Public Subnet
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id  # Reference the public subnet
  route_table_id = aws_route_table.public_route_table.id  # Reference the public route table
}

# Associate Private Route Table with Private Subnet
resource "aws_route_table_association" "private_subnet_association" {
  subnet_id      = aws_subnet.private_subnet.id  # Reference the private subnet
  route_table_id = aws_route_table.private_route_table.id  # Reference the private route table
}

#create IG and attach to VPC
resource "aws_internet_gateway" "terpractice" {
  vpc_id = aws_vpc.terpractice.id  # Reference the VPC to attach the Internet Gateway to
}

# Define Security Group
resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"  # Name of the security group
  vpc_id      = aws_vpc.terpractice.id  # Reference the VPC to associate the security group with

  tags = {
    Name = "terpractice_sg"  # Tag the security group for identification
  }

  ingress {
    description = "TLS from VPC"  # Description for the ingress rule
    from_port   = 80  # Allowed incoming traffic port range
    to_port     = 80  # Allowed incoming traffic port range
    protocol    = "tcp"  # Allowed protocol
    cidr_blocks = ["0.0.0.0/0"]  # CIDR blocks to allow traffic from (anywhere in this case)
  }

  ingress {
    description = "SSH from VPC"  # Description for the ingress rule
    from_port   = 22  # Allowed incoming traffic port range
    to_port     = 22  # Allowed incoming traffic port range
    protocol    = "tcp"  # Allowed protocol
    cidr_blocks = ["0.0.0.0/0"]  # CIDR blocks to allow traffic from (anywhere in this case)
  }

  egress {
    from_port   = 0  # Allowed outgoing traffic port range
    to_port     = 0  # Allowed outgoing traffic port range
    protocol    = "-1"  # Allowed protocol (-1 means all)
    cidr_blocks = ["0.0.0.0/0"]  # CIDR blocks to allow traffic to (anywhere in this case)
  }
}
