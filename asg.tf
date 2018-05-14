resource "aws_autoscaling_group" "nginx" {
	name = "magento"
	launch_configuration = "${aws_launch_configuration.nginx.name}"
	max_size = "${var.max_size_alb_nginx}"
	min_size = "${var.min_size_alb_nginx}"
	//load_balancers = ["${aws_alb.ALB-Varnish.id}"]
	vpc_zone_identifier = ["${aws_subnet.public1.id}", "${aws_subnet.public2.id}"]
	wait_for_elb_capacity = 1
	tag {
		key = "Name"
		propagate_at_launch = true
		value = "NGINX-${var.project}"
	}
	lifecycle {
		create_before_destroy = true
	}
}

resource "aws_launch_configuration" "nginx" {
	name_prefix = "Magento-"
	image_id = "${data.aws_ami.nginx-ami.id}"
	instance_type = "${var.nginx_instance_type}"
	key_name = "${var.ssh-key}"
	security_groups = ["${aws_security_group.PRO.id}"]
	user_data = "${data.template_file.nginx_userdata.rendered}"

	lifecycle {
		create_before_destroy = true
	}
}

resource "aws_autoscaling_attachment" "asg_attachment" {
  	autoscaling_group_name = "${aws_autoscaling_group.nginx.id}"
  	alb_target_group_arn   = "${aws_alb_target_group.alb-target-group.arn}"
}

data "template_file" "nginx_userdata" {
	template = "${file("templates/userdata.tpl")}"
	vars {
		project = "${var.project}"
	}
}

data "aws_ami" "nginx-ami" {
	owners = ["${var.aws_id}"]

	filter {
    	name   = "state"
    	values = ["available"]
  	}

  	filter {
    	name   = "tag:Name"
    	values = ["workshop_demo"]
  	}

  	most_recent = true
}