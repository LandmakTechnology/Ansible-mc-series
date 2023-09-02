**Ansible Playbooks**

- Ansible Playbooks offer a repeatable, re-usable, simple configuration management and multi-machine deployment system, one that is well suited to deploying complex applications. 
- If you need to execute a task with Ansible more than once, write a playbook and put it under source control. Then you can use the playbook to push out new configuration or confirm the configuration of remote systems.
- Playbooks can:
    - declare configurations
    - orchestrate steps of any manual ordered process, on multiple sets of machines, in a defined order
    - launch tasks synchronously or asynchronously

- Playbooks record and execute Ansible’s configuration, deployment, and orchestration functions. 
- They can describe a policy you want your remote systems to enforce, or a set of steps in a general IT process.
- If Ansible modules are the tools in your workshop, playbooks are your instruction manuals, and your inventory of hosts are your raw material.
- At a basic level, playbooks can be used to manage configurations of and deployments to remote machines. At a more advanced level, they can sequence multi-tier rollouts involving rolling updates,
  and can delegate actions to other hosts, interacting with monitoring servers and load balancers along the way.
- Playbooks are designed to be human-readable and are developed in a basic text language. There are multiple ways to organize playbooks and the files they include.

**Playbook syntax**

- Playbooks are expressed in YAML format with a minimum of syntax.
- A playbook is composed of one or more ‘plays’ in an ordered list. 
- The terms ‘playbook’ and ‘play’ are sports analogies. Each play executes part of the overall goal of the playbook, running one or more tasks. Each task calls an Ansible module.
- A playbook runs in order from top to bottom. Within each play, tasks also run in order from top to bottom.
- Playbooks with multiple ‘plays’ can orchestrate multi-machine deployments, running one play on your webservers, then another play on your database servers, then a third play on your network infrastructure, and so on.
- At a minimum, each play defines two things:
   - the managed nodes to target, using a pattern
   - at least one task to execute

**Ansible task execution**

- By default, Ansible executes each task in order, one at a time, against all machines matched by the host pattern. 
- Each task executes a module with specific arguments. When a task has executed on all target machines, Ansible moves on to the next task.
- When you run a playbook, Ansible returns information about connections, the name lines of all your plays and tasks, whether each task has succeeded or failed on each machine, and whether each task has made a change on each machine. 
- At the bottom of the playbook execution, Ansible provides a summary of the nodes that were targeted and how they performed. 
- General failures and fatal “unreachable” communication attempts are kept separate in the counts.

   **Desired state and ‘idempotency’**

- Most Ansible modules check whether the desired final state has already been achieved, and exit without performing any actions if that state has been achieved, so that repeating the task does not change the final state. 
- Modules that behave this way are often called ‘idempotent.’ Whether you run a playbook once, or multiple times, the outcome should be the same.

**Yaml basics**

- For Ansible, nearly every YAML file starts with a list. 
- Each item in the list is a list of key/value pairs, commonly called a “hash” or a “dictionary”. 
- So, we need to know how to write lists and dictionaries in YAML.
- All YAML files can optionally begin with --- and end with ... . This is part of the YAML format and indicates the start and end of a document.
- All members of a list are lines beginning at the same indentation level starting with a "- " (a dash and a space):
```
---
# A list of tasty fruits - Apple
  - Orange
  - Strawberry
  - Mango
...
```

- A dictionary is represented in a simple key: value form (the colon must be followed by a space): 
```
# An employee record martin:
  name: Martin D'vloper 
  job: Developer
  skill: Elite
```

**Sample playbook**
```
---
 - name: sonarqube playbook
   hosts: sonarqube become: yes
   tasks:
 - name: install java
   yum:
     name: java-1.8.0-openjdk-devel.x86_64 state: present
 - name: create /opt/sonarqube directory file:
   path: /opt/sonarqube state: directory
 - name: Download and Unarchive/ unzip Sonarqube ansible.builtin.unarchive:
   src: https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-7.8.zip dest: /opt/sonarqube
   remote_src: yes
 - name: move sonarqube-7.8
   command: rm -rf sonarqube-7.8.zip && mv sonarqube-7.8 sonarqube
 - name: Add a sonar user shell: useradd sonar
 - name: Give sudo rights to sonar user
   shell: echo "sonar ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/sonar
 - name: Recursively change ownership and permission of a directory file:
   dest: /opt/sonarqube/ owner: sonar
   group: sonar mode: 0775 recurse: yes
 - name: start sonarqube
   shell: sh /opt/sonarqube/sonarqube-7.8/bin/linux-x86-64/sonar.sh start become: yes
   become_user: sonar
```