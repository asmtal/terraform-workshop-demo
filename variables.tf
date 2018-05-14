// General
variable "profile" {
	type = "string"
	default = "nacho"
}

variable "aws_id" {
	type = "string"
	default = "989404071078"
}

variable "region" {
	type = "string"
	default = "eu-west-1"
}

variable "project" {
	type = "string"
	default = "nacho"
}

variable "ssh-key" {
	type = "string"
	default = "nacho-ec2-01"
}

// ALB
variable "max_size_alb_nginx" {
	type = "string"
	default = "3"
}

variable "min_size_alb_nginx" {
	type = "string"
	default = "2"
}

variable "nginx_instance_type" {
	type = "string"
	default = "t2.micro"
}

// VPC

variable "az1" {
	type = "string"
	default = "0"
}

variable "az2" {
	type = "string"
	default = "1"
}

variable "cidr" {
	type = "string"
	default = "10.50.0.0/16"
}

variable "public1_cidr" {
	type = "string"
	default = "10.50.102.0/24"
}

variable "public2_cidr" {
	type = "string"
	default = "10.50.101.0/24"
}

variable "private1_cidr" {
	type = "string"
	default = "10.50.1.0/24"
}

variable "private2_cidr" {
	type = "string"
	default = "10.50.2.0/24"
}

variable "private3_cidr" {
	type = "string"
	default = "10.50.3.0/24"
}

variable "private4_cidr" {
	type = "string"
	default = "10.50.4.0/24"
}