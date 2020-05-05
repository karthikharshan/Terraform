#Launching Configuration
resource "aws_launch_configuration" "my_launchconfig" {
  name_prefix   = "my_launchconfig"
  image_id      = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"
  key_name      = aws_key_pair.mykeypair.key_name
  user_data     = "#!/bin/bash\nsudo yum update\nsudo yum -y install httpd\necho 'Example Page' > /var/www/html/index.html"
   lifecycle {
    create_before_destroy = true
  }

}

resource "aws_autoscaling_group" "my_autoscaling" {
  name                      = "my_autoscaling"
  vpc_zone_identifier       = [aws_subnet.public_subnet_main-1.id, aws_subnet.public_subnet_main-2.id]
  launch_configuration      = aws_launch_configuration.my_launchconfig.name
  min_size                  = var.MIN_SIZE
  max_size                  = var.MAX_SIZE
  desired_capacity          = var.D_CAPACITY
  health_check_grace_period = 300
  health_check_type         = "ELB"
  load_balancers            = [aws_elb.my_elb.name]
  force_delete              = true

  tag {
    key                 = "Name"
    value               = "ec2 instance"
    propagate_at_launch = true
  }

}

