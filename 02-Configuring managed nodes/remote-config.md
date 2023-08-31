**Setting up remote ansible server**
1. Configure remote ssh on vscode with user as ubuntu
2. Log into the remote server as ubuntu and switch user to ansible

        $ sudo su - ansible
3. Create .ssh directory in the home of ansible
   
        $ sudo mkdir .ssh
        $ sudo chown -R ansible:ansible .ssh
4. Copy the authorized keys from the home of ubuntu to the home of ansible
  - cd into the .ssh directory and run the command below.

        $ sudo cp /home/ubuntu/.ssh/authorized_keys .

  - Change ownership of the key to ansible

         $ sudo chown ansible:ansible authorized_keys
5. Also change the ownership of /etc/ansible from root to ansible

        $ sudo chown -R ansible:ansible /etc/ansible
6. Now change the default user in the vscode config to log in as ansible
```
Host Ansible
    HostName 54.183.22.101
    User ansible
    IdentityFile ~/Downloads/ansible-key.pem
```

7. You can use the script below to install vscode on ubuntu using the script below.
```   
   sudo apt update
   sudo apt upgrade -y
   sudo apt install software-properties-common apt-transport-https wget -y
   wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
   sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" -y
   sudo apt install code -y
```