# Manifest creates a file in /tmp
# File name: school
# File permissions: 0744
# File owner: www-data
# File group: www-data
# Content: 'I love puppet'

file { '/tmp/school':
  ensure  => file,
  path    => '/tmp/school',
  owner   => 'www-data',
  group   => 'www-data',
  mode    => '0744',
  content => 'I love Puppet',
}
