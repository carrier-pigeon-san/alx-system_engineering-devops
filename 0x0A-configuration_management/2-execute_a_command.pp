# Manifest kills a process named killmenow
# Puppet resource: exec
# Command: pkill

exec { 'pkill killmenow':
  command => 'pkill killmenow',
}
