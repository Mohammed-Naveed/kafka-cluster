resource "aws_vpc" "main" {
    cidr_block = "172.31.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support = true
 
    tags = {
        Name = var.VPC_name
    }
}

resource "aws_subnet" "public-subnet" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "172.31.16.0/20"
  availability_zone = "eu-west-1a"
 
  tags = {
    Name = var.bigdata_Publicsubnet
  }
}
resource "aws_internet_gateway" "gateway" {
  vpc_id = "${aws_vpc.main.id}"
 
  tags = {
    Name = var.gateway_name
  }
}
resource "aws_route_table" "public-routing-table" {
  vpc_id = "${aws_vpc.main.id}"
 
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gateway.id}"
  }
 
  tags = {
    Name = var.gateway_name
  }
}
resource "aws_route_table_association" "public-route-association" {
  subnet_id      = "${aws_subnet.public-subnet.id}"
  route_table_id = "${aws_route_table.public-routing-table.id}"
}