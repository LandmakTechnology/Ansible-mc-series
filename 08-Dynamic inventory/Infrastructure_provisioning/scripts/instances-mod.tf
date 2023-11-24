

#6. Create a kubernetes master instance.
resource "aws_instance" "Kubernetes_Servers" {
  count                  = 1
  ami                    = var.kubernetes_ami
  instance_type          = var.medium_instance_type
  vpc_security_group_ids = [aws_security_group.kubernetes_sg.id]
  subnet_id              = element(aws_subnet.kubernetes_subnets.*.id, count.index)
  key_name               = var.key_name
  #user_data        = file("create_ansible_user.sh")
  tags = {
    Name = "Kubernetes_Servers"
    Type = "Kubernetes_Master"
  }
}



#10. Create kubernetes worker nodes.
resource "aws_instance" "Kubernetes_Workers" {
  count                  = 2
  ami                    = var.kubernetes_ami
  instance_type          = var.micro_instance_type
  vpc_security_group_ids = [aws_security_group.kubernetes_sg.id]
  subnet_id              = element(aws_subnet.kubernetes_subnets.*.id, count.index)
  key_name               = var.key_name
  #user_data              = file("create_ansible_user.sh")
  tags = {
    Name = "Kubernetes_Servers"
    Type = "Kubernetes_Worker"
  }
}


#14. Create Jenkins worker nodes.
resource "aws_instance" "jenkins_worker" {
  count                  = 1
  ami                    = var.server_ami
  instance_type          = var.micro_instance_type
  vpc_security_group_ids = [aws_security_group.kubernetes_sg.id]
  subnet_id              = element(aws_subnet.kubernetes_subnets.*.id, count.index)
  key_name               = var.key_name
  tags = {
    Name = "jenkins_server"
    Type = "jenkins_worker"
  }
}
#15. Create a sonarQube server
resource "aws_instance" "sonarQube_worker" {
  count                  = 1
  ami                    = var.server_ami
  instance_type          = var.medium_instance_type
  vpc_security_group_ids = [aws_security_group.kubernetes_sg.id]
  subnet_id              = element(aws_subnet.kubernetes_subnets.*.id, count.index)
  key_name               = var.key_name

  tags = {
    Name = "SonarQube_server"
    Type = "sonarQube_worker"
  }
}
#16. Create Nexus server.
resource "aws_instance" "nexus_worker" {
  count                  = 1
  ami                    = var.server_ami
  instance_type          = var.medium_instance_type
  vpc_security_group_ids = [aws_security_group.kubernetes_sg.id]
  subnet_id              = element(aws_subnet.kubernetes_subnets.*.id, count.index)
  key_name               = var.key_name

  tags = {
    Name = "Nexus_server"
    Type = "nexus_worker"
  }
}
#17. Create a Tomcat server .
resource "aws_instance" "tomcat_worker" {
  count                  = 1
  ami                    = var.server_ami
  instance_type          = var.micro_instance_type
  vpc_security_group_ids = [aws_security_group.kubernetes_sg.id]
  subnet_id              = element(aws_subnet.kubernetes_subnets.*.id, count.index)
  key_name               = var.key_name

  tags = {
    Name = "Tomcat_server"
    Type = "tomcat_worker"
  }
}
