###########################
# PyroCMS Puppet Config   #
###########################
# OS          : Linux     #
# Database    : MySQL 5   #
# Web Server  : Apache 2  #
# PHP version : 5.3       #
###########################

include apache
include php
include mysql

$docroot = '/vagrant/www/pyrocms/'

# Apache setup
class {'apache::php': }

apache::vhost { 'local.pyrocms':
	priority => '20',
	port => '80',
	docroot => $docroot,
	configure_firewall => false,
}

a2mod { 'rewrite': ensure => present; }

# PHP Extensions
php::module { ['xdebug', 'mysql', 'curl', 'gd'] : 
    notify => [ Service['httpd'], ],
}
php::conf { [ 'pdo', 'pdo_mysql']:
    require => Package['php5-mysql'],
    notify  => Service['httpd'],
}

# MySQL Server
class { 'mysql::server':
  config_hash => { 'root_password' => 'l1k3ab0ss' }
}

mysql::db { 'pyrocms':
    user     => 'pyrocms',
    password => 'password',
    host     => 'localhost',
    grant    => ['all'],
    charset => 'utf8',
}

# Other Packages
$extras = ['vim', 'curl', 'phpunit']
package { $extras : ensure => 'installed' }

# PyroCMS Setup

file { $docroot:
    ensure  => 'directory',
}

file { "${docroot}system/cms/config/config.php":
    ensure  => "present",
    mode    => "0666",
    require => File[$docroot],
}

$writeable_dirs = ["${docroot}system/cms/cache/", "${docroot}system/cms/config/", "${docroot}addons/", "${docroot}assets/cache/", "${docroot}uploads/"]

file { $writeable_dirs:
    ensure => "directory",
    mode   => '0777',
    require => File[$docroot],
}