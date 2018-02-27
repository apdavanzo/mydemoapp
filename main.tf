module "network" {
  source  = "atlas.hashicorp.com/fpollock-demo/network/aws"
  version = "0.0.9"

  region = "us-west-1"
  subnet_availability_zone = "us-west-1a"
}

provider "aws" {
    region = "${var.aws_region}"
}

resource "aws_instance" "foo" {
  ami           = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  availability_zone = "${var.aws_region}a"

  tags {
    owner = "Adam C"
    TTL = 1
  }
  subnet_id = "${module.network.demo_subnet_id}"
}
