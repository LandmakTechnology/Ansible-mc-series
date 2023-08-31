variable "aws_region" {
  type    = string
  default = "us-west-1"
}

variable "my_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "my_key" {
  type    = string
  default = "ansible-key"
}

#sudo su - ansible
#chown -R ansible:ansible /etc/ansible


