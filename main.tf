//--------------------------------------------------------------------
// Variables
variable "network_subnet_cidr_block" {}
variable "network_vpc_cidr_block" {}

//--------------------------------------------------------------------
// Modules
module "network" {
  source  = "atlas.hashicorp.com/fpollock-demo/network/aws"
  version = "0.0.9"

  region = "us-west-1"
  subnet_availability_zone = "us-west-1a"
  subnet_cidr_block = "${var.network_subnet_cidr_block}"
  vpc_cidr_block = "${var.network_vpc_cidr_block}"
}

provider "aws" {
    region = "${var.aws_region}"
}

resource "aws_instance" "foo" {
  ami           = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  availability_zone = "${var.aws_region}a"

  tags {
    owner = "Adam"
    TTL = 1
  }
  subnet_id = "${module.network.demo_subnet_id}"
}