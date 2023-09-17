#!/bin/bash

sudo mkdir /home/ansible/.ssh/
sudo chown -R ansible:ansible /home/ansible/.ssh
sudo cp /home/ubuntu/.ssh/authorized_keys /home/ansible/.ssh/
sudo chown ansible:ansible /home/ansible/.ssh/authorized_keys
sudo chown -R ansible:ansible /etc/ansible