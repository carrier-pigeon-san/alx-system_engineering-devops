# A puppet manifest that installs flask from pip3
# Version 2.1.0

package { 'Werkzeug':
  ensure   => '3.0.3',
  provider => 'pip3',
}

package { 'flask':
  ensure   => '2.1.0',
  provider => 'pip3',
}
