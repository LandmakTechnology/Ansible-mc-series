**Managing dependencies between ansible tasks in a playbook**
- Task dependencies can be managed by use of conditions that specify task execution based on the changes that occur within dependent tasks.
**a) Playbook with conditions**
```
---
 - name: Installing httpd
   hosts: db
   become: yes
   tasks:
   - name: Install hpptd
     yum:
       name: httpd
       state: present
     register: out
   - debug: var=out.changed
   - name: start httpd
     service:
       name: httpd
       state: started
     when: out.changed == True
```

**b) Playbook with handlers**
- Handlers are just like ordinary tasks, but they are only called when notified.
- The notification only happens if we have a change in the dependent task.

```
---
 - name: Installing httpd
   hosts: db
   become: yes
   tasks:
   - name: Install hpptd
     yum:
       name: httpd
       state: present
     notify:
       - start httpd
   handlers:
   - name: start httpd
     service:
       name: httpd
       state: started
```
