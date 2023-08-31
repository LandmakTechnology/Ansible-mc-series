**Examples of Ad-hoc Commands**

$ ansible all -m ping          

$ ansible all -a "cat /etc/passwd"     

$ ansible all -a "cat /etc/passwd | tail -3" 

$ ansible all -m shell -a "cat /etc/passwd | tail -3" 

$ ansible db -m copy -a 'src=/source/file/path dest=/dest/location'

$ ansible db -m copy -a 'src=/source/file/path  dest=/dest/location remote_src = yes'

$ ansible all -m debug -a 'var=inventory_hostname' 

$ ansible all -m debug -a 'msg={{inventory_hostname}}'
