
resource "aws_vpc" "vpc_test" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.vpc_tag}"
  }
}

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.vpc_test.id
  tags = {
    Name = "${var.IGW_tag}"
  }
}

resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.vpc_test.id
  route {
    cidr_block = var.RT_cidr
    gateway_id = aws_internet_gateway.IGW.id
  }
  tags = {
    Name = "${var.RT_tag}"
  }
}

resource "aws_subnet" "subnet_pub" {
  vpc_id            = aws_vpc.vpc_test.id
  cidr_block        = var.Pub_subnet_cidr
  availability_zone = var.Pub_subnet_AZ
  
  tags = {
    Name = "${var.Pub_subnet_tag}"
  }
}
resource "aws_subnet" "subnet_Pri" {
  vpc_id            = aws_vpc.vpc_test.id
  cidr_block        = var.Pri_subnet_cidr
  availability_zone = var.Pri_subnet_AZ
  tags = {
    Name = "${var.Pri_subnet_tag}"
  }
}


resource "aws_route_table_association" "Public_RT_association" {
  subnet_id      =aws_subnet.subnet_pub.id
  route_table_id = aws_route_table.RT.id
}

output "vpc_id" {
  value = aws_vpc.vpc_test.id
}

output "Pub_subnet_id" {
  value = aws_subnet.subnet_pub.id
}

// terraform plan -var-file=variables.tfvars
