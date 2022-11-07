terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-west-1"
}

resource "aws_vpc" "YaelAtadgi-dev-vpc" {
  cidr_block = "10.0.0.0/24"
  tags = {
    Name = "YaelAtadgi-dev-vpc"
  }
}

resource "aws_subnet" "YaelAtadgi-k8s-subnet" {
  vpc_id     = aws_vpc.YaelAtadgi-dev-vpc.id
  cidr_block = "10.0.0.0/27"

  tags = {
    Name = "YaelAtadgi-k8s-subnet"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.YaelAtadgi-dev-vpc.id

  tags = {
    Name = "gateway"
  }
}

resource "aws_route" "routeIGW" {
  route_table_id         = aws_vpc.YaelAtadgi-dev-vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}
