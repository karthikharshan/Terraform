#Security Group for Instances
resource "aws_security_group" "instance_sg" {
  vpc_id      = aws_vpc.main.id
  name        = "instance_sg"
  description = "security group that allows ssh and http to elb"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.elb_sg.id]
  }

  tags = {
    Name = "Instance SG"
  }
}

#Security Group for ELB
resource "aws_security_group" "elb_sg" {
  vpc_id      = aws_vpc.main.id
  name        = "elb_sg"
  description = "security group that allows http and all egress traffic"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ELB SG"
  }
}
