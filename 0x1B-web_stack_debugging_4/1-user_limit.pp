# This manifest resets holberton user's nofile limits in /etc/security/limits.conf file

exec { 'sed -i "s/nofile 5/nofile 5000/g" /etc/security/limits.conf':
  path => 'usr/bin:/usr/sbin:/bin',
}

exec { 'sed -i "s/nofile 4/nofile 4000/g" /etc/security/limits.conf':
  path => 'usr/bin:/usr/sbin:/bin',
}
