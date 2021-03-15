terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "ap-southeast-1"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "default-vpc"
  cidr = var.vpc_cidr

  azs             = ["ap-southeast-1a"]
  private_subnets = [var.private_subnet_cidr]
  public_subnets  = [var.public_subnet_cidr]

  single_nat_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}


module "autoscale_group" {
  source = "cloudposse/ec2-autoscale-group/aws"
  # Cloud Posse recommends pinning every module to a specific version
  # version = "x.x.x"
  name                        = "t2-medium-autoscale"

  image_id                    = "ami-01581ffba3821cdf3" #Ubuntu 20.04
  instance_type               = "t2.medium"
  security_group_ids          = [module.vpc.default_security_group_id]
  subnet_ids                  = [module.vpc.private_subnets[0]]
  health_check_type           = "EC2"
  key_name                    = aws_key_pair.humanz-key.key_name
  min_size                    = 2
  max_size                    = 5
  wait_for_capacity_timeout   = "5m"
  associate_public_ip_address = false

  # Auto-scaling policies and CloudWatch metric alarms
  autoscaling_policies_enabled           = "true"
  cpu_utilization_high_threshold_percent = "45"
}

resource "aws_key_pair" "humanz-key" {
  key_name = "Humanz"
  public_key = var.pubkey
}