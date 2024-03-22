# Manifest kills a process named killmenow
# Puppet resource: exec
# Command: pkill

exec { 'pkill killmenow':
  path => '/usr/bin:/usr/sbin:/bin',
}
