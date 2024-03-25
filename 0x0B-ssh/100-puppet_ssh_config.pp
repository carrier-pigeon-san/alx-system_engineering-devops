# Manifest makes changes to client SSH configuration file such that the client
# can connect to a server without need for a password authentication
# Puppet resource: exec
# Command: sed

exec { "sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config":
  path => '/usr/bin:/usr/sbin:/bin',
}
