###########################
# PyroCMS Vagrant Config  #
# Setup: Default (LAMP)   #
###########################

include apache
include mysql
include php

class {'apache::php': }

apache::vhost { 'local.pyrocms':
	priority => '20',
	port => '80',
	docroot => '/vagrant/src/',
	configure_firewall => false,
}

# Extensions
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

# PHPUnit
$extras = ['vim', ]
package { $extras : ensure => 'installed' }