add-content -path c:/users/Ken/.ssh/config -value @'

Host ${user}
   HostName ${hostname}
   User ${user}
   IdentityFile ${IdentityFile}
'@