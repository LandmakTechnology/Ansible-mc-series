**Ansible Roles**

- Roles let you automatically load related vars,files,tasks, handlers, and other known Ansible artifacts based on a known file structure.
- After you group your content in roles, you can easily reuse them and share them with other users.
**How to create an Ansible Role**
- You can create an ansible role by running the command below.

      $ ansible-galaxy init httpd --offline
- We need to pass the --offline option so that ansible does now initialize the role from the ansible registry. 
- This is done when we want to create a custom role.
- After you initialize the role, cd into the various directories and vi into the main.yml file to enter the content.

**Role directory structure**
- An Ansible role has a defined directory structure with eight main standard directories.

- You must include at least one of these directories in each role. You can omit any directories the role does not use.

- By default Ansible will look in each directory within a role for a main.yml file for relevant content

```
tasks/main.yml - the main list of tasks that the role executes.

handlers/main.yml - handlers, which may be used within or outside this role.

library/my_module.py - modules, which may be used within this role (see Embedding modules and plugins in roles for more information).

defaults/main.yml - default variables for the role. These variables have the lowest priority of any variables available, and can be easily overridden by any other variable, including inventory variables.

vars/main.yml - other variables for the role (see Using Variables for more information).

files/main.yml - files that the role deploys.

templates/main.yml - templates that the role deploys.

meta/main.yml - metadata for the role, including role dependencies.
```

- You can also add other YAML files in some directories. For example, you can place platform-specific tasks in separate files and refer to them in the tasks/main.yml file:

```
# roles/example/tasks/main.yml
- name: Install the correct web server for RHEL
  import_tasks: redhat.yml
  when: ansible_facts['os_family']|lower == 'redhat'

- name: Install the correct web server for Debian
  import_tasks: debian.yml
  when: ansible_facts['os_family']|lower == 'debian'

# roles/example/tasks/redhat.yml
- name: Install web server
  ansible.builtin.yum:
  name: "httpd"
  state: present

# roles/example/tasks/debian.yml
- name: Install web server
  ansible.builtin.apt:
  name: "apache2"
  state: present
```

- By default, Ansible looks for roles in two locations:

   - In a directory called roles/, relative to the playbook file in /etc/ansible/roles

**You can use roles in three ways:**

- At the play level with the roles option: This is the classic way of using roles in a play.

- At the tasks level with include_role: You can reuse roles dynamically anywhere in the tasks section of a play using include_role.

- At the tasks level with import_role: You can reuse roles statically anywhere in the tasks section of a play using import_role

