resource "aws_vpc" "mainvpc" {
  cidr_block = "10.0.0.0/16"
}
resource "aws_subnet" "sub1" {
  cidr_block = "10.0.1.0/24"
  vpc_id = aws_vpc.mainvpc.id
  tags = {
    name = "privatesubnet1"
  }
}
resource "aws_subnet" "sub2" {
  cidr_block = "10.0.2.0/24"
  vpc_id = aws_vpc.mainvpc.id
  tags = {
    name = "privatesubnet2"
  }
}
resource "aws_subnet" "sub3" {
  cidr_block = "10.0.3.0/24"
  vpc_id = aws_vpc.mainvpc.id
  tags = {
    name = "publicsubnet1"
  }
}
resource "aws_subnet" "sub4" {
    cidr_block = "10.0.4.0/24"
  vpc_id = aws_vpc.mainvpc.id
  tags = {
  name = "publicsubnet2"
}
}
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.mainvpc.id
}
resource "aws_route_table" "rt" {
vpc_id = aws_vpc.mainvpc.id
route  {
gateway_id = aws_internet_gateway.IGW.id
cidr_block = "0.0.0.0/0"
}
}
resource "aws_route_table_association" "rtassoc1" {
  route_table_id = aws_route_table.rt.id
  subnet_id = aws_subnet.sub1.id
}
resource "aws_route_table_association" "rtassoc2" {
  route_table_id = aws_route_table.rt.id
  subnet_id = aws_subnet.sub2.id
}
resource "aws_route_table_association" "rtassoc3" {
  route_table_id = aws_route_table.rt.id
  subnet_id = aws_subnet.sub3.id
}
resource "aws_route_table_association" "rtassoc4" {
  route_table_id = aws_route_table.rt.id
  subnet_id = aws_subnet.sub4.id
}
resource "aws_instance" "testinstance" {
  instance_type = "t2.micro"
  ami = "06b21ccaeff8cd686"
  subnet_id = aws_subnet.sub4.id
}