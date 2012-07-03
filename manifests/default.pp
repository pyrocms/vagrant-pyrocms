###########################
# PyroCMS Vagrant Config  #
# Setup: Default (LAMP)   #
###########################

include apache
include mysql
include php

$docroot = '/home/vagrant/www/'

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
    notify => [ Service['apache2'], ],
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
$extras = ['vim', 'curl', 'git']
package { $extras : ensure => 'installed' }

# PyroCMS Setup

file { $docroot:
    ensure  => 'directory',
    owner   => 'vagrant',
    group   => 'vagrant',
}

exec { "pyrocms":
    command => "/usr/bin/git clone git://github.com/pyrocms/pyrocms.git ${docroot}",
    require => [ File[$docroot], Package["git"] ],
}

exec { "pyrocms-cloned":
    command => "test -d ${docroot}cms/",
    require => [ Exec['pyrocms'] ],
}

file { "${docroot}system/cms/config/config.php":
    ensure  => "present",
    mode    => "0666",
    owner   => $apache::params::user,
    group   => $apache::params::group,
    require => Exec["pyrocms-cloned"],
}

$writeable_dirs = ["${docroot}system/cms/cache/", "${docroot}system/cms/config/", "${docroot}addons/", "${docroot}assets/cache/", "${docroot}uploads/"]

file { $writeable_dirs:
    ensure => "directory",
    mode   => '0777',

    require => Exec["pyrocms-cloned"],
}