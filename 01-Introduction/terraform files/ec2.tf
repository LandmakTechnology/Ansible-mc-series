#resource block
resource "aws_instance" "ubuntu" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.my_instance_type
  #user_data     = file("${path.module}/ansible-install-ubuntu.sh")
  user_data = data.template_cloudinit_config.user-data.rendered

  key_name      = var.my_key

  tags = {
    "Name" = "Ansible-Ubuntu"
  }
}


resource "aws_instance" "ubuntu-hosts" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.my_instance_type
  user_data     = file("${path.module}/create_ansible_user.sh")
  key_name      = var.my_key
  count         = 2
  tags = {
    "Name" = "My-Ubuntu-${count.index}"
    "Type" = "My-Ubuntu-${count.index}"
  }
}

resource "aws_instance" "rhel-hosts" {
  ami           = data.aws_ami.rhel.id
  instance_type = var.my_instance_type
  user_data     = file("${path.module}/create_ansible_user.sh")
  key_name      = var.my_key
  count         = 1
  tags = {
    "Name" = "My-rhel-${count.index}"
  }
}


data "template_cloudinit_config" "user-data" {
  part {
    content_type = "text/x-shellscript"
    content  = file("${path.module}/ansible-install-ubuntu.sh")
  }
  part {
    content_type = "text/x-shellscript"
    content  = file("${path.module}/vscode-install.sh")
  }
}