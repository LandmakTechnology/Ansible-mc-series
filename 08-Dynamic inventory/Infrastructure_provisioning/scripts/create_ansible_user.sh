#!/bin/bash
sudo useradd -d /home/ansible -s /bin/bash -m ansible
echo "ansible  ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/ansible
sudo sed -re 's/^(PasswordAuthentication)([[:space:]]+)yes/\1\2no/' -i.`date -I` /etc/ssh/sshd_config
sudo service sshd restart
