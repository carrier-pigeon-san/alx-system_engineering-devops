# Manifest for installing and configuring nginx
# Nginx listens to port 80
# HTTP GET request to root returns string 'Hello World!'
# Permanent redirect directive for '/redirect_me' directory

exec { 'apt-update':
  command => 'apt update -y',
  path    => '/usr/bin:/usr/sbin:/bin',
}

package { 'nginx':
  ensure   => installed,
  provider => 'apt',
  require  => Exec['apt-update'],
}

service { 'nginx':
  ensure  => running,
  enable  => true,
  require => Package['nginx'],
}

file { '/var/www/html/index.html':
  ensure => file,
  path   => '/tmp/school',
  mode   => '0755',
}

exec { 'add-nginx-redirect':
  command => "sed -i '/server_name/a\\\\n\\trewrite ^/redirect_me https://medium.com/@obaresandy/ permanent;' example",
  path    => '/usr/bin:/usr/sbin:/bin',
  unless  => "grep -q 'rewrite ^/redirect_me' example",
  require => Service['nginx'],
  notify  => Service['nginx'],
}

exec { 'nginx-reload':
  command    => 'nginx -s reload',
  path       => '/usr/bin:/usr/sbin:/bin',
  privileged => true,
  require    => Service['nginx'],
  notify     => Service['nginx'],
}
