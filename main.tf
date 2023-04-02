terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.58.0"
    }
  }
}



# Configuration options
provider "aws" {
  region     = "ap-south-1"
  # access_key = var.access_key
  # secret_key = var.secret_key

}

module "aws_vpc" {
  source          = "./modules/aws_vpc"
  vpc_cidr        = var.vpc_cidr
  vpc_tag         = var.vpc_tag
  IGW_tag         = var.IGW_tag
  RT_cidr         = var.RT_cidr
  RT_tag          = var.RT_tag
  Pub_subnet_cidr = var.Pub_subnet_cidr
  Pub_subnet_AZ   = var.Pub_subnet_AZ
  Pub_subnet_tag  = var.Pub_subnet_tag
  Pri_subnet_cidr = var.Pri_subnet_cidr
  Pri_subnet_AZ   = var.Pri_subnet_AZ
  Pri_subnet_tag  = var.Pri_subnet_tag
}

// Calling EC2 Module

module "ec2_module" {
  source        = "./modules/ec2_instance"
  ami_id        = var.ami_id
  instance_type = var.instance_type
  tag           = var.tag
  key           = file("${path.module}/key-tf.pub")
  key_name      = var.key_name
  ports         = var.ports
  SG_tag        = var.SG_tag
  SG_name       = var.SG_name
  vpc_id        = module.aws_vpc.vpc_id
  subnet_id     = module.aws_vpc.Pub_subnet_id
}

