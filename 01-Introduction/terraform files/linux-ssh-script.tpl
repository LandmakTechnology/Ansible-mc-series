cat << EOF >> ~/.ssh/config

Host ${user}
   HostName ${hostname}
   User ${user}
   IdentityFile ${IdentityFile}
EOF