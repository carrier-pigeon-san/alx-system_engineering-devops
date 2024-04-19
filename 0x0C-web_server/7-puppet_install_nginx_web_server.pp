# Manifest for installing and configuring nginx
# Nginx listens to port 80
# HTTP GET request to root returns string 'Hello World!'
# Permanent redirect directive for '/redirect_me' directory

exec { 'apt-update':
  command => 'apt update -y',
  path    => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
}

exec { 'nginx-install':
  command    => 'apt install nginx -y',
  path       => '/usr/bin:/usr/sbin:/bin',
  unless     => 'dpkg -l | grep nginx',
  privileged => true,
  require    => Exec['apt-update'],
}

exec { 'start-nginx':
  command    => 'service nginx start',
  path       => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
  privileged => true,
  require    => Exec['nginx-install'],
}

file { '/var/www/html/index.html':
  ensure  => file,
  path    => '/var/www/html/index.html',
  mode    => '0755',
  content => 'Hello World!',
}

exec { 'add-nginx-redirect':
  command => "sed -i '/server_name/a\\\n\trewrite ^/redirect_me$ https://medium.com/@obaresandy/ permanent;' /etc/nginx/sites-available/default",
  path    => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
  unless  => "grep -q 'rewrite ^/redirect_me' /etc/nginx/sites-available/default",
  require => Service['nginx'],
  notify  => Service['nginx'],
}

exec { 'nginx-reload':
  command    => 'nginx -s reload',
  path       => '/usr/bin:/usr/sbin:/bin/usr/local/bin',
  privileged => true,
  require    => Service['nginx'],
  notify     => Service['nginx'],
}
