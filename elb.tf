resource "aws_elb" "my_elb" {
  name           = "my-elb"
  subnets        = [aws_subnet.public_subnet_main-1.id, aws_subnet.public_subnet_main-2.id]
  security_groups = [aws_security_group.elb_sg.id]
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 3
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }
  cross_zone_load_balancing   = true
  connection_draining         = true
  connection_draining_timeout = 400
  tags = {
    Name = "my_elb"
  }

}
