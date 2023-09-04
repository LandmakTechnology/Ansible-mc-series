**Dynamic Inventory**

- Ansible comes with various dynamic inventory plugins one of those being aws_ec2. 
- The aws_ec2 plugin is a great way to manage AWS EC2 Linux instances without having to maintain a standard local inventory. 
- This will allow for easier Linux automation, configuration management, and infrastructure as code of AWS EC2 instances.
- In order to use the aws_ec2 plugin, the following requirements have to be met;

     - When naming the plugin, the suffix portion of the name must be:
          **_aws_ec2.yml or _aws_ec2.yaml**

   For example:

        production_useast_aws_ec2.yml
        production_uswest_aws_ec2.yml
        test_dev_aws_ec2.yml
        production_aws_ec2.yml

    - Each individual configuration file from above could have its own aws_access_key and aws_secret_key pointing to individual AWS accounts that separate production, test/dev, etc. All of these individual configuration files can be placed within the ./ansible_plugin directory.

    - If you have the ansible.cfg with inventory = ./ansible_plugins you will be able to view AWS EC2 inventory based on the aws_ec2 plugin configuration file with the following command:

           $ ansible-inventory --list --yaml

**Static and Dynamic Inventory:**

- A static inventory file is a plain text file containing a list of managed hosts or remote nodes whose numbers and IP addresses remain fairly constant.

- On the other hand, a dynamic host file keeps changing as you add new hosts or decommission old ones.
- The IP addresses of hosts are also dynamic as you stop and start new host systems.

**Ansible Dynamic Inventory for AWS:**

**1) Script**
 
- Search for the ec2.py script.

 - Install boto /boto3 -SDK

- You can use this script in one of two ways.

  a) Ansible’s -i command-line option and specify the path to the script after marking it executable

       $ ansible -i ec2.py -u ubuntu us-east-a -m ping

  b) The second option is to copy the script to /etc/ansible/hosts and chmod +x it. You must also copy the ec2.ini file to /etc/ansible/ec2.ini.
  Then you can run ansible as you would normally.

- To make a successful API call to AWS, you must configure Boto (the Python interface to AWS). You can do this in several ways available,
 but the simplest is by exporting two environment variables like follows.

      export AWS_ACCESS_KEY_ID='AK123'
      export AWS_SECRET_ACCESS_KEY='abc123'


- After downloading the 2 scripts and configuring boto/boto3, in your terminal simply type ec2.py --list

 Note*: Dynamic inventory brings all the instances across all the regions in your AWS account, so no need to specify the region

**2) aws_ec2 plugin:**

- Requirements
    - Install python3-boto3
```
sudo apt-get update -y
sudo apt-get install -y python3-boto3
```

- Install plugin
```
   $ ansible-galaxy collection install amazon.aws
```

- Create an inventory file which must end with   - aws_ec2.yml/yaml
- Attach a role on your server to make api calls to aws
- Configure ansible.cfg file to read inventory from the plugin
- test the configuration

       $ ansible-inventory --list

**Example of aws_ec2 plugin**
```
# Run the command <$ansible-galaxy collection install amazon.aws> to install the plugin
# Create the inventory file that ends with <aws_ec2.yml/yaml> and use the examples in the ansible documentation to configure it.
# Configure the ansible.cfg file to read the inventory from the aws_ec2.yaml file
plugin: aws_ec2
regions:
  - us-west-2
keyed_groups:
  - key: hostname
    prefix: ip-address
  - key: placement.region
    prefix: aws_region
  - key: tags.Type
    separator: ''
  - key: tags.Name
    separator: ''
hostnames:
  - ip-address
  - dns-name
  - tag:Type
  - tag:Name
  - private-ip-address
```

In the ansible.cfg file set the defaults to:
```
inventory = ./aws_ec2.yaml
host_key_checking = False
```