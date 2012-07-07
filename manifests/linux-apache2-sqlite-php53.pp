###########################
# PyroCMS Puppet Config   #
###########################
# OS          : Linux     #
# Database    : SQLite 3  #
# Web Server  : Apache 2  #
# PHP version : 5.3       #
###########################

include apache
include sqlite
include php

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
package { 'php5-sqlite' : ensure => 'installed' }

php::module { ['xdebug', 'curl', 'gd'] : 
    notify => [ Service['httpd'], ],
}
php::conf { [ 'sqlite', 'pdo', ]:
    require => Package['sqlite'],
    notify  => Service['httpd'],
}

# SQLite

define sqlite::db(
    $location   = '',
    $owner      = 'root',
    $group      = 0,
    $mode       = '755',
    $ensure     = present,
    $sqlite_cmd = 'sqlite3'
  ) {

  $safe_location = $location ? {
    ''      => "/vagrant/db/pyrocms.db",
    default => $location,
  }

  file { $safe_location:
    ensure => $ensure,
    owner  => $owner,
    group  => $group,
    notify => Exec["create_pyrocms_db"],
  }

  exec { "create_pyrocms_db":
    command     => "${sqlite_cmd} $safe_location",
    path        => '/usr/bin:/usr/local/bin',
    refreshonly => true,
  }
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