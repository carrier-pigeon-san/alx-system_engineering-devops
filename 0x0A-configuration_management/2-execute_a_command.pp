# This manifest kills a process named killmenow
# exec puppet resource
# pkill command

exec { 'pkill killmenow':
  path => '/usr/bin/',
}
