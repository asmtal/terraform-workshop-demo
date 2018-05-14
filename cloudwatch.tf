# Metrics
resource "aws_cloudwatch_dashboard" "ec2-metrics" {
	dashboard_name = "EC2-Metrics"
	dashboard_body = <<EOF
	{
		"widgets": [
		{
        	"type":"metric",
        	"x":0,
			"y":0,
        	"width":12,
        	"height":6,
        	"properties":{
            	"metrics":[
            		[
						"AWS/EC2",
                   		"CPUUtilization",
                   		"AutoScalingGroupName",
                   		"${aws_autoscaling_group.nginx.name}"
                	]
             	],
				"period":60,
				"stat":"Average",
				"region":"${var.region}",
				"title":"ASG EC2-${var.project}-Pro CPU"
			}
		}
		]
	}
	EOF
}

# Alarms & Autoscaling policy
resource "aws_autoscaling_policy" "autoscaling_ec2" {
	name                   = "autoscaling-up"
	scaling_adjustment     = "1"
	adjustment_type        = "ChangeInCapacity"
	cooldown               = 130
	autoscaling_group_name = "${aws_autoscaling_group.nginx.name}"
}

resource "aws_cloudwatch_metric_alarm" "autoscaling_ec2" {
	alarm_name          = "${var.project}-EC2-autoscaling"
	comparison_operator = "GreaterThanOrEqualToThreshold"
	evaluation_periods  = "1"
	metric_name         = "CPUUtilization"
	namespace           = "AWS/EC2"
	period              = "60"
	statistic           = "Average"
	threshold           = "45"

	dimensions {
		AutoScalingGroupName = "${aws_autoscaling_group.nginx.name}"
	}

	alarm_description = "This metric monitors ec2 cpu utilization"
	alarm_actions     = ["${aws_autoscaling_policy.autoscaling_ec2.arn}"]
}


resource "aws_autoscaling_policy" "autoscaling_ec2_down" {
	name                   = "autoscaling-down"
	scaling_adjustment     = "-1"
	adjustment_type        = "ChangeInCapacity"
	cooldown               = 900
	autoscaling_group_name = "${aws_autoscaling_group.nginx.name}"
}

resource "aws_cloudwatch_metric_alarm" "autoscaling_ec2_down" {
	alarm_name          = "${var.project}-EC2-autoscaling_down"
	comparison_operator = "LessThanOrEqualToThreshold"
	evaluation_periods  = "10"
	metric_name         = "CPUUtilization"
	namespace           = "AWS/EC2"
	period              = "60"
	statistic           = "Average"
	threshold           = "15"

	dimensions {
		AutoScalingGroupName = "${aws_autoscaling_group.nginx.name}"
	}

	alarm_description = "This metric monitors ec2 cpu utilization"
	alarm_actions     = ["${aws_autoscaling_policy.autoscaling_ec2_down.arn}"]
}
