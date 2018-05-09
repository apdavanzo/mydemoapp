module "network" {
  source  = "app.terraform.io/tfe-technical-marketing-demo/network/aws"
  version = "0.1.0"

  region = "us-west-1"
  subnet_availability_zone = "us-west-1c"
  subnet_cidr_block = "172.16.10.0/24"
  vpc_cidr_block = "172.16.0.0/16"
}
provider "aws" {
    region = "${var.aws_region}"
}

resource "aws_instance" "i-010eae58aa1e15108" {
  ami           = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  availability_zone = "${var.aws_region}c"

  tags {
    owner = "Anthony D"
    TTL = 1
  }
  subnet_id = "${module.network.demo_subnet_id}"
}
