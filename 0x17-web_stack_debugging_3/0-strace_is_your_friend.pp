# A puppet file that changes a line in wp-settings.php file

exec { 'sed -i "s/phpp/php/g" /var/www/html/wp-settings.php':
  path => 'usr/bin:/usr/sbin:/bin',
}
