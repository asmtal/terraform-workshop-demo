resource "aws_alb" "ALB" {
	name            = "ALB"
	internal        = false
	security_groups = ["${aws_security_group.ALB-Pro.id}"]
	subnets			= ["${aws_subnet.public1.id}", "${aws_subnet.public2.id}"]
	enable_deletion_protection = false
}

resource "aws_alb_target_group" "alb-target-group" {
	name     = "alb-target-group"
	port     = 80
	protocol = "HTTP"
	vpc_id   = "${aws_vpc.vpc.id}"

	health_check {
		healthy_threshold   = "2"
		unhealthy_threshold = "2"
		timeout             = "3"
		path                = "/"
		interval            = "5"
  	}
}

resource "aws_alb_listener" "alb-listener" {
	load_balancer_arn = "${aws_alb.ALB.arn}"
	port = "80"
	protocol = "HTTP"

	default_action {
		target_group_arn = "${aws_alb_target_group.alb-target-group.arn}"
		type = "forward"
	}
}
