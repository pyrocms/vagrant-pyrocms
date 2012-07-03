###########################
# PyroCMS Vagrant Config  #
# Setup: Default (LAMP)   #
###########################

include apache
include mysql
include php

$docroot = '/vagrant/pyrocms/'

# Apache setup
class {'apache::php': }

apache::vhost { 'local.pyrocms':
	priority => '20',
	port => '80',
	docroot => $docroot,
	configure_firewall => false,
}

# PHP Extensions
php::module { ['xdebug', 'mysql', 'curl', 'gd'] : 
    notify => [ Service['httpd'], ],
}

# PHPUnit
package { 'php-pear' : ensure => 'installed' }

exec { "phpunit":
    command => "/usr/bin/pear upgrade pear && \
                /usr/bin/pear channel-discover pear.phpunit.de && \
                /usr/bin/pear channel-discover components.ez.no && \
                /usr/bin/pear channel-discover pear.symfony-project.com && \
                /usr/bin/pear install --alldeps phpunit/PHPUnit",
    creates => "/usr/bin/phpunit",
    require => Package["php-pear"],
}

# MySQL Server
class { 'mysql::server':
  config_hash => { 'root_password' => 'sn3aky' }
}

mysql::db { 'pyrocms':
    user     => 'pyrocms',
    password => 'password',
    host     => 'localhost',
    grant    => ['all'],
    charset => 'utf8',
}

# Other Packages
$extras = ['vim', 'curl']
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