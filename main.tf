terraform {
	required_version = ">= 0.11.3"
	backend "s3" { // can't use variables here
		bucket = "terraform-state-nacho"
		region = "eu-west-1"
		key = "states-tfstate"
		dynamodb_table = "terraform-lockin"
		profile = "nacho"
	}
}

provider "aws" {
	version = "~> 1.9.0"
	region = "${var.region}"
	allowed_account_ids = ["${var.aws_id}"]
	profile = "${var.profile}"
}

data "aws_availability_zones" "az" {}