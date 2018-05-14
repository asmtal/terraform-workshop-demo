resource "aws_vpc" "vpc" {
	cidr_block = "${var.cidr}"
	enable_dns_hostnames = true
	enable_dns_support = true
	tags {
		Name = "${var.project}-VPC"
		Customer = "${var.project}"
	}
}

resource "aws_subnet" "public1" {
	cidr_block = "${var.public1_cidr}"
	vpc_id = "${aws_vpc.vpc.id}"
	map_public_ip_on_launch = true
	availability_zone = "${data.aws_availability_zones.az.names["${var.az1}"]}"
	tags{
		Name = "public1"
	}
}

resource "aws_subnet" "public2" {
	cidr_block = "${var.public2_cidr}"
	vpc_id = "${aws_vpc.vpc.id}"
	map_public_ip_on_launch = true
	availability_zone = "${data.aws_availability_zones.az.names["${var.az2}"]}"
	tags{
		Name = "public2"
	}
}

resource "aws_internet_gateway" "igw" {
	vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_route" "default_route" {
	route_table_id = "${aws_vpc.vpc.default_route_table_id}"
	destination_cidr_block = "0.0.0.0/0"
	gateway_id = "${aws_internet_gateway.igw.id}"
}

// Route table (Public subnets)
resource "aws_route_table" "public" {
	vpc_id = "${aws_vpc.vpc.id}"

	route {
		cidr_block = "0.0.0.0/0"
		gateway_id = "${aws_internet_gateway.igw.id}"
	}

	tags {
		Name = "public"
		Customer = "${var.project}"
	}
}