# Manifest installs flask from pip3
# Package version: 2.1.0

package { 'Flask':
  ensure   => '2.1.0',
  provider => 'pip3',
}
