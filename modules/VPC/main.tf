resource "aws_vpc" "myvpc" {
  cidr_block       = var.cidr_block
  instance_tenancy = var.tenancy
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = format("%s-%s-vpc", var.namespace, var.env)
  }
}

#public subnet
resource "aws_subnet" "pub_sub" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = element(var.pub_sub_cidr, count.index)
  availability_zone       = element(var.availability_zone, count.index)
  count                   = length(var.pub_sub_cidr)
  map_public_ip_on_launch = true

  tags = {
    Name = format("pub-%s-%s-%s", var.namespace, var.env, element(var.availability_zone, count.index))
  }
}

#private subnet
resource "aws_subnet" "pvt_sub" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = element(var.pvt_sub_cidr, count.index)
  availability_zone       = element(var.availability_zone, count.index)
  count                   = length(var.pvt_sub_cidr)
  map_public_ip_on_launch = false

  tags = {
    Name = format("pvt-%s-%s-%s", var.namespace, var.env, element(var.availability_zone, count.index))
  }
}

//internet gateway
resource "aws_internet_gateway" "myvpc_ig" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = format("%s-%s-ig", var.namespace, var.env)
  }
}

resource "aws_route_table" "my-rt" {
  vpc_id = "${aws_vpc.myvpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.myvpc_ig.id}"
  }

  tags = {
    Name = "pub_rt"
  }
}

//public subnet association
resource "aws_route_table_association" "pub_rt_association" {
  count          = length(var.pub_sub_cidr)
  subnet_id      = element(aws_subnet.pub_sub.*.id, count.index)
  route_table_id = aws_route_table.my-rt.id
}