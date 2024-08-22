# A puppet file that changes a line in wp-settings.php file

exec { 'sed -i "s/15/5000/g" /etc/default/nginx':
  path => 'usr/bin:/usr/sbin:/bin',
}

exec { 'service nginx restart':
  path => '/usr/bin:/usr/sbin:/bin',
}
