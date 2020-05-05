output "elb_dns"{
	value = aws_elb.my_elb.dns_name
}
