**How to write and ansible playbook**

- Ansible playbooks are written in yaml.

- Consider the adhoc command below:

     **ansible db -m apt -a "name=apache2 state=present" -b**

- This can be written as;
```
---
 - hosts: db
   tasks:
   - apt: name=apache2 state=present
     become: yes
```

- This can be further refined as follows;
```
---
 - name: Install apache2
   hosts: db
   tasks:
   - name: apache2
     apt:
        name: apache2
        state: present
     become: yes
```

- A service module can also be included to start apache with become on task level as follows;
```
---
 - name: Install apache2
   hosts: db
   tasks:
   - name: install apache2
     apt:
        name: apache2
        state: present
     become: yes
   - name: start apache2
     service:
       name: apache2
       state: started
     become: yes
```
- You can use become on a host level as shown below;
```
---
 - name: Install apache2
   hosts: db
   become: yes
   tasks:
   - name: install apache2
     apt:
        name: apache2
        state: present
   - name: start apache2
     service:
       name: apache2
       state: started
```