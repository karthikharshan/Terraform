variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
  default = "us-east-1"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}

variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-0323c3dd2da7fb37d"
    us-west-2 = "ami-0ded0751341bcc45b"
    eu-west-1 = "ami-0891f7a45df1824df"
  }
}

variable "MIN_SIZE" {
	default = 2
	}
variable "MAX_SIZE" {
	default = 2
	}
variable "D_CAPACITY" {
	default = 2
	}
