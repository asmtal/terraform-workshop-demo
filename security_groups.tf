resource "aws_security_group" "ALB-Pro" {
	name = "ALB-PRO"
	vpc_id = "${aws_vpc.vpc.id}"
	ingress {
		from_port = 80
		protocol = "tcp"
		to_port = 80
		cidr_blocks = ["0.0.0.0/0"]
	}
	ingress {
		from_port = 443
		protocol = "tcp"
		to_port = 443
		cidr_blocks = ["0.0.0.0/0"]
	}
	egress {
		from_port = 0
		protocol = "-1"
		to_port = 0
		cidr_blocks = ["0.0.0.0/0"]
	}
}

resource "aws_security_group" "PRO" {
	name = "PRO"
	vpc_id = "${aws_vpc.vpc.id}"
	ingress {
		from_port = 80
		protocol = "tcp"
		to_port = 80
		cidr_blocks = ["0.0.0.0/0"]
	}

	ingress {
		from_port = 22
		protocol = "tcp"
		to_port = 22
		cidr_blocks = ["0.0.0.0/0"]
	}

	egress {
		from_port = 0
		protocol = "-1"
		to_port = 0
		cidr_blocks = ["0.0.0.0/0"]
	}
}
