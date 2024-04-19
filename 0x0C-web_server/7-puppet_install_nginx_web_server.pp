# Manifest for installing and configuring nginx
# Nginx listens to port 80
# HTTP GET request to root returns string 'Hello World!'
# Permanent redirect directive for '/redirect_me' directory

exec { 'apt-update':
  command    => 'apt update -y',
  path       => '/usr/bin:/usr/sbin:/bin',
  privileged => true,
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

exec { 'write-html-file':
  command    => 'echo "Hello World!" > /var/www/html/index.html',
  path       => '/bin:/usr/bin:/usr/sbin:/usr/local/bin',
  privileged => true,
}

exec { 'add-nginx-redirect':
  command    => "sed -i '/server_name/a\\\\n\\trewrite ^/redirect_me https://medium.com/@obaresandy/ permanent;' example",
  path       => '/usr/bin:/usr/sbin:/bin',
  unless     => "grep -q 'rewrite ^/redirect_me' example",
  privileged => true,
  require    => Service['nginx'],
  notify     => Service['nginx'],
}

exec { 'nginx-reload':
  command    => 'nginx -s reload',
  path       => '/usr/bin:/usr/sbin:/bin',
  privileged => true,
  require    => Service['nginx'],
  notify     => Service['nginx'],
}
